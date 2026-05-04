/**
 * DRAIS Marks Migration Engine
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * 
 * Provides transaction-safe migration of marks from one subject to another
 * within a specific class, with full conflict detection, preview, and rollback.
 * 
 * ARCHITECTURE:
 * - Atomic transactions (all-or-nothing)
 * - Comprehensive audit trail
 * - Conflict detection and resolution strategies
 * - Learner-by-learner preview before execution
 * - Rollback capability via reverse transaction log
 */

import { getConnection } from '@/lib/db';
import { logAudit, AuditAction } from '@/lib/audit';

// ─────────────────────────────────────────────────────────────────────────────
// Type Definitions
// ─────────────────────────────────────────────────────────────────────────────

export interface MigrationAnalysisParams {
  schoolId: number;
  sourceClassId: number;
  sourceAcademicYearId: number;
  sourceTermId: number;
  sourceSubjectId: number;
  sourceResultTypeId: number;
  destinationClassId: number;
  destinationAcademicYearId: number;
  destinationTermId: number;
  destinationSubjectId: number;
  destinationResultTypeId: number;
}

export interface LearnerMarkPreview {
  studentId: number;
  studentName: string;
  admissionNo: string;
  currentSourceMark: number | null;
  currentDestinationMark: number | null;
  afterMigrationMark: number | null;
  hasConflict: boolean;
  conflictReason?: string;
}

export interface MigrationAnalysis {
  totalLearnersAffected: number;
  learnersWithMarks: number;
  assessmentsInvolved: string[];
  conflictCount: number;
  conflicts: LearnerMarkPreview[];
  noConflicts: LearnerMarkPreview[];
  destinationHasExistingMarks: number;
  preview: LearnerMarkPreview[];
}

export interface MigrationExecutionRequest extends MigrationAnalysisParams {
  conflictResolution: 'overwrite' | 'skip' | 'merge';
  confirmedBy: number;
  reason?: string;
}

export interface MigrationResult {
  success: boolean;
  migrationId: string;
  recordsMigrated: number;
  conflictsResolved: number;
  skipped: number;
  timestamp: string;
  transactionId: string;
}

export interface MigrationAuditRecord {
  id: string;
  schoolId: number;
  performedBy: number;
  action: 'MIGRATED_MARKS' | 'ROLLED_BACK_MIGRATION';
  sourceClassId: number;
  sourceSubjectId: number;
  sourceAcademicYearId: number;
  sourceTermId: number;
  destinationClassId: number;
  destinationSubjectId: number;
  destinationAcademicYearId: number;
  destinationTermId: number;
  recordsAffected: number;
  conflictResolution: string;
  timestamp: string;
  details: Record<string, any>;
}

// ─────────────────────────────────────────────────────────────────────────────
// Analysis Engine: Preview Migration Impact
// ─────────────────────────────────────────────────────────────────────────────

export async function analyzeMigration(
  params: MigrationAnalysisParams
): Promise<MigrationAnalysis> {
  const connection = await getConnection();

  try {
    // Validation
    if (params.sourceSubjectId === params.destinationSubjectId) {
      throw new Error('Source and destination subjects must be different');
    }

    // Check that source and destination are in the same academic type
    const [sourceAcademicTypeRows] = await connection.execute(
      `SELECT DISTINCT academic_type FROM class_results
       WHERE class_id = ? AND subject_id = ? AND academic_year_id = ? AND term_id = ? AND result_type_id = ?
       LIMIT 1`,
      [params.sourceClassId, params.sourceSubjectId, params.sourceAcademicYearId, params.sourceTermId, params.sourceResultTypeId]
    ) as any[];

    if (sourceAcademicTypeRows.length > 0) {
      const sourceAcademicType = sourceAcademicTypeRows[0].academic_type;

      const [destAcademicTypeRows] = await connection.execute(
        `SELECT DISTINCT academic_type FROM class_results
         WHERE class_id = ? AND subject_id = ? AND academic_year_id = ? AND term_id = ? AND result_type_id = ?
         LIMIT 1`,
        [params.destinationClassId, params.destinationSubjectId, params.destinationAcademicYearId, params.destinationTermId, params.destinationResultTypeId]
      ) as any[];

      if (destAcademicTypeRows.length > 0) {
        const destAcademicType = destAcademicTypeRows[0].academic_type;
        if (sourceAcademicType !== destAcademicType) {
          throw new Error(`Cannot migrate between different academic types: ${sourceAcademicType} → ${destAcademicType}`);
        }
      }
    }

    // Get all learners in the class
    const [learnersRows] = await connection.execute(
      `SELECT DISTINCT 
        cr.student_id, 
        stu.admission_number,
        CONCAT(p.first_name, ' ', p.last_name) as student_name
      FROM class_results cr
      JOIN students stu ON cr.student_id = stu.id
      JOIN enrollments e ON stu.id = e.student_id
      JOIN people p ON stu.person_id = p.id
      WHERE e.class_id = ? 
        AND e.academic_year_id = ?
        AND e.status = 'active'
      ORDER BY p.first_name, p.last_name`,
      [params.sourceClassId, params.sourceAcademicYearId]
    ) as any[];

    const learnerPreviews: LearnerMarkPreview[] = [];
    const conflicts: LearnerMarkPreview[] = [];
    const assessments = new Set<string>();
    let destinationMarksCount = 0;

    // Analyze each learner's marks
    for (const learner of learnersRows) {
      // Get source subject marks
      const [sourceMarksRows] = await connection.execute(
        `SELECT score, grade, result_type_id FROM class_results
         WHERE student_id = ? 
           AND class_id = ?
           AND subject_id = ?
           AND term_id = ?
           AND academic_year_id = ?
           AND result_type_id = ?`,
        [
          learner.student_id,
          params.sourceClassId,
          params.sourceSubjectId,
          params.sourceTermId,
          params.sourceAcademicYearId,
          params.sourceResultTypeId
        ]
      ) as any[];

      // Get destination subject marks
      const [destMarksRows] = await connection.execute(
        `SELECT score, grade, result_type_id FROM class_results
         WHERE student_id = ? 
           AND class_id = ?
           AND subject_id = ?
           AND term_id = ?
           AND academic_year_id = ?
           AND result_type_id = ?`,
        [
          learner.student_id,
          params.destinationClassId,
          params.destinationSubjectId,
          params.destinationTermId,
          params.destinationAcademicYearId,
          params.destinationResultTypeId
        ]
      ) as any[];

      // Get result type name for assessment identification
      if (sourceMarksRows.length > 0) {
        const [resultTypeRows] = await connection.execute(
          'SELECT name FROM result_types WHERE id = ?',
          [sourceMarksRows[0].result_type_id]
        ) as any[];
        if (resultTypeRows.length > 0) {
          assessments.add(resultTypeRows[0].name);
        }
      }

      const sourceMark = sourceMarksRows.length > 0 ? sourceMarksRows[0].score : null;
      const destMark = destMarksRows.length > 0 ? destMarksRows[0].score : null;

      if (sourceMark !== null) {
        const hasConflict = destMark !== null;
        if (hasConflict) {
          destinationMarksCount++;
        }

        const preview: LearnerMarkPreview = {
          studentId: learner.student_id,
          studentName: learner.student_name,
          admissionNo: learner.admission_number,
          currentSourceMark: sourceMark,
          currentDestinationMark: destMark,
          afterMigrationMark: destMark !== null ? destMark : sourceMark,
          hasConflict,
          conflictReason: hasConflict
            ? `Existing mark (${destMark}) in destination subject`
            : undefined
        };

        learnerPreviews.push(preview);
        if (hasConflict) {
          conflicts.push(preview);
        }
      }
    }

    await connection.end();

    return {
      totalLearnersAffected: learnerPreviews.length,
      learnersWithMarks: learnerPreviews.length,
      assessmentsInvolved: Array.from(assessments),
      conflictCount: conflicts.length,
      conflicts,
      noConflicts: learnerPreviews.filter(p => !p.hasConflict),
      destinationHasExistingMarks: destinationMarksCount,
      preview: learnerPreviews
    };
  } catch (error) {
    await connection.end();
    throw error;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Execution Engine: Transaction-Safe Migration
// ─────────────────────────────────────────────────────────────────────────────

export async function executeMigration(
  request: MigrationExecutionRequest
): Promise<MigrationResult> {
  const connection = await getConnection();
  const transactionId = `TXN-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;

  try {
    // Start transaction
    await connection.execute('START TRANSACTION');

    let recordsMigrated = 0;
    let conflictsResolved = 0;
    let skipped = 0;

    // Get all learners with source marks
    const [learnerMarksRows] = await connection.execute(
      `SELECT cr.id, cr.student_id, cr.score, cr.grade, cr.remarks, cr.academic_type
        FROM class_results cr
        WHERE cr.class_id = ?
          AND cr.subject_id = ?
          AND cr.term_id = ?
          AND cr.academic_year_id = ?
          AND cr.result_type_id = ?
          AND cr.score IS NOT NULL`,
      [
        request.sourceClassId,
        request.sourceSubjectId,
        request.sourceTermId,
        request.sourceAcademicYearId,
        request.sourceResultTypeId
      ]
    ) as any[];

    const migratedRecords = [];

    // Process each mark
    for (const mark of learnerMarksRows) {
      // Check for conflict (existing mark in destination)
      const [existingDestRows] = await connection.execute(
        `SELECT id FROM class_results
         WHERE student_id = ?
           AND class_id = ?
           AND subject_id = ?
           AND term_id = ?
           AND academic_year_id = ?
           AND result_type_id = ?`,
        [
          mark.student_id,
          request.destinationClassId,
          request.destinationSubjectId,
          request.destinationTermId,
          request.destinationAcademicYearId,
          request.destinationResultTypeId
        ]
      ) as any[];

      if (existingDestRows.length > 0) {
        // Handle conflict based on strategy
        switch (request.conflictResolution) {
          case 'overwrite':
            // Delete existing destination mark and insert new one
            await connection.execute(
              'DELETE FROM class_results WHERE id = ?',
              [existingDestRows[0].id]
            );
            // Fall through to insert
            await connection.execute(
              `INSERT INTO class_results
                (student_id, class_id, subject_id, term_id, academic_year_id, result_type_id, score, grade, remarks, academic_type)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
              [
                mark.student_id,
                request.destinationClassId,
                request.destinationSubjectId,
                request.destinationTermId,
                request.destinationAcademicYearId,
                request.destinationResultTypeId,
                mark.score,
                mark.grade,
                mark.remarks || `Migrated from source subject on ${new Date().toISOString()}`,
                mark.academic_type
              ]
            );
            conflictsResolved++;
            recordsMigrated++;
            break;

          case 'skip':
            // Leave destination as-is
            skipped++;
            break;

          case 'merge':
            // Average the scores if both exist
            const [destMarkRows] = await connection.execute(
              `SELECT score FROM class_results WHERE id = ?`,
              [existingDestRows[0].id]
            ) as any[];
            const destScore = destMarkRows[0].score;
            const averageScore = (mark.score + destScore) / 2;

            await connection.execute(
              `UPDATE class_results
               SET score = ?, grade = ?, remarks = ?
               WHERE id = ?`,
              [
                averageScore,
                mark.grade,
                `Merged from ${mark.score} (source) and ${destScore} (destination) on ${new Date().toISOString()}`,
                existingDestRows[0].id
              ]
            );
            conflictsResolved++;
            recordsMigrated++;
            break;
        }
      } else {
        // No conflict: insert into destination subject
        await connection.execute(
          `INSERT INTO class_results
            (student_id, class_id, subject_id, term_id, academic_year_id, result_type_id, score, grade, remarks, academic_type)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
          [
            mark.student_id,
            request.destinationClassId,
            request.destinationSubjectId,
            request.destinationTermId,
            request.destinationAcademicYearId,
            request.destinationResultTypeId,
            mark.score,
            mark.grade,
            mark.remarks || `Migrated from source subject on ${new Date().toISOString()}`,
            mark.academic_type
          ]
        );
        recordsMigrated++;
      }

      migratedRecords.push({
        studentId: mark.student_id,
        sourceMark: mark.score,
        transactionId
      });
    }

    // Log migration in audit trail
    const migrationId = `MIG-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
    
    await connection.execute(
      `INSERT INTO audit_log
       (actor_user_id, action, entity_type, entity_id, changes_json, ip, user_agent, created_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, NOW())`,
      [
        request.confirmedBy,
        'MIGRATED_MARKS',
        'marks_migration',
        request.sourceClassId,
        JSON.stringify({
          migrationId,
          transactionId,
          sourceClassId: request.sourceClassId,
          sourceAcademicYearId: request.sourceAcademicYearId,
          sourceTermId: request.sourceTermId,
          sourceSubjectId: request.sourceSubjectId,
          sourceResultTypeId: request.sourceResultTypeId,
          destinationClassId: request.destinationClassId,
          destinationAcademicYearId: request.destinationAcademicYearId,
          destinationTermId: request.destinationTermId,
          destinationSubjectId: request.destinationSubjectId,
          destinationResultTypeId: request.destinationResultTypeId,
          recordsMigrated,
          conflictsResolved,
          skipped,
          strategy: request.conflictResolution,
          reason: request.reason,
          migratedRecords
        }),
        'internal',
        'marks-migration-engine'
      ]
    );

    // Store migration transaction log for rollback capability
    await connection.execute(
      `INSERT INTO marks_migration_log
       (migration_id, transaction_id, school_id, class_id, source_subject_id, destination_subject_id,
        academic_year_id, term_id, records_migrated, conflicts_resolved, skipped,
        conflict_resolution, performed_by, reason, migration_data)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        migrationId,
        transactionId,
        request.schoolId,
        request.sourceClassId,
        request.sourceSubjectId,
        request.destinationSubjectId,
        request.sourceAcademicYearId,
        request.sourceTermId,
        recordsMigrated,
        conflictsResolved,
        skipped,
        request.conflictResolution,
        request.confirmedBy,
        request.reason || null,
        JSON.stringify(migratedRecords)
      ]
    );

    // Commit transaction
    await connection.execute('COMMIT');

    await connection.end();

    return {
      success: true,
      migrationId,
      recordsMigrated,
      conflictsResolved,
      skipped,
      timestamp: new Date().toISOString(),
      transactionId
    };
  } catch (error) {
    try {
      await connection.execute('ROLLBACK');
    } catch (rollbackError) {
      console.error('Error during rollback:', rollbackError);
    }
    await connection.end();
    throw error;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Rollback Engine: Reverse a Migration
// ─────────────────────────────────────────────────────────────────────────────

export async function rollbackMigration(
  migrationId: string,
  userId: number
): Promise<{ success: boolean; message: string }> {
  const connection = await getConnection();

  try {
    // Fetch original migration data
    const [migrationRows] = await connection.execute(
      'SELECT * FROM marks_migration_log WHERE migration_id = ?',
      [migrationId]
    ) as any[];

    if (migrationRows.length === 0) {
      throw new Error(`Migration ${migrationId} not found`);
    }

    const migration = migrationRows[0];
    const migratedRecords = JSON.parse(migration.migration_data || '[]');

    // Start rollback transaction
    await connection.execute('START TRANSACTION');

    // For each migrated record, attempt to restore or remove
    for (const record of migratedRecords) {
      // Remove the migrated record from destination
      await connection.execute(
        `DELETE FROM class_results
         WHERE student_id = ?
           AND class_id = ?
           AND subject_id = ?
           AND term_id = ?
           AND academic_year_id = ?
           AND score = ?`,
        [
          record.studentId,
          migration.class_id,
          migration.destination_subject_id,
          migration.term_id,
          migration.academic_year_id,
          record.sourceMark
        ]
      );
    }

    // Log rollback
    await connection.execute(
      `INSERT INTO audit_log
       (actor_user_id, action, entity_type, entity_id, changes_json)
       VALUES (?, ?, ?, ?, ?)`,
      [
        userId,
        'ROLLED_BACK_MIGRATION',
        'marks_migration',
        migrationId,
        JSON.stringify({
          originalMigrationId: migrationId,
          rollbackTime: new Date().toISOString(),
          recordsRestored: migratedRecords.length
        })
      ]
    );

    // Mark migration as rolled back
    await connection.execute(
      'UPDATE marks_migration_log SET rolled_back_at = NOW(), rolled_back_by = ? WHERE migration_id = ?',
      [userId, migrationId]
    );

    await connection.execute('COMMIT');
    await connection.end();

    return {
      success: true,
      message: `Successfully rolled back migration ${migrationId}`
    };
  } catch (error) {
    try {
      await connection.execute('ROLLBACK');
    } catch (rollbackError) {
      console.error('Error during rollback:', rollbackError);
    }
    await connection.end();
    throw error;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Audit & History
// ─────────────────────────────────────────────────────────────────────────────

export async function getMigrationHistory(
  schoolId: number,
  limit: number = 50
): Promise<MigrationAuditRecord[]> {
  const connection = await getConnection();

  try {
    const [rows] = await connection.execute(
      `SELECT 
        mml.migration_id as id,
        mml.school_id as schoolId,
        mml.performed_by as performedBy,
        'MIGRATED_MARKS' as action,
        mml.class_id as classId,
        mml.source_subject_id as sourceSubjectId,
        mml.destination_subject_id as destinationSubjectId,
        mml.academic_year_id as academicYearId,
        mml.term_id as termId,
        mml.records_migrated as recordsAffected,
        mml.conflict_resolution as conflictResolution,
        mml.created_at as timestamp,
        JSON_OBJECT(
          'conflictsResolved', mml.conflicts_resolved,
          'skipped', mml.skipped,
          'reason', mml.reason
        ) as details
       FROM marks_migration_log mml
       WHERE mml.school_id = ?
       ORDER BY mml.created_at DESC
       LIMIT ?`,
      [schoolId, limit]
    ) as any[];

    await connection.end();

    return rows.map(r => ({
      ...r,
      details: typeof r.details === 'string' ? JSON.parse(r.details) : r.details
    }));
  } catch (error) {
    await connection.end();
    throw error;
  }
}

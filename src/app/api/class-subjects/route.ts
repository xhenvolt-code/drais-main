import { NextRequest, NextResponse } from 'next/server';
import { getConnection } from '@/lib/db';
import { logAudit } from '@/lib/audit';
import { getSessionSchoolId } from '@/lib/auth';

/**
 * GET /api/class-subjects?subject_id=X
 * Returns all classes that have the subject allocated
 */
export async function GET(req: NextRequest) {
  let connection;
  try {
    const session = await getSessionSchoolId(req);
    if (!session) return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
    const schoolId = session.schoolId;

    const subjectId = req.nextUrl.searchParams.get('subject_id');
    const classId = req.nextUrl.searchParams.get('class_id');

    connection = await getConnection();

    // If specific subject requested, get its allocations
    if (subjectId) {
      const [allocations]: any = await connection.execute(
        `SELECT 
          cs.id,
          cs.class_id,
          cs.subject_id,
          c.name AS class_name,
          c.class_level,
          sub.name AS subject_name,
          cs.teacher_id,
          CONCAT(s.first_name, ' ', s.last_name) AS teacher_name
        FROM class_subjects cs
        JOIN classes c ON cs.class_id = c.id
        JOIN subjects sub ON cs.subject_id = sub.id
        LEFT JOIN staff s ON cs.teacher_id = s.id
        WHERE sub.school_id = ? AND cs.subject_id = ?
        ORDER BY c.name`,
        [schoolId, subjectId]
      );

      // Get all classes for this school to show available options
      const [allClasses]: any = await connection.execute(
        `SELECT id, name, class_level FROM classes WHERE school_id = ? AND deleted_at IS NULL ORDER BY name`,
        [schoolId]
      );

      return NextResponse.json({
        success: true,
        data: {
          allocations,
          allClasses,
          totalAllocations: allocations.length,
        }
      });
    }

    // If specific class requested, get its subjects
    if (classId) {
      const [subjects]: any = await connection.execute(
        `SELECT 
          cs.id,
          cs.class_id,
          cs.subject_id,
          c.name AS class_name,
          sub.name AS subject_name,
          sub.subject_type,
          cs.teacher_id,
          CONCAT(s.first_name, ' ', s.last_name) AS teacher_name
        FROM class_subjects cs
        JOIN classes c ON cs.class_id = c.id
        JOIN subjects sub ON cs.subject_id = sub.id
        LEFT JOIN staff s ON cs.teacher_id = s.id
        WHERE c.school_id = ? AND cs.class_id = ?
        ORDER BY sub.name`,
        [schoolId, classId]
      );

      return NextResponse.json({
        success: true,
        data: { subjects }
      });
    }

    // Default: get all allocations for the school
    const [allAllocations]: any = await connection.execute(
      `SELECT 
        cs.id,
        cs.class_id,
        cs.subject_id,
        c.name AS class_name,
        sub.name AS subject_name,
        cs.teacher_id,
        CONCAT(s.first_name, ' ', s.last_name) AS teacher_name
      FROM class_subjects cs
      JOIN classes c ON cs.class_id = c.id
      JOIN subjects sub ON cs.subject_id = sub.id
      LEFT JOIN staff s ON cs.teacher_id = s.id
      WHERE c.school_id = ? AND sub.school_id = ?
      ORDER BY c.name, sub.name`,
      [schoolId, schoolId]
    );

    return NextResponse.json({
      success: true,
      data: { allocations: allAllocations }
    });
  } catch (error) {
    console.error('Error fetching class-subject allocations:', error);
    return NextResponse.json({ error: 'Failed to fetch allocations' }, { status: 500 });
  } finally {
    if (connection) await connection.end();
  }
}

/**
 * POST /api/class-subjects
 * Creates or updates subject-class allocations
 * Body: { subject_id: number, class_ids: number[], teacher_id?: number }
 */
export async function POST(req: NextRequest) {
  let connection;
  try {
    const session = await getSessionSchoolId(req);
    if (!session) return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
    const schoolId = session.schoolId;

    const body = await req.json();
    const { subject_id, class_ids, teacher_id } = body;

    if (!subject_id) {
      return NextResponse.json({ error: 'subject_id is required' }, { status: 400 });
    }

    if (!Array.isArray(class_ids)) {
      return NextResponse.json({ error: 'class_ids must be an array' }, { status: 400 });
    }

    connection = await getConnection();

    // Verify subject exists and belongs to this school
    const [subjectCheck]: any = await connection.execute(
      `SELECT id FROM subjects WHERE id = ? AND school_id = ?`,
      [subject_id, schoolId]
    );

    if (subjectCheck.length === 0) {
      return NextResponse.json({ error: 'Subject not found' }, { status: 404 });
    }

    // Delete all existing allocations for this subject
    await connection.execute(
      `DELETE FROM class_subjects WHERE subject_id = ?`,
      [subject_id]
    );

    // Verify all classes exist and belong to this school
    const classPlaceholders = class_ids.map(() => '?').join(',');
    const [classCheck]: any = await connection.execute(
      `SELECT id FROM classes WHERE school_id = ? AND id IN (${classPlaceholders}) AND deleted_at IS NULL`,
      [schoolId, ...class_ids]
    );

    if (classCheck.length !== class_ids.length) {
      return NextResponse.json({ error: 'Some classes not found' }, { status: 400 });
    }

    // Create new allocations
    const insertValues = class_ids.map(() => '(?, ?, ?)').join(',');
    const insertParams: any[] = [];

    for (const classId of class_ids) {
      insertParams.push(classId, subject_id, teacher_id || null);
    }

    if (class_ids.length > 0) {
      await connection.execute(
        `INSERT INTO class_subjects (class_id, subject_id, teacher_id) VALUES ${insertValues}`,
        insertParams
      );
    }

    // Log the change
    await logAudit({
      action: 'UPDATE_SUBJECT_ALLOCATIONS',
      entity: 'subject',
      entityId: subject_id,
      school_id: schoolId,
      details: `Allocated to ${class_ids.length} classes`
    });

    return NextResponse.json({
      success: true,
      message: `Subject allocated to ${class_ids.length} classes`,
      data: { allocations_created: class_ids.length }
    });
  } catch (error) {
    console.error('Error updating class-subject allocations:', error);
    return NextResponse.json({ error: 'Failed to update allocations' }, { status: 500 });
  } finally {
    if (connection) await connection.end();
  }
}

/**
 * DELETE /api/class-subjects?class_id=X&subject_id=Y
 * Removes a specific subject-class allocation
 */
export async function DELETE(req: NextRequest) {
  let connection;
  try {
    const session = await getSessionSchoolId(req);
    if (!session) return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
    const schoolId = session.schoolId;

    const classId = req.nextUrl.searchParams.get('class_id');
    const subjectId = req.nextUrl.searchParams.get('subject_id');

    if (!classId || !subjectId) {
      return NextResponse.json({ error: 'class_id and subject_id are required' }, { status: 400 });
    }

    connection = await getConnection();

    // Verify the allocation exists and belongs to this school
    const [checkAllocation]: any = await connection.execute(
      `SELECT cs.id FROM class_subjects cs
       JOIN subjects s ON cs.subject_id = s.id
       WHERE cs.class_id = ? AND cs.subject_id = ? AND s.school_id = ?`,
      [classId, subjectId, schoolId]
    );

    if (checkAllocation.length === 0) {
      return NextResponse.json({ error: 'Allocation not found' }, { status: 404 });
    }

    // Delete the allocation
    await connection.execute(
      `DELETE FROM class_subjects WHERE class_id = ? AND subject_id = ?`,
      [classId, subjectId]
    );

    // Log the change
    await logAudit({
      action: 'DELETE_SUBJECT_ALLOCATION',
      entity: 'class_subject',
      entityId: checkAllocation[0].id,
      school_id: schoolId,
      details: `Removed subject ${subjectId} from class ${classId}`
    });

    return NextResponse.json({
      success: true,
      message: 'Allocation removed successfully'
    });
  } catch (error) {
    console.error('Error deleting class-subject allocation:', error);
    return NextResponse.json({ error: 'Failed to delete allocation' }, { status: 500 });
  } finally {
    if (connection) await connection.end();
  }
}

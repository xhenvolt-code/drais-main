import { NextRequest, NextResponse } from 'next/server';
import { getConnection } from '@/lib/db';
import { getSessionSchoolId } from '@/lib/auth';
import { getCurrentTerm } from '@/lib/terms';

/**
 * POST /api/enrollments/bulk
 *
 * Bulk-enroll or bulk-promote students.
 *
 * Body options:
 *
 * A) Bulk promote a class to the next class:
 *   {
 *     mode: "promote",
 *     from_class_id: 5,
 *     to_class_id: 6,
 *     academic_year_id: 3,
 *     term_id: 9,           // optional – defaults to current
 *     student_ids: [1,2,3]  // optional – if omitted, all active students in class
 *   }
 *
 * B) Bulk enroll a list of students (simple mode):
 *   {
 *     mode: "enroll",
 *     class_id: 6,
 *     stream_id: 2,         // optional
 *     academic_year_id: 3,
 *     term_id: 9,
 *     enrollment_type: "new" | "continuing" | "transfer" | "repeat",
 *     student_ids: [1,2,3]
 *   }
 *
 * C) Bulk enroll multiple students with full context (study mode, curriculum, program):
 *   {
 *     mode: "multiple_students",
 *     student_ids: [1,2,3],
 *     class_id: 6,
 *     stream_id: 2,              // optional
 *     academic_year_id: 3,
 *     term_id: 9,
 *     study_mode_id: 1,          // required
 *     curriculum_id: 2,          // required
 *     program_id: 5,             // required
 *     enrollment_type: "new" | "continuing" | "repeat",
 *     close_previous: true       // optional – defaults to true
 *   }
 */
export async function POST(req: NextRequest) {
  const session = await getSessionSchoolId(req);
  if (!session) {
    return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
  }
  const schoolId = session.schoolId;

  const body = await req.json();
  const { mode } = body;

  if (mode !== 'promote' && mode !== 'enroll' && mode !== 'multiple_students') {
    return NextResponse.json({ error: 'mode must be "promote", "enroll", or "multiple_students"' }, { status: 400 });
  }

  const conn = await getConnection();
  try {
    // Handle multiple_students mode (new bulk enrollment with full context)
    if (mode === 'multiple_students') {
      return await handleMultipleStudentsMode(conn, session, body, schoolId, req);
    }

    // Handle existing promote/enroll modes
    // Resolve term
    let termId: number = body.term_id;
    if (!termId) {
      const current = await getCurrentTerm(schoolId);
      if (!current) return NextResponse.json({ error: 'No active term found' }, { status: 400 });
      termId = current.id;
    }
    const academicYearId: number = body.academic_year_id;
    if (!academicYearId) {
      return NextResponse.json({ error: 'academic_year_id is required' }, { status: 400 });
    }

    await conn.execute('START TRANSACTION');
    try {
      let studentIds: number[] = body.student_ids || [];

      if (mode === 'promote') {
        const { from_class_id, to_class_id } = body;
        if (!from_class_id || !to_class_id) {
          await conn.execute('ROLLBACK');
          return NextResponse.json({ error: 'from_class_id and to_class_id required for promote mode' }, { status: 400 });
        }

        // If no student_ids provided, find all active students in from_class
        if (studentIds.length === 0) {
          const [rows] = await conn.execute<any[]>(
            `SELECT DISTINCT e.student_id
             FROM enrollments e
             WHERE e.school_id = ?
               AND e.class_id = ?
               AND e.status = 'active'
               AND e.deleted_at IS NULL`,
            [schoolId, from_class_id]
          );
          studentIds = rows.map((r: any) => r.student_id);
        }

        if (studentIds.length === 0) {
          await conn.execute('ROLLBACK');
          return NextResponse.json({ success: true, data: { enrolled: 0, message: 'No students found in class' } });
        }

        // Close current active enrollments for these students
        await conn.execute(
          `UPDATE enrollments
           SET status = 'completed', end_date = CURDATE(), end_reason = 'promoted', updated_at = NOW()
           WHERE school_id = ?
             AND student_id IN (${studentIds.map(() => '?').join(',')})
             AND status = 'active'`,
          [schoolId, ...studentIds]
        );

        // Create new enrollments in to_class
        for (const sid of studentIds) {
          await conn.execute(
            `INSERT INTO enrollments
               (school_id, student_id, class_id, academic_year_id, term_id,
                enrollment_type, status, joined_at, enrollment_date, created_at)
             VALUES (?, ?, ?, ?, ?, 'continuing', 'active', CURDATE(), CURDATE(), NOW())
             ON DUPLICATE KEY UPDATE status='active', updated_at=NOW()`,
            [schoolId, sid, to_class_id, academicYearId, termId]
          );
        }

        // Log promotion records
        for (const sid of studentIds) {
          await conn.execute(
            `INSERT INTO promotions
               (school_id, student_id, from_class_id, to_class_id,
                from_academic_year_id, to_academic_year_id,
                promotion_status, approval_status, created_at)
             VALUES (?, ?, ?, ?, ?, ?, 'promoted', 'approved', NOW())
             ON DUPLICATE KEY UPDATE promotion_status='promoted', updated_at=NOW()`,
            [schoolId, sid, from_class_id, to_class_id, academicYearId, academicYearId]
          );
        }

        await conn.execute('COMMIT');
        return NextResponse.json({
          success: true,
          data: { enrolled: studentIds.length, mode: 'promote', from_class_id, to_class_id },
        });
      }

      // mode === 'enroll'
      const { class_id, stream_id, enrollment_type = 'new' } = body;
      if (!class_id) {
        await conn.execute('ROLLBACK');
        return NextResponse.json({ error: 'class_id is required for enroll mode' }, { status: 400 });
      }
      if (studentIds.length === 0) {
        await conn.execute('ROLLBACK');
        return NextResponse.json({ error: 'student_ids must not be empty for enroll mode' }, { status: 400 });
      }

      for (const sid of studentIds) {
        await conn.execute(
          `INSERT INTO enrollments
             (school_id, student_id, class_id, stream_id, academic_year_id, term_id,
              enrollment_type, status, joined_at, enrollment_date, created_at)
           VALUES (?, ?, ?, ?, ?, ?, ?, 'active', CURDATE(), CURDATE(), NOW())`,
          [schoolId, sid, class_id, stream_id || null, academicYearId, termId, enrollment_type]
        );
      }

      await conn.execute('COMMIT');
      return NextResponse.json({
        success: true,
        data: { enrolled: studentIds.length, mode: 'enroll', class_id },
      });
    } catch (err) {
      await conn.execute('ROLLBACK');
      throw err;
    }
  } catch (err) {
    console.error('[enrollments/bulk] error:', err);
    return NextResponse.json({ error: 'Bulk enrollment failed' }, { status: 500 });
  } finally {
    await conn.end();
  }
}

/**
 * Handle multiple_students mode: enroll many students with full enrollment context
 * (study mode, curriculum, program, etc.)
 */
async function handleMultipleStudentsMode(
  conn: any,
  session: any,
  body: any,
  schoolId: number,
  req: NextRequest
) {
  const {
    student_ids,
    class_id,
    stream_id,
    academic_year_id,
    term_id,
    study_mode_id,
    curriculum_id,
    program_id,
    enrollment_type,
    close_previous,
  } = body;

  // Validate required fields
  if (!Array.isArray(student_ids) || student_ids.length === 0) {
    return NextResponse.json({
      success: false,
      message: 'student_ids must be a non-empty array',
      error: { code: 'MISSING_STUDENTS' },
    }, { status: 400 });
  }

  if (!class_id || !academic_year_id || !term_id || !study_mode_id || !curriculum_id || !program_id) {
    return NextResponse.json({
      success: false,
      message: 'All of class_id, academic_year_id, term_id, study_mode_id, curriculum_id, and program_id are required',
      error: { code: 'MISSING_FIELDS' },
    }, { status: 400 });
  }

  // Validate entities exist
  const [classRows]: any = await conn.execute(
    'SELECT id, name FROM classes WHERE id = ? AND school_id = ? LIMIT 1',
    [class_id, schoolId]
  );
  if (classRows.length === 0) {
    return NextResponse.json({ success: false, message: 'Class not found', error: { code: 'CLASS_NOT_FOUND' } }, { status: 404 });
  }
  const className = classRows[0].name;

  const [progRows]: any = await conn.execute(
    'SELECT id, name FROM programs WHERE id = ? AND school_id = ? AND is_active = 1 LIMIT 1',
    [program_id, schoolId]
  );
  if (progRows.length === 0) {
    return NextResponse.json({ success: false, message: 'Program not found or inactive', error: { code: 'PROGRAM_NOT_FOUND' } }, { status: 404 });
  }
  const programName = progRows[0].name;

  // Enroll each student
  const results: any[] = [];
  let successful = 0;

  for (const studentId of student_ids) {
    try {
      await conn.execute('START TRANSACTION');

      // Check student exists
      const [studentRows]: any = await conn.execute(
        'SELECT s.id, p.first_name, p.last_name FROM students s JOIN people p ON s.person_id = p.id WHERE s.id = ? AND s.school_id = ? AND s.deleted_at IS NULL LIMIT 1',
        [studentId, schoolId]
      );
      if (studentRows.length === 0) {
        await conn.execute('ROLLBACK');
        results.push({ student_id: studentId, success: false, message: 'Student not found' });
        continue;
      }
      const studentName = `${studentRows[0].first_name} ${studentRows[0].last_name}`;

      // Close previous if requested
      if (close_previous !== false) {
        await conn.execute(
          `UPDATE enrollments SET status = 'completed', end_date = CURDATE(), end_reason = 'promoted', updated_at = NOW()
           WHERE student_id = ? AND school_id = ? AND status = 'active'`,
          [studentId, schoolId]
        );
      }

      // Insert new enrollment
      const [result]: any = await conn.execute(
        `INSERT INTO enrollments
           (school_id, student_id, class_id, stream_id, academic_year_id, term_id,
            study_mode_id, curriculum_id, program_id, enrollment_type, status, enrollment_date, enrolled_at)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'active', CURDATE(), NOW())`,
        [
          schoolId, studentId, class_id, stream_id ?? null,
          academic_year_id, term_id, study_mode_id,
          curriculum_id, program_id,
          enrollment_type ?? 'continuing',
        ]
      );
      const enrollmentId: number = result.insertId;

      // Insert enrollment_programs
      await conn.execute(
        'INSERT IGNORE INTO enrollment_programs (enrollment_id, program_id) VALUES (?, ?)',
        [enrollmentId, program_id]
      );

      await conn.execute('COMMIT');

      results.push({ student_id: studentId, success: true, enrollment_id: enrollmentId, message: `${studentName} enrolled successfully` });
      successful++;
    } catch (err: any) {
      try { await conn.execute('ROLLBACK'); } catch { /* ignore */ }
      results.push({ student_id: studentId, success: false, message: err.message || 'Enrollment failed' });
    }
  }

  return NextResponse.json({
    success: true,
    message: `Bulk enrollment complete: ${successful}/${student_ids.length} students enrolled successfully`,
    data: {
      successful,
      failed: student_ids.length - successful,
      total: student_ids.length,
      results,
    },
  });
}

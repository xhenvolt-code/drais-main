import { NextRequest, NextResponse } from 'next/server';
import { getConnection } from '@/lib/db';
import { getSessionSchoolId } from '@/lib/auth';

// ============================================
// Enhanced API Endpoints for Proper Year Filtering
// ============================================

/**
 * Enhanced filtered results endpoint with proper soft-delete filtering and year validation
 */
export async function GET(req: NextRequest) {
  const session = await getSessionSchoolId(req);
  if (!session) {
    return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
  }

  const conn = await getConnection();
  try {
    const schoolId = session.schoolId;
    
    // REQUIRED: academic_year_id and term_id
    const academicYearId = req.nextUrl.searchParams.get('academic_year_id');
    const termId = req.nextUrl.searchParams.get('term_id');
    
    if (!academicYearId || !termId) {
      return NextResponse.json(
        { 
          error: 'Missing required parameters: academic_year_id and term_id',
          hint: 'Use /api/academic/current-term to get defaults'
        },
        { status: 400 }
      );
    }

    const ayId = parseInt(academicYearId, 10);
    const tId = parseInt(termId, 10);

    // OPTIONAL filters
    const studentId = req.nextUrl.searchParams.get('student_id');
    const classId = req.nextUrl.searchParams.get('class_id');
    const subjectId = req.nextUrl.searchParams.get('subject_id');

    let whereClause = `
      WHERE cr.school_id = ?
        AND cr.academic_year_id = ?
        AND cr.term_id = ?
        AND s.deleted_at IS NULL
        AND cr.deleted_at IS NULL
    `;
    const params: any[] = [schoolId, ayId, tId];

    if (studentId) {
      whereClause += ' AND cr.student_id = ?';
      params.push(parseInt(studentId, 10));
    }
    if (classId) {
      whereClause += ' AND cr.class_id = ?';
      params.push(parseInt(classId, 10));
    }
    if (subjectId) {
      whereClause += ' AND cr.subject_id = ?';
      params.push(parseInt(subjectId, 10));
    }

    // Validate academic year and term exist for this school
    const [ayData]: any = await conn.execute(
      'SELECT id, name FROM academic_years WHERE id = ? AND school_id = ? AND deleted_at IS NULL',
      [ayId, schoolId]
    );
    const [tData]: any = await conn.execute(
      'SELECT id, name FROM terms WHERE id = ? AND academic_year_id = ? AND school_id = ? AND deleted_at IS NULL',
      [tId, ayId, schoolId]
    );

    if (!ayData.length || !tData.length) {
      return NextResponse.json(
        { error: 'Invalid academic year or term for this school' },
        { status: 404 }
      );
    }

    const academicYearName = ayData[0].name;
    const termName = tData[0].name;

    // Use the enhanced view that includes teacher initials and proper filtering
    const [rows]: any = await conn.execute(`
      SELECT
        cr.id,
        cr.student_id,
        cr.admission_no,
        cr.first_name,
        cr.last_name,
        cr.gender,
        cr.photo_url,
        cr.class_id,
        cr.class_name,
        cr.subject_id,
        cr.subject_name,
        cr.subject_code,
        cr.score,
        cr.grade,
        cr.remarks,
        cr.teacher_initials,
        cr.term_name,
        cr.academic_year_name,
        cr.created_at
      FROM v_class_reports cr
      ${whereClause}
      ORDER BY cr.last_name, cr.first_name, cr.subject_name
    `, params);

    // Group by student for summary statistics
    const studentMap: Record<number, any> = {};
    for (const row of rows) {
      if (!studentMap[row.student_id]) {
        studentMap[row.student_id] = {
          student_id: row.student_id,
          admission_no: row.admission_no,
          first_name: row.first_name,
          last_name: row.last_name,
          gender: row.gender,
          photo_url: row.photo_url,
          class_name: row.class_name,
          results: []
        };
      }
      studentMap[row.student_id].results.push({
        id: row.id,
        subject_name: row.subject_name,
        subject_code: row.subject_code,
        score: row.score,
        grade: row.grade,
        remarks: row.remarks,
        teacher_initials: row.teacher_initials,
        created_at: row.created_at
      });
    }

    return NextResponse.json({
      academic_year_id: ayId,
      academic_year_name: academicYearName,
      term_id: tId,
      term_name: termName,
      school_id: schoolId,
      total_students: Object.keys(studentMap).length,
      results: Object.values(studentMap)
    });
  } catch (error) {
    console.error('Error fetching filtered results:', error);
    return NextResponse.json(
      { error: 'Failed to fetch results' },
      { status: 500 }
    );
  } finally {
    await conn.end();
  }
}

/**
 * Enhanced students endpoint with proper soft-delete filtering
 */
export async function getStudents(req: NextRequest) {
  const session = await getSessionSchoolId(req);
  if (!session) {
    return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
  }

  const conn = await getConnection();
  try {
    const schoolId = session.schoolId;
    const classId = req.nextUrl.searchParams.get('class_id');
    const streamId = req.nextUrl.searchParams.get('stream_id');

    let whereClause = `
      WHERE s.school_id = ?
        AND s.deleted_at IS NULL
        AND p.deleted_at IS NULL
    `;
    const params: any[] = [schoolId];

    if (classId) {
      whereClause += ' AND e.class_id = ?';
      params.push(parseInt(classId, 10));
    }
    if (streamId) {
      whereClause += ' AND e.stream_id = ?';
      params.push(parseInt(streamId, 10));
    }

    const [rows]: any = await conn.execute(`
      SELECT
        s.id,
        s.admission_no,
        s.school_id,
        s.status,
        s.admission_date,
        p.first_name,
        p.last_name,
        p.gender,
        p.date_of_birth,
        p.photo_url,
        e.class_id,
        c.name  AS class_name,
        st.name AS stream_name,
        e.term_id,
        t.name  AS term_name,
        e.academic_year_id,
        ay.name AS academic_year_name,
        e.enrollment_type,
        e.status AS enrollment_status
      FROM students s
      LEFT JOIN people p ON s.person_id = p.id
      LEFT JOIN enrollments e
             ON e.student_id = s.id
            AND e.status     = 'active'
            AND e.deleted_at IS NULL
      LEFT JOIN classes c         ON e.class_id         = c.id
      LEFT JOIN streams st        ON e.stream_id        = st.id
      LEFT JOIN terms t           ON e.term_id          = t.id
      LEFT JOIN academic_years ay ON e.academic_year_id = ay.id
      ${whereClause}
      ORDER BY COALESCE(p.last_name, '') ASC, COALESCE(p.first_name, '') ASC
    `, params);

    return NextResponse.json({
      school_id: schoolId,
      total_students: rows.length,
      students: rows
    });
  } catch (error) {
    console.error('Error fetching students:', error);
    return NextResponse.json(
      { error: 'Failed to fetch students' },
      { status: 500 }
    );
  } finally {
    await conn.end();
  }
}

/**
 * Enhanced teacher assignments endpoint
 */
export async function getTeacherAssignments(req: NextRequest) {
  const session = await getSessionSchoolId(req);
  if (!session) {
    return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
  }

  const conn = await getConnection();
  try {
    const schoolId = session.schoolId;
    const classId = req.nextUrl.searchParams.get('class_id');
    const subjectId = req.nextUrl.searchParams.get('subject_id');

    let whereClause = `
      WHERE cs.school_id = ?
        AND s.deleted_at IS NULL
        AND p.deleted_at IS NULL
        AND cs.deleted_at IS NULL
    `;
    const params: any[] = [schoolId];

    if (classId) {
      whereClause += ' AND cs.class_id = ?';
      params.push(parseInt(classId, 10));
    }
    if (subjectId) {
      whereClause += ' AND cs.subject_id = ?';
      params.push(parseInt(subjectId, 10));
    }

    const [rows]: any = await conn.execute(`
      SELECT
        cs.id,
        cs.class_id,
        cs.subject_id,
        cs.teacher_id,
        c.name AS class_name,
        sub.name AS subject_name,
        sub.code AS subject_code,
        p.first_name AS teacher_first_name,
        p.last_name AS teacher_last_name,
        CONCAT(UPPER(LEFT(p.first_name, 1)), UPPER(LEFT(p.last_name, 1))) AS teacher_initials,
        s.position AS teacher_position
      FROM class_subjects cs
      LEFT JOIN staff s ON cs.teacher_id = s.id
      LEFT JOIN people p ON s.person_id = p.id
      LEFT JOIN classes c ON cs.class_id = c.id
      LEFT JOIN subjects sub ON cs.subject_id = sub.id
      ${whereClause}
      ORDER BY c.name, sub.name, p.last_name, p.first_name
    `, params);

    return NextResponse.json({
      school_id: schoolId,
      total_assignments: rows.length,
      assignments: rows
    });
  } catch (error) {
    console.error('Error fetching teacher assignments:', error);
    return NextResponse.json(
      { error: 'Failed to fetch teacher assignments' },
      { status: 500 }
    );
  } finally {
    await conn.end();
  }
}

/**
 * Fix academic year for existing results without year
 */
export async function fixAcademicYears(req: NextRequest) {
  const session = await getSessionSchoolId(req);
  if (!session) {
    return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
  }

  const conn = await getConnection();
  try {
    const schoolId = session.schoolId;

    // Find results without academic year
    const [resultsWithoutYear]: any = await conn.execute(`
      SELECT COUNT(*) as count
      FROM class_results cr
      WHERE cr.school_id = ?
        AND cr.academic_year_id IS NULL
        AND cr.deleted_at IS NULL
    `, [schoolId]);

    if (resultsWithoutYear[0].count === 0) {
      return NextResponse.json({
        message: 'All results already have academic years assigned',
        fixed_count: 0
      });
    }

    // Get or create academic years for each year found in results
    const [yearsToCreate]: any = await conn.execute(`
      SELECT DISTINCT YEAR(cr.created_at) as year_name
      FROM class_results cr
      WHERE cr.school_id = ?
        AND cr.academic_year_id IS NULL
        AND cr.deleted_at IS NULL
      ORDER BY year_name
    `, [schoolId]);

    let totalFixed = 0;

    for (const yearRow of yearsToCreate) {
      const yearName = yearRow.year_name.toString();
      
      // Create academic year if it doesn't exist
      await conn.execute(`
        INSERT IGNORE INTO academic_years (school_id, name, start_date, end_date, status, created_at)
        VALUES (?, ?, ?, ?, 'active', NOW())
      `, [schoolId, yearName, `${yearName}-01-01`, `${yearName}-12-31`]);

      // Get the academic year ID
      const [ayData]: any = await conn.execute(`
        SELECT id FROM academic_years 
        WHERE school_id = ? AND name = ?
      `, [schoolId, yearName]);

      const academicYearId = ayData[0].id;

      // Update results for this year
      const [updateResult]: any = await conn.execute(`
        UPDATE class_results cr
        SET cr.academic_year_id = ?, cr.updated_at = NOW()
        WHERE cr.school_id = ?
          AND cr.academic_year_id IS NULL
          AND YEAR(cr.created_at) = ?
          AND cr.deleted_at IS NULL
      `, [academicYearId, schoolId, yearName]);

      totalFixed += updateResult.affectedRows;
    }

    return NextResponse.json({
      message: `Fixed academic years for ${totalFixed} results`,
      fixed_count: totalFixed,
      years_processed: yearsToCreate.length
    });
  } catch (error) {
    console.error('Error fixing academic years:', error);
    return NextResponse.json(
      { error: 'Failed to fix academic years' },
      { status: 500 }
    );
  } finally {
    await conn.end();
  }
}

/**
 * Generate admission numbers for students missing them
 */
export async function generateAdmissionNumbers(req: NextRequest) {
  const session = await getSessionSchoolId(req);
  if (!session) {
    return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
  }

  const conn = await getConnection();
  try {
    const schoolId = session.schoolId;

    // Find students without proper admission numbers
    const [studentsWithoutAdmission]: any = await conn.execute(`
      SELECT s.id, p.first_name, p.last_name, s.admission_date, s.created_at
      FROM students s
      LEFT JOIN people p ON s.person_id = p.id
      WHERE s.school_id = ?
        AND (s.admission_no IS NULL 
             OR s.admission_no = '' 
             OR s.admission_no NOT REGEXP '^[A-Z]+/[0-9]+/[0-9]{4}$')
        AND s.deleted_at IS NULL
      ORDER BY s.created_at
    `, [schoolId]);

    if (studentsWithoutAdmission.length === 0) {
      return NextResponse.json({
        message: 'All students already have proper admission numbers',
        generated_count: 0
      });
    }

    let totalGenerated = 0;

    for (const student of studentsWithoutAdmission) {
      const admissionYear = student.admission_date ? 
        new Date(student.admission_date).getFullYear().toString() : 
        new Date().getFullYear().toString();

      // Get next sequential number for this school and year
      const [nextNumberResult]: any = await conn.execute(`
        SELECT COALESCE(MAX(CAST(SUBSTRING(admission_no, 5, LOCATE('/', admission_no, 5) - 5) AS UNSIGNED)), 0) + 1 as next_number
        FROM students 
        WHERE school_id = ? 
          AND admission_no LIKE 'NGS/%/' + ?
          AND deleted_at IS NULL
      `, [schoolId, admissionYear]);

      const nextNumber = nextNumberResult[0].next_number;
      const newAdmissionNo = `NGS/${nextNumber}/${admissionYear}`;

      // Update student record
      await conn.execute(`
        UPDATE students 
        SET admission_no = ?, updated_at = NOW()
        WHERE id = ?
      `, [newAdmissionNo, student.id]);

      totalGenerated++;
    }

    return NextResponse.json({
      message: `Generated admission numbers for ${totalGenerated} students`,
      generated_count: totalGenerated
    });
  } catch (error) {
    console.error('Error generating admission numbers:', error);
    return NextResponse.json(
      { error: 'Failed to generate admission numbers' },
      { status: 500 }
    );
  } finally {
    await conn.end();
  }
}

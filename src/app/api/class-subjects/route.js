import { NextResponse } from 'next/server';
import { getConnection } from '@/lib/db'; // Assumes a MySQL2 connection helper
import { getSessionSchoolId } from '@/lib/auth';

// Helper function to validate input
const validateInput = (data) => {
  const normalizeNullable = (value) => (value === '' || value === undefined ? null : value);
  const { class_id, subject_id, teacher_id } = data;
  if (!class_id || !subject_id) {
    throw new Error('Class ID and Subject ID are required.');
  }
  return {
    class_id,
    subject_id,
    teacher_id: normalizeNullable(teacher_id),
  };
};

async function validateOwnership(connection, schoolId, { class_id, subject_id, teacher_id }) {
  const [classRows] = await connection.execute(
    'SELECT id FROM classes WHERE id = ? AND school_id = ? AND deleted_at IS NULL LIMIT 1',
    [class_id, schoolId]
  );
  if (!classRows.length) {
    throw new Error('The selected class does not belong to your school.');
  }

  const [subjectRows] = await connection.execute(
    'SELECT id FROM subjects WHERE id = ? AND school_id = ? AND deleted_at IS NULL LIMIT 1',
    [subject_id, schoolId]
  );
  if (!subjectRows.length) {
    throw new Error('The selected subject does not belong to your school.');
  }

  if (teacher_id) {
    const [teacherRows] = await connection.execute(
      'SELECT id FROM staff WHERE id = ? AND school_id = ? AND deleted_at IS NULL LIMIT 1',
      [teacher_id, schoolId]
    );
    if (!teacherRows.length) {
      throw new Error('The selected teacher does not belong to your school.');
    }
  }
}

async function ensureAssignmentBelongsToSchool(connection, schoolId, assignmentId) {
  const [rows] = await connection.execute(
    `SELECT cs.id
     FROM class_subjects cs
     JOIN classes c ON cs.class_id = c.id
     WHERE cs.id = ? AND c.school_id = ?
     LIMIT 1`,
    [assignmentId, schoolId]
  );

  if (!rows.length) {
    throw new Error('Assignment not found for your school.');
  }
}

// GET: Fetch all class-subject-teacher assignments
export async function GET(req) {
  let connection;
  try {
    const session = await getSessionSchoolId(req);
    if (!session) {
      return NextResponse.json({ success: false, message: 'Not authenticated' }, { status: 401 });
    }

    const { searchParams } = new URL(req.url);
    const classId = searchParams.get('class_id');
    const streamId = searchParams.get('stream_id');
    const termId = searchParams.get('term_id');

    connection = await getConnection();
    const query = `
      SELECT
        cs.id,
        cs.class_id,
        cs.subject_id,
        cs.teacher_id,
        c.name AS class_name,
        sub.name AS subject_name,
        COALESCE(NULLIF(TRIM(CONCAT(COALESCE(p.first_name, ''), ' ', COALESCE(p.last_name, ''))), ''), 'Unassigned') AS teacher_name,
        COALESCE(
          NULLIF(CONCAT(COALESCE(LEFT(p.first_name, 1), ''), COALESCE(LEFT(p.last_name, 1), '')), '')
        ) AS teacher_initials,
        NULL AS stream,
        NULL AS term
      FROM class_subjects cs
      JOIN classes c ON cs.class_id = c.id
      JOIN subjects sub ON cs.subject_id = sub.id
      LEFT JOIN staff ON cs.teacher_id = staff.id
      LEFT JOIN people p ON staff.person_id = p.id
      WHERE c.school_id = ? AND sub.school_id = ?
      ${classId ? 'AND cs.class_id = ?' : ''}
      ORDER BY c.name ASC, sub.name ASC
    `;
    const params = [session.schoolId, session.schoolId, classId].filter(v => v !== null && v !== undefined && v !== '');
    const [rows] = await connection.execute(query, params);

    return NextResponse.json(rows);
  } catch (error) {
    console.error('Error fetching class-subject assignments:', error);
    return NextResponse.json({ success: false, message: error.message }, { status: 500 });
  } finally {
    if (connection) await connection.end();
  }
}

// POST: Create a new assignment
export async function POST(req) {
  let connection;
  try {
    const session = await getSessionSchoolId(req);
    if (!session) {
      return NextResponse.json({ success: false, message: 'Not authenticated' }, { status: 401 });
    }

    const body = await req.json();
    const { class_id, subject_id, teacher_id } = validateInput(body);

    connection = await getConnection();
    await validateOwnership(connection, session.schoolId, { class_id, subject_id, teacher_id });
    const [existing] = await connection.execute(
      `SELECT cs.id
       FROM class_subjects cs
       JOIN classes c ON cs.class_id = c.id
       WHERE cs.class_id = ? AND cs.subject_id = ? AND c.school_id = ?`,
      [class_id, subject_id, session.schoolId]
    );
    if (existing.length > 0) {
      throw new Error('This assignment already exists.');
    }

    await connection.execute(
      `INSERT INTO class_subjects (class_id, subject_id, teacher_id) VALUES (?, ?, ?)`,
      [class_id, subject_id, teacher_id]
    );

    return NextResponse.json({ success: true, message: 'Teacher assigned successfully.' });
  } catch (error) {
    console.error('Error creating assignment:', error);
    return NextResponse.json({ success: false, message: error.message }, { status: 400 });
  } finally {
    if (connection) await connection.end();
  }
}

// PUT: Update an existing assignment
export async function PUT(req) {
  let connection;
  try {
    const session = await getSessionSchoolId(req);
    if (!session) {
      return NextResponse.json({ success: false, message: 'Not authenticated' }, { status: 401 });
    }

    const body = await req.json();
    const { id } = body;
    if (!id) throw new Error('Assignment ID is required.');

    connection = await getConnection();
    await ensureAssignmentBelongsToSchool(connection, session.schoolId, id);
    const { class_id, subject_id, teacher_id } = validateInput(body);
    await validateOwnership(connection, session.schoolId, { class_id, subject_id, teacher_id });

    await connection.execute(
      `UPDATE class_subjects
       SET class_id = ?, subject_id = ?, teacher_id = ?
       WHERE id = ?`,
      [class_id, subject_id, teacher_id, id]
    );

    return NextResponse.json({ success: true, message: 'Assignment updated successfully.' });
  } catch (error) {
    console.error('Error updating assignment:', error);
    return NextResponse.json({ success: false, message: error.message }, { status: 400 });
  } finally {
    if (connection) await connection.end();
  }
}

// DELETE: Remove an assignment
export async function DELETE(req) {
  let connection;
  try {
    const session = await getSessionSchoolId(req);
    if (!session) {
      return NextResponse.json({ success: false, message: 'Not authenticated' }, { status: 401 });
    }

    const { searchParams } = new URL(req.url);
    const id = searchParams.get('id');
    if (!id) throw new Error('Assignment ID is required.');

    connection = await getConnection();
    await ensureAssignmentBelongsToSchool(connection, session.schoolId, id);
    await connection.execute('DELETE FROM class_subjects WHERE id = ?', [id]);

    return NextResponse.json({ success: true, message: 'Assignment deleted successfully.' });
  } catch (error) {
    console.error('Error deleting assignment:', error);
    return NextResponse.json({ success: false, message: error.message }, { status: 400 });
  } finally {
    if (connection) await connection.end();
  }
}

import { NextResponse } from 'next/server';
import { getConnection } from '@/lib/db'; // Assumes a MySQL2 connection helper

// Helper function to validate input
const validateInput = (data) => {
  const { class_id, subject_id, teacher_id, stream_id, term_id } = data;
  if (!class_id || !subject_id) {
    throw new Error('Class ID and Subject ID are required.');
  }
  return { class_id, subject_id, teacher_id, stream_id, term_id };
};

// GET: Fetch all class-subject-teacher assignments
export async function GET(req) {
  let connection;
  try {
    const { searchParams } = new URL(req.url);
    const classId = searchParams.get('class_id');
    const streamId = searchParams.get('stream_id');
    const termId = searchParams.get('term_id');

    connection = await getConnection();
    const query = `
      SELECT 
        cs.id,
        c.name AS class_name,
        sub.name AS subject_name,
        CONCAT(p.first_name, ' ', p.last_name) AS teacher_name,
        staff.initials AS teacher_initials,
        s.name AS stream,
        t.name AS term
      FROM class_subjects cs
      JOIN classes c ON cs.class_id = c.id
      JOIN subjects sub ON cs.subject_id = sub.id
      LEFT JOIN staff ON cs.teacher_id = staff.id
      LEFT JOIN people p ON staff.person_id = p.id
      LEFT JOIN streams s ON cs.stream_id = s.id
      LEFT JOIN terms t ON cs.term_id = t.id
      WHERE 1=1
      ${classId ? 'AND cs.class_id = ?' : ''}
      ${streamId ? 'AND cs.stream_id = ?' : ''}
      ${termId ? 'AND cs.term_id = ?' : ''}
    `;
    const params = [classId, streamId, termId].filter(Boolean);
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
    const body = await req.json();
    const { class_id, subject_id, teacher_id, stream_id, term_id } = validateInput(body);

    connection = await getConnection();
    const [existing] = await connection.execute(
      `SELECT id FROM class_subjects WHERE class_id = ? AND subject_id = ? AND stream_id <=> ? AND term_id <=> ?`,
      [class_id, subject_id, stream_id, term_id]
    );
    if (existing.length > 0) {
      throw new Error('This assignment already exists.');
    }

    await connection.execute(
      `INSERT INTO class_subjects (class_id, subject_id, teacher_id, stream_id, term_id) VALUES (?, ?, ?, ?, ?)`,
      [class_id, subject_id, teacher_id, stream_id, term_id]
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
    const body = await req.json();
    const { id, teacher_id, subject_id } = body;
    if (!id) throw new Error('Assignment ID is required.');

    connection = await getConnection();
    await connection.execute(
      `UPDATE class_subjects SET teacher_id = ?, subject_id = ? WHERE id = ?`,
      [teacher_id, subject_id, id]
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
    const { searchParams } = new URL(req.url);
    const id = searchParams.get('id');
    if (!id) throw new Error('Assignment ID is required.');

    connection = await getConnection();
    await connection.execute(`DELETE FROM class_subjects WHERE id = ?`, [id]);

    return NextResponse.json({ success: true, message: 'Assignment deleted successfully.' });
  } catch (error) {
    console.error('Error deleting assignment:', error);
    return NextResponse.json({ success: false, message: error.message }, { status: 400 });
  } finally {
    if (connection) await connection.end();
  }
}

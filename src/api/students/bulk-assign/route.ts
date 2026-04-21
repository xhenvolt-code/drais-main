import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db'; // Assuming you have a database utility

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { learnerIds, classId } = body;

    if (!learnerIds || !classId) {
      return NextResponse.json({ message: 'Missing required fields' }, { status: 400 });
    }

    const placeholders = learnerIds.map(() => '?').join(',');

    // Update existing enrollments
    const updateSql = `UPDATE enrollments SET class_id = ? WHERE student_id IN (${placeholders})`;
    const updateParams = [classId, ...learnerIds];
    await query(updateSql, updateParams);

    // Insert new enrollments for students not already in the table
    const insertSql = `INSERT INTO enrollments (student_id, class_id, status) 
                       SELECT ?, ?, 'active' 
                       WHERE NOT EXISTS (
                         SELECT 1 FROM enrollments WHERE student_id = ?
                       )`;
    for (const studentId of learnerIds) {
      await query(insertSql, [studentId, classId, studentId]);
    }

    return NextResponse.json({ success: true, message: 'Class assigned successfully' });
  } catch (error) {
    console.error('Error assigning class:', error);
    return NextResponse.json({ success: false, message: 'Internal server error' }, { status: 500 });
  }
}
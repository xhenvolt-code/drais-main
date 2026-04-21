import { NextRequest, NextResponse } from 'next/server';
import { getConnection } from '@/lib/db';

export async function POST(req: NextRequest) {
  try {
    const { student_id, method, credential } = await req.json();

    if (!student_id || !method) {
      return NextResponse.json({ error: 'Student ID and method are required.' }, { status: 400 });
    }

    const connection = await getConnection();
    await connection.execute(
      'INSERT INTO fingerprints (student_id, method, credential, created_at) VALUES (?, ?, ?, NOW())',
      [student_id, method, credential || null]
    );
    await connection.end();

    return NextResponse.json({ success: true, message: 'Fingerprint added successfully.' });
  } catch (error: any) {
    console.error('Error adding fingerprint:', error.message);
    return NextResponse.json({ error: 'Failed to add fingerprint.' }, { status: 500 });
  }
}

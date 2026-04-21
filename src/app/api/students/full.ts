import type { NextApiRequest, NextApiResponse } from 'next';
import mysql from 'mysql2/promise';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    database: process.env.DB_NAME || 'drais',
  });

  if (req.method === 'GET') {
    // Fetch all students with joined info
    const [rows] = await connection.execute(`
      SELECT s.id, s.admission_no, s.status, s.admission_date, s.notes,
        p.first_name, p.last_name, p.other_name, p.gender, p.date_of_birth, p.phone, p.email, p.address, p.photo_url,
        e.class_id, e.theology_class_id, e.stream_id, e.academic_year_id, e.term_id,
        d.name AS district_name, v.name AS village_name
      FROM students s
      JOIN people p ON p.id = s.person_id
      LEFT JOIN enrollments e ON e.student_id = s.id
      LEFT JOIN villages v ON v.id = s.village_id
      LEFT JOIN districts d ON d.id = p.school_id
      WHERE s.deleted_at IS NULL
      ORDER BY s.id DESC
      LIMIT 100
    `);
    await connection.end();
    res.status(200).json({ data: rows });
    return;
  }

  if (req.method === 'POST') {
    // Create a new student and all related info
    const body = req.body;
    try {
      await connection.beginTransaction();
      // Insert into people
      const [personRes] = await connection.execute(
        'INSERT INTO people (school_id, first_name, last_name, other_name, gender, date_of_birth, phone, email, address, photo_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [body.school_id, body.first_name, body.last_name, body.other_name, body.gender, body.date_of_birth, body.phone, body.email, body.address, body.photo_url]
      );
      const person_id = (personRes as any).insertId;
      // Insert into students
      const [studentRes] = await connection.execute(
        'INSERT INTO students (school_id, person_id, admission_no, village_id, admission_date, status, notes) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [body.school_id, person_id, body.admission_no, body.village_id, body.admission_date, body.status, body.notes]
      );
      const student_id = (studentRes as any).insertId;
      // Insert into enrollments
      await connection.execute(
        'INSERT INTO enrollments (student_id, class_id, theology_class_id, stream_id, academic_year_id, term_id, status) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [student_id, body.class_id, body.theology_class_id, body.stream_id, body.academic_year_id, body.term_id, 'active']
      );
      // Insert contacts if provided
      if (Array.isArray(body.contacts)) {
        for (const c of body.contacts) {
          const [contactRes] = await connection.execute(
            'INSERT INTO contacts (school_id, person_id, contact_type, occupation, alive_status, date_of_death) VALUES (?, ?, ?, ?, ?, ?)',
            [body.school_id, person_id, c.contact_type, c.occupation, c.alive_status, c.date_of_death]
          );
          const contact_id = (contactRes as any).insertId;
          await connection.execute(
            'INSERT INTO student_contacts (student_id, contact_id, relationship, is_primary) VALUES (?, ?, ?, ?)',
            [student_id, contact_id, c.relationship || '', c.is_primary || 0]
          );
        }
      }
      await connection.commit();
      await connection.end();
      res.status(201).json({ success: true, student_id, person_id });
    } catch (e: any) {
      await connection.rollback();
      await connection.end();
      res.status(500).json({ error: e.message });
    }
    return;
  }

  if (req.method === 'PUT') {
    // Update student info
    const body = req.body;
    try {
      // Update people
      await connection.execute(
        'UPDATE people SET first_name=?, last_name=?, other_name=?, gender=?, date_of_birth=?, phone=?, email=?, address=?, photo_url=? WHERE id=?',
        [body.first_name, body.last_name, body.other_name, body.gender, body.date_of_birth, body.phone, body.email, body.address, body.photo_url, body.person_id]
      );
      // Update students
      await connection.execute(
        'UPDATE students SET admission_no=?, village_id=?, admission_date=?, status=?, notes=? WHERE id=?',
        [body.admission_no, body.village_id, body.admission_date, body.status, body.notes, body.student_id]
      );
      // Update enrollments
      await connection.execute(
        'UPDATE enrollments SET class_id=?, theology_class_id=?, stream_id=?, academic_year_id=?, term_id=?, status=? WHERE student_id=?',
        [body.class_id, body.theology_class_id, body.stream_id, body.academic_year_id, body.term_id, body.enrollment_status || 'active', body.student_id]
      );
      await connection.end();
      res.status(200).json({ success: true });
    } catch (e: any) {
      await connection.end();
      res.status(500).json({ error: e.message });
    }
    return;
  }

  if (req.method === 'DELETE') {
    // Delete student (soft delete)
    const { student_id } = req.query;
    try {
      await connection.execute('UPDATE students SET deleted_at=NOW() WHERE id=?', [student_id]);
      await connection.end();
      res.status(200).json({ success: true });
    } catch (e: any) {
      await connection.end();
      res.status(500).json({ error: e.message });
    }
    return;
  }

  res.status(405).json({ error: 'Method not allowed' });
}

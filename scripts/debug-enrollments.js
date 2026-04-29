// Debug enrollment and term matching
// Run with: node scripts/debug-enrollments.js

const mysql = require('mysql2/promise');
require('dotenv').config({ path: '.env.local' });

const dbConfig = {
  host: process.env.TIDB_HOST,
  port: process.env.TIDB_PORT,
  user: process.env.TIDB_USER,
  password: process.env.TIDB_PASSWORD,
  database: process.env.TIDB_DB,
  ssl: { rejectUnauthorized: true }
};

async function debugEnrollments() {
  let connection;

  try {
    connection = await mysql.createConnection(dbConfig);

    // Find Northgate school
    const [schools] = await connection.execute(
      'SELECT id, name FROM schools WHERE LOWER(name) LIKE ?',
      ['%northgate%']
    );
    const schoolId = schools[0].id;

    // Find top class
    const [topClasses] = await connection.execute(
      'SELECT id, name FROM classes WHERE school_id = ? AND LOWER(name) LIKE ?',
      [schoolId, '%top%']
    );
    const topClass = topClasses[0];

    console.log(`Analyzing ${topClass.name} (ID: ${topClass.id})`);

    // Check enrollments for top class
    const [enrollments] = await connection.execute(
      `SELECT e.id, e.student_id, e.class_id, e.term_id, e.academic_year_id,
              s.admission_no, p.first_name, p.last_name,
              t.name as term_name, ay.name as academic_year_name
       FROM enrollments e
       JOIN students s ON s.id = e.student_id
       JOIN people p ON p.id = s.person_id
       LEFT JOIN terms t ON t.id = e.term_id
       LEFT JOIN academic_years ay ON ay.id = e.academic_year_id
       WHERE e.class_id = ? AND s.school_id = ? AND s.deleted_at IS NULL
       ORDER BY p.last_name, p.first_name`,
      [topClass.id, schoolId]
    );

    console.log(`\nEnrollments for top class: ${enrollments.length}`);
    enrollments.slice(0, 10).forEach((e, i) => {
      console.log(`  ${i + 1}. ${e.first_name} ${e.last_name} (${e.admission_no}) - Term: ${e.term_name || 'NULL'}, AY: ${e.academic_year_name || 'NULL'}`);
    });

    // Check results for top class
    const [results] = await connection.execute(
      `SELECT cr.id, cr.student_id, cr.class_id, cr.term_id, cr.academic_year_id,
              s.admission_no, p.first_name, p.last_name,
              t.name as term_name, ay.name as academic_year_name
       FROM class_results cr
       JOIN students s ON s.id = cr.student_id
       JOIN people p ON p.id = s.person_id
       LEFT JOIN terms t ON t.id = cr.term_id
       LEFT JOIN academic_years ay ON ay.id = cr.academic_year_id
       WHERE cr.class_id = ? AND s.school_id = ?
       ORDER BY p.last_name, p.first_name
       LIMIT 20`,
      [topClass.id, schoolId]
    );

    console.log(`\nSample results for top class: ${results.length} total`);
    results.slice(0, 10).forEach((r, i) => {
      console.log(`  ${i + 1}. ${r.first_name} ${r.last_name} (${r.admission_no}) - Term: ${r.term_name || 'NULL'}, AY: ${r.academic_year_name || 'NULL'}`);
    });

    // Check the join logic
    const [joinTest] = await connection.execute(
      `SELECT
        cr.student_id,
        s.admission_no,
        p.first_name,
        p.last_name,
        e.id as enrollment_id,
        cr.term_id as result_term_id,
        e.term_id as enrollment_term_id,
        cr.academic_year_id as result_ay_id,
        e.academic_year_id as enrollment_ay_id
       FROM class_results cr
       JOIN students s ON s.id = cr.student_id
       JOIN people p ON p.id = s.person_id
       LEFT JOIN enrollments e ON e.student_id = cr.student_id AND e.class_id = cr.class_id AND (e.term_id = cr.term_id OR cr.term_id IS NULL)
       WHERE cr.class_id = ? AND s.school_id = ?
       LIMIT 10`,
      [topClass.id, schoolId]
    );

    console.log('\nJoin test (enrollment matching):');
    joinTest.forEach((row, i) => {
      const hasEnrollment = row.enrollment_id !== null;
      console.log(`  ${i + 1}. ${row.first_name} ${row.last_name} - Has enrollment: ${hasEnrollment} (Result term: ${row.result_term_id}, Enrollment term: ${row.enrollment_term_id})`);
    });

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

debugEnrollments();
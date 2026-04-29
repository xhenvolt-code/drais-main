// Detailed debug of the API query join
// Run with: node scripts/debug-api-query.js

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

async function debugApiQuery() {
  let connection;

  try {
    connection = await mysql.createConnection(dbConfig);

    // Find Northgate school and top class
    const [schools] = await connection.execute(
      'SELECT id, name FROM schools WHERE LOWER(name) LIKE ?',
      ['%northgate%']
    );
    const schoolId = schools[0].id;

    const [topClasses] = await connection.execute(
      'SELECT id, name FROM classes WHERE school_id = ? AND LOWER(name) LIKE ?',
      [schoolId, '%top%']
    );
    const topClass = topClasses[0];

    console.log(`Testing API query for ${topClass.name} (ID: ${topClass.id})`);

    // Test the enrollment join directly
    const [enrollmentTest] = await connection.execute(
      `SELECT DISTINCT
        cr.student_id,
        s.admission_no,
        p.first_name,
        p.last_name,
        e.id as enrollment_id,
        e.class_id as enrollment_class_id,
        cr.class_id as result_class_id
       FROM class_results cr
       JOIN students s ON s.id = cr.student_id
       JOIN people p ON p.id = s.person_id
       LEFT JOIN enrollments e ON e.student_id = cr.student_id AND e.class_id = cr.class_id
       WHERE cr.class_id = ? AND s.school_id = ? AND s.deleted_at IS NULL
       LIMIT 10`,
      [topClass.id, schoolId]
    );

    console.log('\nEnrollment join test:');
    enrollmentTest.forEach((row, i) => {
      console.log(`  ${i + 1}. ${row.first_name} ${row.last_name} - Enrollment ID: ${row.enrollment_id}, Class match: ${row.enrollment_class_id === row.result_class_id}`);
    });

    // Check if enrollments have class_id
    const [enrollmentCheck] = await connection.execute(
      `SELECT e.id, e.student_id, e.class_id, c.name as class_name
       FROM enrollments e
       LEFT JOIN classes c ON c.id = e.class_id
       WHERE e.class_id = ? LIMIT 5`,
      [topClass.id]
    );

    console.log('\nEnrollment class_id check:');
    enrollmentCheck.forEach((e, i) => {
      console.log(`  ${i + 1}. Enrollment ID: ${e.id}, Class: ${e.class_name} (${e.class_id})`);
    });

    // Test the full API query logic
    const [fullQueryTest] = await connection.execute(
      `SELECT DISTINCT cr.student_id, s.admission_no, p.first_name, p.last_name
       FROM class_results cr
       JOIN students s ON s.id = cr.student_id
       JOIN people p ON p.id = s.person_id
       LEFT JOIN enrollments e ON e.student_id = cr.student_id AND e.class_id = cr.class_id
       WHERE cr.class_id = ? AND s.school_id = ? AND s.deleted_at IS NULL AND e.id IS NOT NULL
       LIMIT 10`,
      [topClass.id, schoolId]
    );

    console.log(`\nFull API query test: ${fullQueryTest.length} students`);
    fullQueryTest.forEach((student, i) => {
      console.log(`  ${i + 1}. ${student.first_name} ${student.last_name} (${student.admission_no})`);
    });

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

debugApiQuery();
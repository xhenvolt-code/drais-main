// Check current term and enrollment counts
// Run with: node scripts/check-current-enrollments.js

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

async function checkCurrentEnrollments() {
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

    console.log(`Checking current enrollments for ${topClass.name} (ID: ${topClass.id})`);

    // Get latest academic year
    const [currentAY] = await connection.execute(
      'SELECT id, name FROM academic_years WHERE school_id = ? ORDER BY id DESC LIMIT 1',
      [schoolId]
    );

    console.log(`\nLatest Academic Year: ${currentAY[0]?.name || 'None found'}`);

    // Get latest term for this academic year
    const [currentTerms] = await connection.execute(
      'SELECT t.id, t.name, t.term_number FROM terms t WHERE t.academic_year_id = ? ORDER BY t.term_number DESC LIMIT 1',
      [currentAY[0]?.id]
    );

    const currentTerm = currentTerms[0];
    console.log(`Latest Term: ${currentTerm?.name || 'None found'} (ID: ${currentTerm?.id})`);

    // Check enrollments for latest term only
    const [currentEnrollments] = await connection.execute(
      `SELECT DISTINCT s.id, s.admission_no, p.first_name, p.last_name
       FROM enrollments e
       JOIN students s ON s.id = e.student_id
       JOIN people p ON p.id = s.person_id
       WHERE e.class_id = ? AND e.term_id = ? AND s.school_id = ? AND s.deleted_at IS NULL
       ORDER BY p.last_name, p.first_name`,
      [topClass.id, currentTerm?.id, schoolId]
    );

    console.log(`\nLatest term enrollments (${currentTerm?.name}): ${currentEnrollments.length}`);
    currentEnrollments.slice(0, 10).forEach((student, i) => {
      console.log(`  ${i + 1}. ${student.first_name} ${student.last_name} (${student.admission_no})`);
    });

    // Check results for latest term
    const [currentResults] = await connection.execute(
      `SELECT DISTINCT cr.student_id, s.admission_no, p.first_name, p.last_name
       FROM class_results cr
       JOIN students s ON s.id = cr.student_id
       JOIN people p ON p.id = s.person_id
       WHERE cr.class_id = ? AND cr.term_id = ? AND s.school_id = ? AND s.deleted_at IS NULL
       ORDER BY p.last_name, p.first_name`,
      [topClass.id, currentTerm?.id, schoolId]
    );

    console.log(`\nResults for latest term (${currentTerm?.name}): ${currentResults.length}`);

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

checkCurrentEnrollments();
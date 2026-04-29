// Check if results exist for different terms
// Run with: node scripts/check-term-results.js

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

async function checkTermResults() {
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

    console.log(`Checking results distribution for ${topClass.name} (ID: ${topClass.id})`);

    // Check results by term
    const [termResults] = await connection.execute(
      `SELECT t.name as term_name, t.id as term_id, COUNT(DISTINCT cr.student_id) as student_count
       FROM class_results cr
       JOIN terms t ON t.id = cr.term_id
       WHERE cr.class_id = ? AND cr.term_id IS NOT NULL
       GROUP BY t.id, t.name
       ORDER BY t.id DESC`,
      [topClass.id]
    );

    console.log('\nResults by term:');
    termResults.forEach(term => {
      console.log(`  ${term.term_name} (ID: ${term.term_id}): ${term.student_count} students`);
    });

    // Check which term has the most recent results
    const [latestResults] = await connection.execute(
      `SELECT DISTINCT cr.student_id, s.admission_no, p.first_name, p.last_name, t.name as term_name
       FROM class_results cr
       JOIN students s ON s.id = cr.student_id
       JOIN people p ON p.id = s.person_id
       JOIN terms t ON t.id = cr.term_id
       WHERE cr.class_id = ? AND cr.term_id = (
         SELECT MAX(term_id) FROM class_results WHERE class_id = ?
       )
       ORDER BY p.last_name, p.first_name
       LIMIT 10`,
      [topClass.id, topClass.id]
    );

    console.log(`\nLatest results term (${latestResults[0]?.term_name}): ${latestResults.length} sample students`);
    latestResults.forEach((student, i) => {
      console.log(`  ${i + 1}. ${student.first_name} ${student.last_name} (${student.admission_no})`);
    });

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

checkTermResults();
// Debug term IDs
// Run with: node scripts/debug-terms.js

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

async function debugTerms() {
  let connection;

  try {
    connection = await mysql.createConnection(dbConfig);

    // Find Northgate school
    const [schools] = await connection.execute(
      'SELECT id, name FROM schools WHERE LOWER(name) LIKE ?',
      ['%northgate%']
    );
    const schoolId = schools[0].id;

    console.log('=== TERMS ===');
    const [terms] = await connection.execute(
      'SELECT id, name, academic_year_id FROM terms WHERE academic_year_id IN (SELECT id FROM academic_years WHERE school_id = ?) ORDER BY id',
      [schoolId]
    );

    terms.forEach(term => {
      console.log(`Term ID: ${term.id}, Name: ${term.name}, AY: ${term.academic_year_id}`);
    });

    console.log('\n=== SAMPLE RESULTS TERM IDS ===');
    const [results] = await connection.execute(
      'SELECT DISTINCT cr.term_id, t.name, COUNT(*) as count FROM class_results cr LEFT JOIN terms t ON t.id = cr.term_id WHERE cr.class_id = 400007 GROUP BY cr.term_id, t.name',
      []
    );

    results.forEach(result => {
      console.log(`Result term_id: ${result.term_id}, Term name: ${result.name}, Count: ${result.count}`);
    });

    console.log('\n=== SAMPLE ENROLLMENT TERM IDS ===');
    const [enrollments] = await connection.execute(
      'SELECT DISTINCT e.term_id, t.name, COUNT(*) as count FROM enrollments e LEFT JOIN terms t ON t.id = e.term_id WHERE e.class_id = 400007 GROUP BY e.term_id, t.name',
      []
    );

    enrollments.forEach(enrollment => {
      console.log(`Enrollment term_id: ${enrollment.term_id}, Term name: ${enrollment.name}, Count: ${enrollment.count}`);
    });

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

debugTerms();
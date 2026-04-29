// Check subject types in the database
// Run with: node scripts/check-subject-types.js

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

async function checkSubjectTypes() {
  let connection;

  try {
    connection = await mysql.createConnection(dbConfig);

    // Find Northgate school
    const [schools] = await connection.execute(
      'SELECT id, name FROM schools WHERE LOWER(name) LIKE ?',
      ['%northgate%']
    );
    const schoolId = schools[0].id;

    console.log(`Checking subject types for school: ${schools[0].name}`);

    // Get all subjects for Northgate
    const [subjects] = await connection.execute(
      'SELECT id, name, subject_type FROM subjects WHERE school_id = ? ORDER BY name',
      [schoolId]
    );

    console.log(`\nFound ${subjects.length} subjects:`);
    subjects.forEach(subj => {
      console.log(`  ${subj.name} (ID: ${subj.id}) - Type: "${subj.subject_type}"`);
    });

    // Check results with theology subjects
    const [theologyResults] = await connection.execute(
      `SELECT DISTINCT
        sub.name as subject_name,
        sub.subject_type,
        COUNT(cr.id) as result_count
       FROM class_results cr
       JOIN subjects sub ON sub.id = cr.subject_id
       JOIN students s ON s.id = cr.student_id
       WHERE s.school_id = ?
         AND (LOWER(COALESCE(sub.subject_type, '')) = 'theology'
              OR LOWER(sub.subject_type) LIKE '%theol%'
              OR LOWER(sub.subject_type) LIKE '%islam%'
              OR LOWER(sub.subject_type) LIKE '%religion%')
       GROUP BY sub.id, sub.name, sub.subject_type
       ORDER BY sub.name`,
      [schoolId]
    );

    console.log(`\nSubjects with theology-related results: ${theologyResults.length}`);
    theologyResults.forEach(subj => {
      console.log(`  ${subj.subject_name} - Type: "${subj.subject_type}" - Results: ${subj.result_count}`);
    });

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

checkSubjectTypes();
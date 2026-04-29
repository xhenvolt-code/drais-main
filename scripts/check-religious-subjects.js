// Check if religious education is considered theology
// Run with: node scripts/check-religious-subjects.js

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

async function checkReligiousSubjects() {
  let connection;

  try {
    connection = await mysql.createConnection(dbConfig);

    // Find Northgate school
    const [schools] = await connection.execute(
      'SELECT id, name FROM schools WHERE LOWER(name) LIKE ?',
      ['%northgate%']
    );
    const schoolId = schools[0].id;

    console.log(`Checking religious subjects for school: ${schools[0].name}`);

    // Check results for religious education subject
    const [religiousResults] = await connection.execute(
      `SELECT
        sub.name as subject_name,
        sub.subject_type,
        COUNT(cr.id) as result_count,
        COUNT(DISTINCT cr.student_id) as student_count
       FROM class_results cr
       JOIN subjects sub ON sub.id = cr.subject_id
       JOIN students s ON s.id = cr.student_id
       WHERE s.school_id = ? AND LOWER(sub.name) LIKE '%religious%'
       GROUP BY sub.id, sub.name, sub.subject_type`,
      [schoolId]
    );

    console.log(`\nReligious education results:`);
    religiousResults.forEach(subj => {
      console.log(`  ${subj.subject_name} - Type: "${subj.subject_type}" - Students: ${subj.student_count} - Results: ${subj.result_count}`);
    });

    // Check what subjects have results in top class
    const [topClassSubjects] = await connection.execute(
      `SELECT DISTINCT
        sub.name as subject_name,
        sub.subject_type,
        COUNT(cr.id) as result_count
       FROM class_results cr
       JOIN subjects sub ON sub.id = cr.subject_id
       JOIN students s ON s.id = cr.student_id
       WHERE s.school_id = ? AND cr.class_id = 400007
       GROUP BY sub.id, sub.name, sub.subject_type
       ORDER BY result_count DESC`,
      [schoolId]
    );

    console.log(`\nSubjects with results in TOP CLASS:`);
    topClassSubjects.forEach(subj => {
      console.log(`  ${subj.subject_name} - Type: "${subj.subject_type}" - Results: ${subj.result_count}`);
    });

    // Update religious education to be theology type
    if (religiousResults.length > 0) {
      console.log('\nUpdating RELIGIOUS EDUCATION subject_type to theology...');
      const [updateResult] = await connection.execute(
        'UPDATE subjects SET subject_type = ? WHERE school_id = ? AND LOWER(name) LIKE ?',
        ['theology', schoolId, '%religious%']
      );
      console.log(`Updated ${updateResult.affectedRows} subjects`);
    }

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

checkReligiousSubjects();
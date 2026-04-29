// Check Albayan school subjects
// Run with: node scripts/check-albayan-subjects.js

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

async function checkAlbayanSubjects() {
  let connection;

  try {
    connection = await mysql.createConnection(dbConfig);

    // Find Albayan school
    const [schools] = await connection.execute(
      'SELECT id, name FROM schools WHERE LOWER(name) LIKE ?',
      ['%albayan%']
    );

    if (schools.length === 0) {
      console.log('Albayan school not found');
      return;
    }

    const schoolId = schools[0].id;
    console.log(`Checking subjects for school: ${schools[0].name} (ID: ${schoolId})`);

    // Get all subjects for Albayan
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
        COUNT(cr.id) as result_count,
        COUNT(DISTINCT cr.student_id) as student_count
       FROM class_results cr
       JOIN subjects sub ON sub.id = cr.subject_id
       JOIN students s ON s.id = cr.student_id
       WHERE s.school_id = ?
         AND LOWER(COALESCE(sub.subject_type, '')) = 'theology'
       GROUP BY sub.id, sub.name, sub.subject_type
       ORDER BY sub.name`,
      [schoolId]
    );

    console.log(`\nTheology subjects with results: ${theologyResults.length}`);
    theologyResults.forEach(subj => {
      console.log(`  ${subj.subject_name} - Type: "${subj.subject_type}" - Students: ${subj.student_count} - Results: ${subj.result_count}`);
    });

    // Check subjects that contain religion/theology keywords
    const [religionLikeSubjects] = await connection.execute(
      `SELECT DISTINCT
        sub.name as subject_name,
        sub.subject_type,
        COUNT(cr.id) as result_count
       FROM class_results cr
       JOIN subjects sub ON sub.id = cr.subject_id
       JOIN students s ON s.id = cr.student_id
       WHERE s.school_id = ?
         AND (LOWER(sub.name) LIKE '%religion%'
              OR LOWER(sub.name) LIKE '%islam%'
              OR LOWER(sub.name) LIKE '%theol%'
              OR LOWER(sub.name) LIKE '%quran%'
              OR LOWER(sub.name) LIKE '%arabic%'
              OR LOWER(sub.subject_type) = 'theology')
       GROUP BY sub.id, sub.name, sub.subject_type
       ORDER BY sub.name`,
      [schoolId]
    );

    console.log(`\nReligion/Islam/Arabic/Theology subjects: ${religionLikeSubjects.length}`);
    religionLikeSubjects.forEach(subj => {
      console.log(`  ${subj.subject_name} - Type: "${subj.subject_type}" - Results: ${subj.result_count}`);
    });

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

checkAlbayanSubjects();
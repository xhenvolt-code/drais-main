// Update Albayan Islamic subjects to theology type
// Run with: node scripts/update-albayan-theology.js

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

async function updateAlbayanTheology() {
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
    console.log(`Updating theology subjects for school: ${schools[0].name} (ID: ${schoolId})`);

    // Update Islamic/Religion subjects to theology type
    const [updateResult] = await connection.execute(
      `UPDATE subjects SET subject_type = 'theology'
       WHERE school_id = ?
         AND (LOWER(name) LIKE '%islam%'
              OR LOWER(name) LIKE '%religion%'
              OR LOWER(name) LIKE '%quran%'
              OR LOWER(name) LIKE '%arabic%'
              OR LOWER(subject_type) = 'tahfiz')`,
      [schoolId]
    );

    console.log(`Updated ${updateResult.affectedRows} subjects to theology type`);

    // Check updated subjects
    const [updatedSubjects] = await connection.execute(
      'SELECT id, name, subject_type FROM subjects WHERE school_id = ? AND subject_type = ? ORDER BY name',
      [schoolId, 'theology']
    );

    console.log('\nUpdated theology subjects:');
    updatedSubjects.forEach(subj => {
      console.log(`  ${subj.name} (ID: ${subj.id}) - Type: "${subj.subject_type}"`);
    });

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

updateAlbayanTheology();
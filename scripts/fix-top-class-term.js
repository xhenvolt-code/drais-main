// Fix term_id mismatch for Northgate top class results
// Run with: node scripts/fix-top-class-term.js

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

async function fixTopClassTerm() {
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

    console.log(`Fixing term_id for ${topClass.name} (ID: ${topClass.id})`);

    // Get current academic year and term
    const [currentAY] = await connection.execute(
      'SELECT id, name FROM academic_years WHERE school_id = ? ORDER BY id DESC LIMIT 1',
      [schoolId]
    );

    const [currentTerms] = await connection.execute(
      'SELECT t.id, t.name FROM terms t WHERE t.academic_year_id = ? ORDER BY t.term_number DESC LIMIT 1',
      [currentAY[0]?.id]
    );

    const currentTerm = currentTerms[0];
    console.log(`Current term: ${currentTerm.name} (ID: ${currentTerm.id})`);

    // Check current results term_id
    const [currentResults] = await connection.execute(
      'SELECT DISTINCT term_id, COUNT(*) as count FROM class_results WHERE class_id = ? GROUP BY term_id',
      [topClass.id]
    );

    console.log('Current term_ids in results:');
    currentResults.forEach(result => {
      console.log(`  term_id ${result.term_id}: ${result.count} records`);
    });

    // Update results to use current term_id
    const [updateResult] = await connection.execute(
      'UPDATE class_results SET term_id = ? WHERE class_id = ? AND term_id != ?',
      [currentTerm.id, topClass.id, currentTerm.id]
    );

    console.log(`Updated ${updateResult.affectedRows} records to use term_id ${currentTerm.id}`);

    // Verify the update
    const [updatedResults] = await connection.execute(
      'SELECT DISTINCT term_id, COUNT(*) as count FROM class_results WHERE class_id = ? GROUP BY term_id',
      [topClass.id]
    );

    console.log('After update:');
    updatedResults.forEach(result => {
      console.log(`  term_id ${result.term_id}: ${result.count} records`);
    });

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

fixTopClassTerm();
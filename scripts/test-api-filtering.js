// Test script to check if the API filtering is working
// Run with: node scripts/test-api-filtering.js

const mysql = require('mysql2/promise');
require('dotenv').config({ path: '.env.local' });

// TiDB Cloud configuration
const dbConfig = {
  host: process.env.TIDB_HOST,
  port: process.env.TIDB_PORT,
  user: process.env.TIDB_USER,
  password: process.env.TIDB_PASSWORD,
  database: process.env.TIDB_DB,
  ssl: {
    rejectUnauthorized: true
  }
};

async function testAPIFiltering() {
  let connection;

  try {
    console.log('Testing API filtering for Northgate top class...');
    connection = await mysql.createConnection(dbConfig);

    // Find Northgate school
    const [schools] = await connection.execute(
      'SELECT id, name FROM schools WHERE LOWER(name) LIKE ?',
      ['%northgate%']
    );

    if (schools.length === 0) {
      console.log('Northgate school not found');
      return;
    }

    const schoolId = schools[0].id;

    // Find top class
    const [topClasses] = await connection.execute(
      'SELECT id, name FROM classes WHERE school_id = ? AND LOWER(name) LIKE ?',
      [schoolId, '%top%']
    );

    if (topClasses.length === 0) {
      console.log('Top class not found');
      return;
    }

    const topClass = topClasses[0];
    console.log(`Testing API query for ${topClass.name} (ID: ${topClass.id})`);

    // Simulate the API query with enrollment filtering
    const [apiResults] = await connection.execute(
      `
      SELECT
        cr.id,
        cr.student_id,
        s.admission_no,
        p.first_name,
        p.last_name,
        c.name as class_name
      FROM class_results cr
      JOIN students s ON s.id = cr.student_id
      JOIN people p ON p.id = s.person_id
      JOIN classes c ON c.id = cr.class_id
      JOIN subjects sub ON sub.id = cr.subject_id
      JOIN result_types rt ON rt.id = cr.result_type_id
      LEFT JOIN terms t ON t.id = cr.term_id
      LEFT JOIN academic_years ay ON cr.academic_year_id = ay.id
      LEFT JOIN academic_years ay2 ON t.academic_year_id = ay2.id
      LEFT JOIN enrollments e ON e.student_id = cr.student_id AND e.class_id = cr.class_id AND (e.term_id = cr.term_id OR cr.term_id IS NULL)
      LEFT JOIN streams st ON st.id = e.stream_id
      INNER JOIN class_subjects cs ON cr.class_id = cs.class_id AND cr.subject_id = cs.subject_id
      WHERE s.school_id = ? AND s.deleted_at IS NULL AND e.id IS NOT NULL AND cr.class_id = ?
      ORDER BY p.last_name ASC, p.first_name ASC, cr.id DESC
      `,
      [schoolId, topClass.id]
    );

    console.log(`\nAPI query results: ${apiResults.length} records`);
    console.log(`Unique students: ${new Set(apiResults.map(r => r.student_id)).size}`);

    // Group by student to show unique students
    const studentsMap = new Map();
    apiResults.forEach(record => {
      if (!studentsMap.has(record.student_id)) {
        studentsMap.set(record.student_id, {
          name: `${record.first_name} ${record.last_name}`,
          admission_no: record.admission_no,
          records: 0
        });
      }
      studentsMap.get(record.student_id).records++;
    });

    console.log('\nUnique students from API:');
    Array.from(studentsMap.entries()).forEach(([studentId, data], index) => {
      console.log(`  ${index + 1}. ${data.name} (${data.admission_no}) - ${data.records} records`);
    });

    // Compare with enrollments
    const [enrollments] = await connection.execute(
      `SELECT DISTINCT s.id, s.admission_no, p.first_name, p.last_name
       FROM students s
       JOIN people p ON p.id = s.person_id
       JOIN enrollments e ON e.student_id = s.id
       WHERE s.school_id = ? AND e.class_id = ? AND s.deleted_at IS NULL
       ORDER BY p.last_name, p.first_name`,
      [schoolId, topClass.id]
    );

    console.log(`\nActually enrolled students: ${enrollments.length}`);
    enrollments.forEach((student, index) => {
      console.log(`  ${index + 1}. ${student.first_name} ${student.last_name} (${student.admission_no})`);
    });

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) {
      await connection.end();
      console.log('\nDatabase connection closed.');
    }
  }
}

testAPIFiltering();
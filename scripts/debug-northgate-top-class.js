// Debug script for Northgate top class issue
// Run with: node scripts/debug-northgate-top-class.js

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

async function debugNorthgateTopClass() {
  let connection;

  try {
    console.log('Connecting to TiDB Cloud...');
    connection = await mysql.createConnection(dbConfig);
    console.log('Connected successfully!');

    // Find Northgate school
    console.log('\n=== FINDING NORTHGATE SCHOOL ===');
    const [schools] = await connection.execute(
      'SELECT id, name FROM schools WHERE LOWER(name) LIKE ?',
      ['%northgate%']
    );

    if (schools.length === 0) {
      console.log('Northgate school not found');
      return;
    }

    const schoolId = schools[0].id;
    console.log(`Found Northgate school: ${schools[0].name} (ID: ${schoolId})`);

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
    console.log(`\nTop class found: ${topClass.name} (ID: ${topClass.id})`);

    // Get current students enrolled in top class
    console.log('\n=== CURRENT STUDENTS ENROLLED IN TOP CLASS ===');
    const [currentStudents] = await connection.execute(
      `SELECT DISTINCT s.id, s.admission_no, p.first_name, p.last_name, c.name as class_name
       FROM students s
       JOIN people p ON p.id = s.person_id
       JOIN enrollments e ON e.student_id = s.id
       JOIN classes c ON c.id = e.class_id
       WHERE s.school_id = ? AND e.class_id = ? AND s.deleted_at IS NULL
       ORDER BY p.last_name, p.first_name`,
      [schoolId, topClass.id]
    );

    console.log(`Current enrolled students in ${topClass.name}: ${currentStudents.length}`);
    currentStudents.forEach((student, index) => {
      console.log(`  ${index + 1}. ${student.first_name} ${student.last_name} (${student.admission_no})`);
    });

    // Get results for top class
    console.log('\n=== STUDENTS WITH RESULTS IN TOP CLASS ===');
    const [results] = await connection.execute(
      `SELECT
        cr.student_id,
        s.admission_no,
        p.first_name,
        p.last_name,
        c.name as result_class_name,
        COUNT(*) as result_count
       FROM class_results cr
       JOIN students s ON s.id = cr.student_id
       JOIN people p ON p.id = s.person_id
       JOIN classes c ON c.id = cr.class_id
       WHERE s.school_id = ? AND cr.class_id = ?
       GROUP BY cr.student_id, s.admission_no, p.first_name, p.last_name, c.name
       ORDER BY p.last_name, p.first_name`,
      [schoolId, topClass.id]
    );

    console.log(`Students with results in ${topClass.name}: ${results.length}`);
    results.forEach((student, index) => {
      console.log(`  ${index + 1}. ${student.first_name} ${student.last_name} (${student.admission_no}) - ${student.result_count} results`);
    });

    // Check for students who have results in top class but are NOT currently enrolled there
    console.log('\n=== STUDENTS WITH TOP CLASS RESULTS BUT NOT ENROLLED THERE ===');
    const [mismatchedResults] = await connection.execute(
      `SELECT
        cr.student_id,
        s.admission_no,
        p.first_name,
        p.last_name,
        result_cls.name as result_class_name,
        enrolled_cls.name as enrolled_class_name,
        COUNT(*) as result_count
       FROM class_results cr
       JOIN students s ON s.id = cr.student_id
       JOIN people p ON p.id = s.person_id
       JOIN classes result_cls ON result_cls.id = cr.class_id
       LEFT JOIN enrollments e ON e.student_id = cr.student_id AND e.term_id = cr.term_id
       LEFT JOIN classes enrolled_cls ON enrolled_cls.id = e.class_id
       WHERE s.school_id = ? AND cr.class_id = ?
         AND (e.class_id IS NULL OR e.class_id != ?)
       GROUP BY cr.student_id, s.admission_no, p.first_name, p.last_name, result_cls.name, enrolled_cls.name
       ORDER BY p.last_name, p.first_name`,
      [schoolId, topClass.id, topClass.id]
    );

    console.log(`Students with top class results but not enrolled there: ${mismatchedResults.length}`);
    mismatchedResults.forEach((student, index) => {
      console.log(`  ${index + 1}. ${student.first_name} ${student.last_name} (${student.admission_no})`);
      console.log(`     Currently enrolled in: ${student.enrolled_class_name || 'None'}`);
      console.log(`     Has ${student.result_count} results in: ${student.result_class_name}`);
      console.log('');
    });

    // Check theology subjects and results
    console.log('\n=== THEOLOGY ANALYSIS ===');
    const [theologySubjects] = await connection.execute(
      `SELECT id, name, subject_type FROM subjects WHERE school_id = ? AND LOWER(subject_type) = 'theology'`,
      [schoolId]
    );

    console.log(`Theology subjects: ${theologySubjects.length}`);
    theologySubjects.forEach(subj => {
      console.log(`  ${subj.name} (ID: ${subj.id}, Type: ${subj.subject_type})`);
    });

    if (theologySubjects.length > 0) {
      const subjectIds = theologySubjects.map(s => s.id);
      const placeholders = subjectIds.map(() => '?').join(',');

      const [theologyResults] = await connection.execute(
        `SELECT COUNT(*) as count FROM class_results cr
         WHERE cr.class_id = ? AND cr.subject_id IN (${placeholders})`,
        [topClass.id, ...subjectIds]
      );

      console.log(`Theology results in top class: ${theologyResults[0].count}`);
    }

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) {
      await connection.end();
      console.log('\nDatabase connection closed.');
    }
  }
}

debugNorthgateTopClass();
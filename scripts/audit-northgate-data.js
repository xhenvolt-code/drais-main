// Audit Northgate school and create proper filtering script
// Run with: node scripts/audit-northgate-data.js

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

async function auditNorthgateData() {
  let connection;

  try {
    console.log('Auditing Northgate school data...');
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
    console.log(`Found Northgate school: ${schools[0].name} (ID: ${schoolId})`);

    // Get academic years
    const [academicYears] = await connection.execute(
      'SELECT id, name, start_date, end_date FROM academic_years WHERE school_id = ? ORDER BY start_date DESC',
      [schoolId]
    );

    console.log('\nAcademic Years:');
    academicYears.forEach(ay => {
      console.log(`  ${ay.name} (ID: ${ay.id}) - ${ay.start_date} to ${ay.end_date}`);
    });

    // Get terms for 2026
    const [terms] = await connection.execute(
      'SELECT t.id, t.name, t.term_number, ay.name as academic_year_name FROM terms t INNER JOIN academic_years ay ON t.academic_year_id = ay.id WHERE ay.school_id = ? AND ay.name LIKE ? ORDER BY t.term_number',
      [schoolId, '%2026%']
    );

    console.log('\nTerms for 2026:');
    terms.forEach(term => {
      console.log(`  ${term.name} (ID: ${term.id}) - Term ${term.term_number} - Academic Year: ${term.academic_year_name}`);
    });

    // Get result types
    const [resultTypes] = await connection.execute(
      'SELECT id, name FROM result_types ORDER BY name'
    );

    console.log('\nResult Types:');
    resultTypes.forEach(rt => {
      console.log(`  ${rt.name} (ID: ${rt.id})`);
    });

    // Get sample class results for Northgate Term 1 2026
    if (terms.length > 0) {
      const termId = terms[0].id; // First term

      const [sampleResults] = await connection.execute(`
        SELECT
          cr.id,
          s.admission_no,
          p.first_name,
          p.last_name,
          c.name as class_name,
          sub.name as subject_name,
          rt.name as result_type_name,
          cr.score,
          cr.grade,
          cr.remarks,
          cr.created_at
        FROM class_results cr
        INNER JOIN students s ON cr.student_id = s.id
        INNER JOIN people p ON s.person_id = p.id
        INNER JOIN classes c ON cr.class_id = c.id
        INNER JOIN subjects sub ON cr.subject_id = sub.id
        LEFT JOIN result_types rt ON cr.result_type_id = rt.id
        WHERE s.school_id = ? AND cr.term_id = ?
        ORDER BY c.name, p.last_name, sub.name
        LIMIT 20
      `, [schoolId, termId]);

      console.log(`\nSample results for Term ${terms[0].name} (showing first 20):`);
      sampleResults.forEach(result => {
        console.log(`  ${result.class_name} - ${result.first_name} ${result.last_name} (${result.admission_no}) - ${result.subject_name} - ${result.result_type_name}: ${result.score} (${result.grade})`);
      });

      // Count different result types in this term
      const [resultTypeCounts] = await connection.execute(`
        SELECT rt.name as result_type, COUNT(*) as count
        FROM class_results cr
        LEFT JOIN result_types rt ON cr.result_type_id = rt.id
        INNER JOIN students s ON cr.student_id = s.id
        WHERE s.school_id = ? AND cr.term_id = ?
        GROUP BY rt.name
        ORDER BY count DESC
      `, [schoolId, termId]);

      console.log('\nResult type distribution:');
      resultTypeCounts.forEach(count => {
        console.log(`  ${count.result_type || 'NULL'}: ${count.count} results`);
      });
    }

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

auditNorthgateData();
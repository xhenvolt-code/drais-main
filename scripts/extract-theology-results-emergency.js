// Emergency data extraction for theology reports Term 1 2026
// Run with: node scripts/extract-theology-results-emergency.js

const mysql = require('mysql2/promise');
const fs = require('fs').promises;
require('dotenv').config({ path: '.env.local' });

const dbConfig = {
  host: process.env.TIDB_HOST,
  port: process.env.TIDB_PORT,
  user: process.env.TIDB_USER,
  password: process.env.TIDB_PASSWORD,
  database: process.env.TIDB_DB,
  ssl: { rejectUnauthorized: true }
};

async function extractTheologyResults() {
  let connection;

  try {
    console.log('Connecting to TiDB Cloud...');
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
    console.log(`Found school: ${schools[0].name} (ID: ${schoolId})`);

    // Find academic year for 2026
    const [academicYears] = await connection.execute(
      'SELECT id, name FROM academic_years WHERE school_id = ? AND name LIKE ?',
      [schoolId, '%2026%']
    );

    if (academicYears.length === 0) {
      console.log('Academic year 2026 not found');
      return;
    }

    const academicYear = academicYears[0];
    console.log(`Found academic year: ${academicYear.name} (ID: ${academicYear.id})`);

    // Find Term 1 2026
    const [terms] = await connection.execute(
      'SELECT id, name FROM terms WHERE academic_year_id = ? AND LOWER(name) LIKE ?',
      [academicYear.id, '%term%1%']
    );

    if (terms.length === 0) {
      console.log('Term 1 2026 not found');
      return;
    }

    const term = terms[0];
    console.log(`Found term: ${term.name} (ID: ${term.id})`);

    // Get all theology classes
    const [classes] = await connection.execute(
      `SELECT DISTINCT c.id, c.name
       FROM classes c
       INNER JOIN class_subjects cs ON c.id = cs.class_id
       INNER JOIN subjects s ON cs.subject_id = s.id
       WHERE c.school_id = ? AND s.subject_type = 'theology'
       ORDER BY c.name`,
      [schoolId]
    );

    console.log(`Found ${classes.length} theology classes`);

    const results = {
      school: schools[0],
      academicYear,
      term,
      classes: []
    };

    // For each class, get students and their results
    for (const classInfo of classes) {
      console.log(`Processing class: ${classInfo.name}`);

      const [students] = await connection.execute(`
        SELECT DISTINCT
          s.id as student_id,
          s.admission_no,
          p.first_name,
          p.last_name,
          p.gender,
          p.photo_url,
          e.stream_id,
          st.name as stream_name
        FROM students s
        INNER JOIN people p ON s.person_id = p.id
        INNER JOIN enrollments e ON s.id = e.student_id AND e.class_id = ?
        LEFT JOIN streams st ON e.stream_id = st.id
        WHERE s.school_id = ? AND s.deleted_at IS NULL AND e.status = 'active'
        ORDER BY p.last_name, p.first_name
      `, [classInfo.id, schoolId]);

      console.log(`  Found ${students.length} students in ${classInfo.name}`);

      const classStudents = [];

      for (const student of students) {
        // Get all theology subjects and results for this student
        const [subjectResults] = await connection.execute(`
          SELECT
            s.id as subject_id,
            s.name as subject_name,
            s.code as subject_code,
            cr.score,
            cr.grade,
            cr.remarks,
            rt.name as result_type_name
          FROM class_results cr
          INNER JOIN subjects s ON cr.subject_id = s.id
          LEFT JOIN result_types rt ON cr.result_type_id = rt.id
          WHERE cr.student_id = ? AND cr.class_id = ? AND cr.term_id = ?
            AND s.subject_type = 'theology'
          ORDER BY s.name, rt.name
        `, [student.student_id, classInfo.id, term.id]);

        if (subjectResults.length > 0) {
          // Group results by subject
          const subjectMap = new Map();
          subjectResults.forEach(sr => {
            if (!subjectMap.has(sr.subject_id)) {
              subjectMap.set(sr.subject_id, {
                subject_id: sr.subject_id,
                subject_name: sr.subject_name,
                subject_code: sr.subject_code,
                results: []
              });
            }
            subjectMap.get(sr.subject_id).results.push({
              score: sr.score,
              grade: sr.grade,
              remarks: sr.remarks,
              result_type: sr.result_type_name
            });
          });

          const subjects = Array.from(subjectMap.values());

          // Calculate totals
          const totalScore = subjects.reduce((sum, subj) => {
            const subjTotal = subj.results.reduce((s, r) => s + (r.score || 0), 0);
            return sum + subjTotal;
          }, 0);

          const averageScore = subjects.length > 0 ? totalScore / subjects.length : 0;

          // Calculate position in class
          // This would require getting all students' averages, but for simplicity, we'll compute it later

          classStudents.push({
            student_id: student.student_id,
            admission_no: student.admission_no,
            name: `${student.first_name} ${student.last_name}`,
            gender: student.gender,
            photo_url: student.photo_url,
            stream_name: student.stream_name,
            subjects,
            total_score: Math.round(totalScore * 100) / 100,
            average_score: Math.round(averageScore * 100) / 100,
            position: 0 // Will compute after all students
          });
        }
      }

      // Compute positions
      classStudents.sort((a, b) => b.average_score - a.average_score);
      classStudents.forEach((stu, idx) => {
        stu.position = idx + 1;
      });

      results.classes.push({
        class_id: classInfo.id,
        class_name: classInfo.name,
        students: classStudents
      });
    }

    // Save to JSON file
    const outputPath = '/home/xhenvolt/Systems/DraisLongTermVersion/backup/theology-results-term1-2026.json';
    await fs.writeFile(outputPath, JSON.stringify(results, null, 2));
    console.log(`\nData exported to ${outputPath}`);
    console.log(`Total classes: ${results.classes.length}`);
    console.log(`Total students: ${results.classes.reduce((sum, c) => sum + c.students.length, 0)}`);

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

extractTheologyResults();
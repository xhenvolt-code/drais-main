// Emergency data extraction for theology reports Term 1 2026 - REAL DATA
// Run with: node scripts/extract-theology-results-emergency-real.js

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
    console.log('Connecting to TiDB Cloud for real data extraction...');
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

    // Define the specific Arabic classes we need
    const arabicClassNames = [
      'الروضة (BABY)',
      'الروضة (MIDDLE)',
      'الروضة (T0P)',
      'صف الأول',
      'صف الثاني',
      'صف الثالث',
      'صف الرابع',
      'صف الخامس',
      'صف السادس'
    ];

    console.log('Looking for classes:', arabicClassNames);

    // Get classes by name
    const [classes] = await connection.execute(
      `SELECT DISTINCT c.id, c.name
       FROM classes c
       WHERE c.school_id = ? AND c.name IN (${arabicClassNames.map(() => '?').join(',')})
       ORDER BY c.name`,
      [schoolId, ...arabicClassNames]
    );

    console.log(`Found ${classes.length} matching classes:`, classes.map(c => c.name));

    // Also check if there are English-named classes that should be included
    const englishClassNames = [
      'PRIMARY ONE',
      'PRIMARY TWO',
      'PRIMARY THREE',
      'PRIMARY FOUR',
      'PRIMARY FIVE',
      'PRIMARY SIX',
      'BABY CLASS',
      'MIDDLE CLASS',
      'TOP CLASS'
    ];

    const [englishClasses] = await connection.execute(
      `SELECT DISTINCT c.id, c.name
       FROM classes c
       WHERE c.school_id = ? AND c.name IN (${englishClassNames.map(() => '?').join(',')})`,
      [schoolId, ...englishClassNames]
    );

    console.log(`Found ${englishClasses.length} English classes:`, englishClasses.map(c => c.name));

    // Combine all classes
    const allClasses = [...classes, ...englishClasses];
    const uniqueClasses = allClasses.filter((classInfo, index, self) =>
      index === self.findIndex(c => c.id === classInfo.id)
    );

    console.log(`Total unique classes to process: ${uniqueClasses.length}`);

    const results = {
      school: schools[0],
      academicYear,
      term,
      classes: []
    };

    // For each class, get students and their results
    for (const classInfo of uniqueClasses) {
      console.log(`Processing class: ${classInfo.name} (ID: ${classInfo.id})`);

      // Get subjects allocated to this class
      const [allocatedSubjects] = await connection.execute(`
        SELECT s.id, s.name, s.code, s.subject_type
        FROM subjects s
        INNER JOIN class_subjects cs ON s.id = cs.subject_id
        WHERE cs.class_id = ?
        ORDER BY s.name
      `, [classInfo.id]);

      console.log(`  Class ${classInfo.name} has ${allocatedSubjects.length} subjects:`,
        allocatedSubjects.map(s => `${s.name} (${s.subject_type})`));

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
        // Get results for all allocated subjects for this student
        const [subjectResults] = await connection.execute(`
          SELECT
            s.id as subject_id,
            s.name as subject_name,
            s.code as subject_code,
            s.subject_type,
            cr.score,
            cr.grade,
            cr.remarks,
            rt.name as result_type_name
          FROM class_results cr
          INNER JOIN subjects s ON cr.subject_id = s.id
          LEFT JOIN result_types rt ON cr.result_type_id = rt.id
          WHERE cr.student_id = ? AND cr.class_id = ? AND cr.term_id = ?
            AND cr.subject_id IN (${allocatedSubjects.map(() => '?').join(',')})
          ORDER BY s.name, rt.name
        `, [student.student_id, classInfo.id, term.id, ...allocatedSubjects.map(s => s.id)]);

        if (subjectResults.length > 0) {
          // Group results by subject
          const subjectMap = new Map();
          subjectResults.forEach(sr => {
            if (!subjectMap.has(sr.subject_id)) {
              subjectMap.set(sr.subject_id, {
                subject_id: sr.subject_id,
                subject_name: sr.subject_name,
                subject_code: sr.subject_code,
                subject_type: sr.subject_type,
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
            const subjTotal = subj.results.reduce((s, r) => s + (parseFloat(r.score) || 0), 0);
            return sum + subjTotal;
          }, 0);

          const averageScore = subjects.length > 0 ? totalScore / subjects.length : 0;

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

      console.log(`  Processed ${classStudents.length} students with results`);
    }

    // Save to JSON file
    const outputPath = '/home/xhenvolt/Systems/DraisLongTermVersion/backup/theology-results-term1-2026.json';
    await fs.writeFile(outputPath, JSON.stringify(results, null, 2));
    console.log(`\nReal data exported to ${outputPath}`);
    console.log(`Total classes: ${results.classes.length}`);
    console.log(`Total students: ${results.classes.reduce((sum, c) => sum + c.students.length, 0)}`);

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

extractTheologyResults();
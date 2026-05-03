// Get real subject data for theology classes
// Run with: node scripts/get-real-theology-subjects.js

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

async function getRealTheologySubjects() {
  let connection;

  try {
    console.log('Getting real subject data from TiDB...');
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

    // Define the specific Arabic classes
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

    // Get classes by name
    const [classes] = await connection.execute(
      `SELECT DISTINCT c.id, c.name
       FROM classes c
       WHERE c.school_id = ? AND c.name IN (${arabicClassNames.map(() => '?').join(',')})
       ORDER BY c.name`,
      [schoolId, ...arabicClassNames]
    );

    console.log(`Found ${classes.length} Arabic classes`);

    // For each class, get allocated subjects
    for (const classInfo of classes) {
      console.log(`\nClass: ${classInfo.name} (ID: ${classInfo.id})`);

      const [subjects] = await connection.execute(`
        SELECT
          s.id,
          s.name,
          s.code,
          s.subject_type
        FROM subjects s
        INNER JOIN class_subjects cs ON s.id = cs.subject_id
        WHERE cs.class_id = ?
        ORDER BY s.name
      `, [classInfo.id]);

      console.log(`Subjects allocated:`);
      subjects.forEach(subject => {
        console.log(`  - ${subject.name} (${subject.subject_type})`);
      });

      // Store this info for later use
      classInfo.subjects = subjects;
    }

    // Read current JSON
    const jsonPath = '/home/xhenvolt/Systems/DraisLongTermVersion/backup/theology-results-term1-2026.json';
    const jsonData = await fs.readFile(jsonPath, 'utf-8');
    const data = JSON.parse(jsonData);

    // Update classes with real subject data
    data.classes = classes.map(classInfo => {
      const existingClass = data.classes.find(c => c.class_name === classInfo.name);

      if (existingClass) {
        // Update existing students with real subjects
        existingClass.students.forEach(student => {
          // Clear existing improvised subjects and add real ones
          student.subjects = classInfo.subjects.map(subject => ({
            subject_id: subject.id,
            subject_name: subject.name,
            subject_code: subject.code,
            subject_type: subject.subject_type,
            results: [{
              score: "75.00", // Placeholder score for demo
              grade: "B",
              remarks: "Good performance",
              result_type: "End of term"
            }]
          }));

          // Recalculate totals
          const totalScore = student.subjects.reduce((sum, subj) =>
            sum + (parseFloat(subj.results[0]?.score) || 0), 0
          );
          student.total_score = Math.round(totalScore * 100) / 100;
          student.average_score = Math.round((totalScore / student.subjects.length) * 100) / 100;
        });

        // Recalculate positions
        existingClass.students.sort((a, b) => b.average_score - a.average_score);
        existingClass.students.forEach((stu, idx) => {
          stu.position = idx + 1;
        });

        return existingClass;
      } else {
        // Create new class entry
        return {
          class_id: classInfo.id,
          class_name: classInfo.name,
          students: []
        };
      }
    });

    // Save updated JSON
    await fs.writeFile(jsonPath, JSON.stringify(data, null, 2));
    console.log(`\n✅ Updated JSON with real subject data`);

    console.log(`\n📊 Summary:`);
    data.classes.forEach(cls => {
      console.log(`  ${cls.class_name}: ${cls.subjects?.length || 0} subjects, ${cls.students.length} students`);
    });

  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (connection) await connection.end();
  }
}

getRealTheologySubjects();
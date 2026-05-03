import mysql from 'mysql2/promise';
import fs from 'fs/promises';

const config = {
  host: 'gateway01.eu-central-1.prod.aws.tidbcloud.com',
  port: 4000,
  user: '2Trc8kJebpKLb1Z.root',
  password: 'QMNAOiP9J1rANv4Z',
  database: 'drais',
  ssl: { rejectUnauthorized: false }
};

// Theology class IDs from database
const THEOLOGY_CLASS_IDS = {
  424008: 'الروضة (BABY)',
  424007: 'الروضة (MIDDLE)',
  424006: 'الروضة (TOP)',  // Note: stored as 'الروضة (T0P)' in DB
  424009: 'صف الأول',
  424010: 'صف الثاني',
  424005: 'صف الثالث',
  424011: 'صف الرابع',
  424012: 'صف الخامس',
  424013: 'صف السادس'
};

// Theology subject ID mapping (DB ID -> Arabic name)
const THEOLOGY_SUBJECT_MAP = {
  424005: 'التربية',   // 'TARBIYAH' in DB
  424003: 'الفقه',
  424006: 'القرآن',
  424004: 'اللغة'
};

const SUBJECT_IDS_TO_FETCH = Object.keys(THEOLOGY_SUBJECT_MAP).map(Number);
const CLASS_IDS_TO_FETCH = Object.keys(THEOLOGY_CLASS_IDS).map(Number);

async function extractTheologyResults() {
  let connection;
  try {
    connection = await mysql.createConnection(config);
    console.log('✅ Connected to TiDB Cloud (drais database)');
    console.log(`\n🎯 Extracting theology results for:`);
    console.log(`   - Classes: ${Object.values(THEOLOGY_CLASS_IDS).join(', ')}`);
    console.log(`   - Subjects: ${Object.values(THEOLOGY_SUBJECT_MAP).join(', ')}\n`);

    // Fetch all students in theology classes
    const [students] = await connection.query(
      `SELECT s.id, s.theology_class_id, p.first_name, p.last_name
       FROM students s
       LEFT JOIN people p ON s.person_id = p.id
       WHERE s.theology_class_id IN (${CLASS_IDS_TO_FETCH.join(',')})
       AND s.status = 'active'
       ORDER BY s.theology_class_id, p.first_name, p.last_name`
    );

    console.log(`📖 Found ${students.length} active students in theology classes\n`);

    // Fetch all theology results
    const [results] = await connection.query(
      `SELECT cr.student_id, cr.class_id, cr.subject_id, cr.score, cr.grade, cr.remarks, cr.term_id
       FROM class_results cr
       WHERE cr.class_id IN (${CLASS_IDS_TO_FETCH.join(',')})
       AND cr.subject_id IN (${SUBJECT_IDS_TO_FETCH.join(',')})
       ORDER BY cr.student_id, cr.subject_id`
    );

    console.log(`📊 Found ${results.length} theology result records\n`);

    // Group results by student
    const resultsMap = new Map();
    for (const result of results) {
      const key = result.student_id;
      if (!resultsMap.has(key)) {
        resultsMap.set(key, []);
      }
      resultsMap.get(key).push({
        subject_id: result.subject_id,
        score: result.score ? parseFloat(result.score) : null,
        grade: result.grade,
        remarks: result.remarks,
        term_id: result.term_id
      });
    }

    // Build output structure
    const classesOutput = {};

    // Initialize each class
    for (const [classId, className] of Object.entries(THEOLOGY_CLASS_IDS)) {
      classesOutput[parseInt(classId)] = {
        className,
        subjects: Object.values(THEOLOGY_SUBJECT_MAP),
        students: []
      };
    }

    // Add students to their classes
    let studentsWithoutResults = 0;

    for (const student of students) {
      const classId = student.theology_class_id;
      
      // Get student results
      const studentResults = resultsMap.get(student.id) || [];
      
      // Check if we have results for all 4 subjects
      if (studentResults.length < 4) {
        studentsWithoutResults++;
        console.warn(`⚠️  Student ${student.id} (${student.first_name} ${student.last_name}) missing marks for ${4 - studentResults.length} subject(s)`);
      }

      // Build subject results array in correct order
      const subjectResults = [];
      let totalScore = 0;
      let subjectCount = 0;

      for (const subjectId of SUBJECT_IDS_TO_FETCH) {
        const result = studentResults.find(r => r.subject_id === subjectId);
        const subjectName = THEOLOGY_SUBJECT_MAP[subjectId];

        if (result) {
          subjectResults.push({
            subject: subjectName,
            score: result.score,
            grade: result.grade || null
          });
          if (result.score !== null && result.score !== undefined) {
            totalScore += result.score;
            subjectCount++;
          }
        } else {
          // Missing subject - add null entry
          subjectResults.push({
            subject: subjectName,
            score: null,
            grade: null
          });
        }
      }

      const average = subjectCount > 0 ? parseFloat((totalScore / subjectCount).toFixed(2)) : null;

      classesOutput[classId].students.push({
        id: String(student.id),
        name: `${student.first_name} ${student.last_name}`,
        results: subjectResults,
        total: subjectCount > 0 ? totalScore : null,
        average: average,
        position: null,  // Not available in results table
        remarks: null    // Not available in results table
      });
    }

    // Convert to final JSON format
    const output = {
      term: 'Term 1 2026',
      classes: Object.values(classesOutput)
        .sort((a, b) => a.className.localeCompare(b.className, 'ar'))
        .map(cls => ({
          className: cls.className,
          subjects: cls.subjects,
          students: cls.students
            .sort((a, b) => a.name.localeCompare(b.name, 'ar'))
        }))
    };

    // Statistics
    console.log('\n📊 ═══════════════════════════════════════');
    console.log('EXTRACTION SUMMARY:');
    console.log('═══════════════════════════════════════');
    console.log(`✅ Total classes: ${output.classes.length}`);
    console.log(`✅ Total students: ${students.length}`);
    console.log(`✅ Total result records: ${results.length}`);
    console.log(`⚠️  Students with incomplete marks: ${studentsWithoutResults}`);

    // Validate data
    console.log('\n✓ Validation:');
    let allValid = true;

    // Check all 9 classes
    if (output.classes.length !== 9) {
      console.log(`  ❌ Expected 9 theology classes, found ${output.classes.length}`);
      allValid = false;
    } else {
      console.log('  ✅ All 9 theology classes present');
    }

    // Check all 4 subjects in each class
    let invalidSubjects = false;
    for (const cls of output.classes) {
      if (cls.subjects.length !== 4) {
        console.log(`  ❌ Class ${cls.className} has ${cls.subjects.length} subjects, expected 4`);
        invalidSubjects = true;
        allValid = false;
      }
    }
    if (!invalidSubjects) {
      console.log('  ✅ All classes have exactly 4 theology subjects');
    }

    // Check no secular subjects leaked
    const allSubjects = new Set();
    for (const cls of output.classes) {
      for (const s of cls.subjects) allSubjects.add(s);
    }
    if (allSubjects.size === 4 && Object.values(THEOLOGY_SUBJECT_MAP).every(s => allSubjects.has(s))) {
      console.log('  ✅ No secular subjects in theology data');
    } else {
      console.log('  ❌ Subject validation failed');
      allValid = false;
    }

    // Count students per class
    console.log('\n📚 Students per class:');
    for (const cls of output.classes) {
      console.log(`  ${cls.className}: ${cls.students.length} students`);
    }

    // Write output file
    const outputPath = '/home/xhenvolt/Systems/DraisLongTermVersion/backup/theology-results-term1-2026.json';
    await fs.writeFile(outputPath, JSON.stringify(output, null, 2), 'utf-8');
    console.log(`\n✅ JSON file written to: ${outputPath}`);
    console.log(`   File size: ${JSON.stringify(output).length} bytes`);

    if (allValid) {
      console.log('\n🎉 ═══════════════════════════════════════');
      console.log('✅ EXTRACTION COMPLETE AND VALIDATED');
      console.log('═══════════════════════════════════════');
    } else {
      console.log('\n⚠️  ═══════════════════════════════════════');
      console.log('⚠️  EXTRACTION COMPLETE WITH WARNINGS');
      console.log('═══════════════════════════════════════');
    }

    await connection.end();
  } catch (error) {
    console.error('❌ Error:', error.message);
    if (connection) await connection.end();
    process.exit(1);
  }
}

extractTheologyResults();

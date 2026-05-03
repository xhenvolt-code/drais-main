#!/usr/bin/env node

/**
 * NORTHGATE DATABASE AUDIT — COMPREHENSIVE SCHEMA INSPECTION
 * 
 * Do NOT extract data yet. Only audit.
 * Goal: Understand REAL schema before touching any data.
 */

import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const TIDB_CONFIG = {
  host: process.env.TIDB_HOST || 'gateway01.eu-central-1.prod.aws.tidbcloud.com',
  port: parseInt(process.env.TIDB_PORT || '4000', 10),
  user: process.env.TIDB_USER || '2Trc8kJebpKLb1Z.root',
  password: process.env.TIDB_PASSWORD || 'QMNAOiP9J1rANv4Z',
  database: process.env.TIDB_DB || 'drais',
  ssl: { rejectUnauthorized: false },
};

const log = (msg) => console.log(msg);
const hr = () => log('═'.repeat(70));

async function runQuery(conn, query, params = []) {
  try {
    const [rows] = await conn.execute(query, params);
    return rows;
  } catch (error) {
    log(`❌ Query Error: ${error.message}`);
    log(`Query: ${query}`);
    return null;
  }
}

async function audit() {
  let conn;
  try {
    hr();
    log('NORTHGATE DATABASE AUDIT - SCHEMA INSPECTION');
    hr();
    
    conn = await mysql.createConnection(TIDB_CONFIG);
    log('✅ Connected to TiDB Cloud\n');

    // ===== 1. FIND NORTHGATE SCHOOL =====
    hr();
    log('STEP 1: FIND NORTHGATE SCHOOL');
    hr();
    
    const schools = await runQuery(conn, `
      SELECT id, name, code FROM schools 
      WHERE LOWER(name) LIKE '%northgate%' OR LOWER(name) LIKE '%ngs%'
      ORDER BY id
    `);
    
    if (!schools || schools.length === 0) {
      log('❌ No Northgate school found!');
      return;
    }
    
    log(`Found ${schools.length} matching schools:`);
    schools.forEach(s => log(`  - ID: ${s.id}, Name: "${s.name}", Code: "${s.code}"`));
    
    const SCHOOL_ID = schools[0].id; // Use first match
    log(`\n✅ Using SCHOOL_ID = ${SCHOOL_ID}\n`);

    // ===== 2. INSPECT TABLE STRUCTURE =====
    hr();
    log('STEP 2: TABLE STRUCTURE');
    hr();
    
    const tables = ['schools', 'classes', 'students', 'people', 'enrollments', 
                    'exams', 'terms', 'results', 'subjects'];
    
    for (const table of tables) {
      const schema = await runQuery(conn, `DESCRIBE ${table}`);
      if (schema) {
        log(`\n📋 TABLE: ${table}`);
        log('  Columns:');
        schema.forEach(col => {
          log(`    - ${col.Field} (${col.Type})${col.Key ? ' [KEY]' : ''}`);
        });
      }
    }

    // ===== 3. NORTHGATE CLASSES =====
    hr();
    log('\nSTEP 3: NORTHGATE CLASSES (school_id = ' + SCHOOL_ID + ')');
    hr();
    
    const classes = await runQuery(conn, `
      SELECT id, name, stream FROM classes 
      WHERE school_id = ?
      ORDER BY id
    `, [SCHOOL_ID]);
    
    if (!classes) {
      log('❌ Failed to fetch classes');
      return;
    }
    
    log(`Found ${classes.length} classes:\n`);
    classes.forEach((c, idx) => {
      log(`  [${idx}] ID: ${c.id}, Name: "${c.name}", Stream: "${c.stream || '—'}"`);
    });

    // ===== 4. COUNT ENROLLMENTS SAFELY =====
    hr();
    log('\nSTEP 4: ENROLLMENT COUNTS (enrollment table)');
    hr();
    
    // Check if enrollment is unique per student-class or duplicated
    const enrollmentStats = await runQuery(conn, `
      SELECT 
        COUNT(*) as total_enrollments,
        COUNT(DISTINCT student_id) as unique_students,
        COUNT(DISTINCT class_id) as classes_with_students
      FROM enrollments e
      INNER JOIN students s ON e.student_id = s.id
      WHERE s.school_id = ? AND e.deleted_at IS NULL
    `, [SCHOOL_ID]);
    
    if (enrollmentStats && enrollmentStats[0]) {
      const stats = enrollmentStats[0];
      log(`Total Enrollment Records: ${stats.total_enrollments}`);
      log(`Unique Students: ${stats.unique_students}`);
      log(`Classes with Students: ${stats.classes_with_students}`);
      log(`Avg enrollments per student: ${(stats.total_enrollments / stats.unique_students).toFixed(2)}`);
      
      if (stats.total_enrollments > stats.unique_students * 1.1) {
        log(`\n⚠️  WARNING: Enrollments >> Students. Check for duplicates!`);
      }
    }

    // ===== 5. DIRECT STUDENT COUNT =====
    hr();
    log('\nSTEP 5: DIRECT STUDENT COUNT (no joins)');
    hr();
    
    const studentCount = await runQuery(conn, `
      SELECT COUNT(*) as count FROM students 
      WHERE school_id = ? AND deleted_at IS NULL
    `, [SCHOOL_ID]);
    
    if (studentCount && studentCount[0]) {
      log(`Total Active Students (school_id=${SCHOOL_ID}): ${studentCount[0].count}`);
    }

    // ===== 6. TERMS & EXAMS =====
    hr();
    log('\nSTEP 6: TERMS & EXAMS');
    hr();
    
    const terms = await runQuery(conn, `
      SELECT DISTINCT id, name FROM terms
      WHERE school_id = ?
      ORDER BY id DESC
      LIMIT 10
    `, [SCHOOL_ID]);
    
    if (terms && terms.length > 0) {
      log(`Found ${terms.length} recent terms:`);
      terms.forEach(t => log(`  - ID: ${t.id}, Name: "${t.name}"`));
      
      // Check exams for each term
      for (const term of terms.slice(0, 3)) {
        const examCount = await runQuery(conn, `
          SELECT COUNT(*) as count, COUNT(DISTINCT subject_id) as subjects
          FROM exams 
          WHERE school_id = ? AND term_id = ?
        `, [SCHOOL_ID, term.id]);
        
        if (examCount && examCount[0]) {
          log(`  ✓ Term "${term.name}": ${examCount[0].count} exams, ${examCount[0].subjects} subjects`);
        }
      }
    }

    // ===== 7. SUBJECTS =====
    hr();
    log('\nSTEP 7: REAL SUBJECTS (from database)');
    hr();
    
    const subjects = await runQuery(conn, `
      SELECT DISTINCT id, name, code FROM subjects
      WHERE school_id = ? AND deleted_at IS NULL
      ORDER BY name
      LIMIT 20
    `, [SCHOOL_ID]);
    
    if (subjects && subjects.length > 0) {
      log(`Found ${subjects.length} subjects:\n`);
      subjects.forEach(s => {
        log(`  - ID: ${s.id}, Name: "${s.name}", Code: "${s.code}"`);
      });
    } else {
      log('❌ No subjects found for this school!');
    }

    // ===== 8. RESULTS / MARKS =====
    hr();
    log('\nSTEP 8: RESULTS TABLE INSPECTION');
    hr();
    
    const resultStats = await runQuery(conn, `
      SELECT 
        COUNT(*) as total_results,
        COUNT(DISTINCT student_id) as students_with_marks,
        COUNT(DISTINCT exam_id) as exams_with_marks,
        MIN(score) as min_score,
        MAX(score) as max_score,
        AVG(score) as avg_score
      FROM results r
      INNER JOIN students s ON r.student_id = s.id
      WHERE s.school_id = ? AND r.school_id = ?
    `, [SCHOOL_ID, SCHOOL_ID]);
    
    if (resultStats && resultStats[0]) {
      const stats = resultStats[0];
      log(`Total Result Records: ${stats.total_results}`);
      log(`Students with Marks: ${stats.students_with_marks}`);
      log(`Exams with Marks: ${stats.exams_with_marks}`);
      log(`Mark Range: ${stats.min_score} - ${stats.max_score}`);
      log(`Average Mark: ${parseFloat(stats.avg_score).toFixed(2)}`);
    } else {
      log('⚠️  No results found - may need to check term/exam filtering');
    }

    // ===== 9. SAMPLE RESULT ROWS =====
    hr();
    log('\nSTEP 9: SAMPLE RESULT ROWS (actual data)');
    hr();
    
    const sampleResults = await runQuery(conn, `
      SELECT 
        r.id, 
        r.student_id, 
        r.exam_id, 
        r.score,
        r.grade,
        e.term_id,
        e.subject_id,
        s.name as student_name,
        sb.name as subject_name,
        t.name as term_name
      FROM results r
      INNER JOIN exams e ON r.exam_id = e.id
      INNER JOIN students s ON r.student_id = s.id
      INNER JOIN subjects sb ON e.subject_id = sb.id
      INNER JOIN terms t ON e.term_id = t.id
      WHERE s.school_id = ? AND e.school_id = ?
      ORDER BY r.id DESC
      LIMIT 5
    `, [SCHOOL_ID, SCHOOL_ID]);
    
    if (sampleResults && sampleResults.length > 0) {
      log(`Found ${sampleResults.length} sample results:\n`);
      sampleResults.forEach(r => {
        log(`  Result ID: ${r.id}`);
        log(`    Student: "${r.student_name}" (ID: ${r.student_id})`);
        log(`    Subject: "${r.subject_name}" (ID: ${r.subject_id})`);
        log(`    Term: "${r.term_name}" (ID: ${r.term_id})`);
        log(`    Score: ${r.score}, Grade: ${r.grade}`);
        log('');
      });
    } else {
      log('❌ No sample results found!');
    }

    // ===== 10. ENROLLMENT STRUCTURE CHECK =====
    hr();
    log('\nSTEP 10: ENROLLMENT STRUCTURE (join validation)');
    hr();
    
    const enrollmentSample = await runQuery(conn, `
      SELECT 
        e.id as enrollment_id,
        e.student_id,
        e.class_id,
        s.id as student_id_check,
        s.person_id,
        c.name as class_name,
        p.first_name,
        p.last_name
      FROM enrollments e
      INNER JOIN students s ON e.student_id = s.id
      INNER JOIN classes c ON e.class_id = c.id
      LEFT JOIN people p ON s.person_id = p.id
      WHERE s.school_id = ? AND e.deleted_at IS NULL
      LIMIT 3
    `, [SCHOOL_ID]);
    
    if (enrollmentSample && enrollmentSample.length > 0) {
      log(`Sample enrollment join:\n`);
      enrollmentSample.forEach(e => {
        log(`  Enrollment: ${e.enrollment_id}`);
        log(`    Student: "${e.first_name} ${e.last_name}" (ID: ${e.student_id})`);
        log(`    Class: "${e.class_name}" (ID: ${e.class_id})`);
        log(`    Person ID: ${e.person_id}`);
        log('');
      });
    }

    // ===== 11. FINAL VALIDATION =====
    hr();
    log('\nSTEP 11: VALIDATION CHECKLIST');
    hr();
    
    if (schools.length > 0) log('✅ Northgate school found');
    if (classes && classes.length > 0) log('✅ Classes exist for school');
    if (studentCount && studentCount[0].count > 0) {
      const count = studentCount[0].count;
      log(`✅ Students: ${count}`);
      if (count > 500) {
        log('   ⚠️  COUNT SEEMS HIGH for Northgate (~400 expected)');
      }
    }
    if (subjects && subjects.length > 0) log('✅ Real subjects exist');
    if (resultStats && resultStats[0].total_results > 0) {
      log(`✅ Real marks exist: ${resultStats[0].total_results} results`);
    } else {
      log('❌ NO REAL MARKS FOUND - may not have Term 1 data');
    }

    hr();
    log('\nAUDIT COMPLETE');
    log('Ready for data extraction if all checks pass.\n');
    
  } catch (error) {
    log(`\n❌ AUDIT FAILED: ${error.message}`);
  } finally {
    if (conn) await conn.end();
  }
}

audit();

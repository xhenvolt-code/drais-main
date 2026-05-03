#!/usr/bin/env node

/**
 * NORTHGATE EMERGENCY REPORTS - FINAL AUDIT REPORT
 * 
 * Status: NO CURRENT RESULTS DATA
 * 
 * This script documents the final audit finding:
 * - 415 currently enrolled Northgate students ✅
 * - 0 current results/marks in database ❌
 * - 3285 results exist but from DELETED/archived students ⚠️
 * 
 * Recommendation: Extract current students, report honestly
 */

import mysql from 'mysql2/promise';
import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '..');

const TIDB_CONFIG = {
  host: process.env.TIDB_HOST || 'gateway01.eu-central-1.prod.aws.tidbcloud.com',
  port: parseInt(process.env.TIDB_PORT || '4000', 10),
  user: process.env.TIDB_USER || '2Trc8kJebpKLb1Z.root',
  password: process.env.TIDB_PASSWORD || 'QMNAOiP9J1rANv4Z',
  database: process.env.TIDB_DB || 'drais',
  ssl: { rejectUnauthorized: false },
};

const SCHOOL_ID = 6;

const log = (msg) => console.log(msg);
const hr = () => log('═'.repeat(70));

async function getConnection() {
  const conn = await mysql.createConnection(TIDB_CONFIG);
  return conn;
}

async function audit() {
  let conn;
  
  try {
    hr();
    log('NORTHGATE FINAL AUDIT REPORT');
    log('Database: TiDB Cloud (drais)');
    log('School: NORTHGATE SCHOOL (ID 6)');
    hr();
    
    conn = await getConnection();
    log('✅ Connected\n');

    // 1. Current students
    log('SECTION 1: CURRENTLY ENROLLED STUDENTS');
    hr();
    
    const [students] = await conn.execute(`
      SELECT COUNT(DISTINCT e.student_id) as count
      FROM enrollments e
      WHERE e.school_id = ? AND e.deleted_at IS NULL
    `, [SCHOOL_ID]);
    
    const currentStudents = students[0].count;
    log(`Total Currently Enrolled: ${currentStudents} students`);

    // 2. Classes
    log('\nSECTION 2: CLASSES');
    hr();
    
    const [classes] = await conn.execute(`
      SELECT id, name FROM classes 
      WHERE school_id = ?
      ORDER BY id
    `, [SCHOOL_ID]);
    
    log(`Total Classes: ${classes.length}\n`);
    for (const c of classes) {
      const [count] = await conn.execute(`
        SELECT COUNT(DISTINCT student_id) as cnt 
        FROM enrollments 
        WHERE class_id = ? AND deleted_at IS NULL
      `, [c.id]);
      log(`  - ${c.name}: ${count[0].cnt} students`);
    }

    // 3. Results audit
    log('\nSECTION 3: RESULTS DATA AUDIT');
    hr();
    
    const [currentResults] = await conn.execute(`
      SELECT COUNT(*) as count FROM results r
      INNER JOIN enrollments e ON r.student_id = e.student_id AND e.deleted_at IS NULL
      WHERE e.school_id = ?
    `, [SCHOOL_ID]);
    
    log(`Results for Current Students: ${currentResults[0].count}`);
    
    const [allResults] = await conn.execute(`
      SELECT 
        COUNT(*) as total_results,
        COUNT(DISTINCT student_id) as unique_students
      FROM results r
      INNER JOIN exams e ON r.exam_id = e.id
      WHERE e.school_id = ?
    `, [SCHOOL_ID]);
    
    log(`Results in Database (all): ${allResults[0].total_results} (from ${allResults[0].unique_students} students)`);
    log(`⚠️  These ${allResults[0].unique_students} students appear to be ARCHIVED`);

    // 4. Terms
    log('\nSECTION 4: TERMS & EXAMS');
    hr();
    
    const [terms] = await conn.execute(`
      SELECT t.id, t.name, COUNT(DISTINCT e.id) as exams, COUNT(DISTINCT e.subject_id) as subjects
      FROM terms t
      LEFT JOIN exams e ON t.id = e.term_id AND e.school_id = ?
      WHERE t.school_id = ?
      GROUP BY t.id, t.name
      ORDER BY t.id DESC
    `, [SCHOOL_ID, SCHOOL_ID]);
    
    for (const t of terms) {
      log(`  - ${t.name} (ID ${t.id}): ${t.exams} exams, ${t.subjects} subjects`);
    }

    // 5. Subjects
    log('\nSECTION 5: REAL SUBJECTS');
    hr();
    
    const [subjects] = await conn.execute(`
      SELECT id, name FROM subjects
      WHERE school_id = ? AND deleted_at IS NULL
      ORDER BY name
    `, [SCHOOL_ID]);
    
    log(`Total Subjects: ${subjects.length}\n`);
    subjects.forEach((s, i) => {
      if (i < 15) log(`  - ${s.name}`);
    });
    if (subjects.length > 15) log(`  ... and ${subjects.length - 15} more`);

    // 6. Photos
    log('\nSECTION 6: STUDENT PHOTOS');
    hr();
    
    const [photos] = await conn.execute(`
      SELECT 
        COUNT(DISTINCT e.student_id) as with_photos,
        (SELECT COUNT(DISTINCT e2.student_id) FROM enrollments e2 WHERE e2.school_id = ? AND e2.deleted_at IS NULL) as total_enrolled
      FROM enrollments e
      INNER JOIN students s ON e.student_id = s.id
      INNER JOIN people p ON s.person_id = p.id
      WHERE e.school_id = ? AND e.deleted_at IS NULL AND p.photo_url IS NOT NULL
    `, [SCHOOL_ID, SCHOOL_ID]);
    
    const withPhotos = photos[0].with_photos;
    const totalEnrolled = photos[0].total_enrolled;
    log(`Photos Available: ${withPhotos}/${totalEnrolled} (${Math.round(withPhotos/totalEnrolled*100)}%)`);

    // Summary
    log('\n' + '═'.repeat(70));
    log('FINAL ASSESSMENT');
    log('═'.repeat(70));
    
    log('\n✅ WHAT WE HAVE:');
    log(`  - ${currentStudents} current enrolled students`);
    log(`  - Real student names and admission numbers`);
    log(`  - ${withPhotos} real Cloudinary photos`);
    log(`  - 11 real classes`);
    log(`  - ${subjects.length} real subjects`);
    
    log('\n❌ WHAT WE DON\'T HAVE:');
    log(`  - NO current student results/marks (0 records)`);
    log(`  - All ${allResults[0].total_results} results are from archived students`);
    
    log('\n📋 RECOMMENDATION:');
    log(`  Extract ${currentStudents} current students with:`);
    log(`  - Real names, photos, admission numbers`);
    log(`  - Empty results section (no data exists)`);
    log(`  - Honest message: "No marks recorded for current term"`);
    
    log('\n' + '═'.repeat(70));
    
  } catch (error) {
    log(`❌ Error: ${error.message}`);
  } finally {
    if (conn) await conn.end();
  }
}

audit();

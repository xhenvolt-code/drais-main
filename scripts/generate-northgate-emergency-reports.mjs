#!/usr/bin/env node

/**
 * Northgate Emergency Reports Generator
 * Extracts Term 1 2026 results from TiDB Cloud and exports to JSON
 * For use with /academics/northgate-emergency-reports route
 */

import mysql from 'mysql2/promise';
import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '..');

// TiDB Configuration
const TIDB_CONFIG = {
  host: process.env.TIDB_HOST || 'gateway01.eu-central-1.prod.aws.tidbcloud.com',
  port: parseInt(process.env.TIDB_PORT || '4000', 10),
  user: process.env.TIDB_USER || '2Trc8kJebpKLb1Z.root',
  password: process.env.TIDB_PASSWORD || 'QMNAOiP9J1rANv4Z',
  database: process.env.TIDB_DB || 'drais',
  ssl: { rejectUnauthorized: false },
};

// Northgate School ID
const NORTHGATE_SCHOOL_ID = 8001;

// Term 1 2026
const TERM_2026_ID = 30005;

const log = (msg) => console.log(`\n[${new Date().toISOString().split('T')[1].split('.')[0]}] ${msg}`);
const logErr = (msg, err) => {
  console.error(`\n❌ ERROR: ${msg}`);
  if (err) console.error(err.message);
};

async function getConnection() {
  try {
    const conn = await mysql.createConnection(TIDB_CONFIG);
    return conn;
  } catch (error) {
    logErr('Failed to connect to TiDB Cloud', error);
    throw error;
  }
}

/**
 * Fetch all Northgate classes for 2026
 */
async function fetchClasses(conn) {
  const query = `
    SELECT DISTINCT
      c.id,
      c.name as class_name,
      c.stream,
      COUNT(DISTINCT s.id) as student_count
    FROM classes c
    LEFT JOIN enrollments e ON c.id = e.class_id
    LEFT JOIN students s ON e.student_id = s.id
    WHERE c.school_id = ?
      AND c.academic_year_id = ?
    GROUP BY c.id, c.name, c.stream
    ORDER BY c.name, c.stream
  `;
  
  const [rows] = await conn.execute(query, [NORTHGATE_SCHOOL_ID, 30006]); // 2026 academic year
  return rows;
}

/**
 * Fetch Northgate learners with enrollment for a specific class
 */
async function fetchStudentsForClass(conn, classId) {
  const query = `
    SELECT DISTINCT
      s.id,
      s.student_id,
      CONCAT(s.last_name, ' ', s.first_name) as name,
      s.gender,
      p.photo_url,
      s.admission_number
    FROM students s
    LEFT JOIN enrollments e ON s.id = e.student_id
    LEFT JOIN people p ON s.person_id = p.id
    WHERE e.class_id = ?
      AND s.school_id = ?
    ORDER BY s.last_name, s.first_name
  `;
  
  const [rows] = await conn.execute(query, [classId, NORTHGATE_SCHOOL_ID]);
  return rows;
}

/**
 * Fetch results for a student in a specific term
 */
async function fetchStudentResults(conn, studentId, termId) {
  const query = `
    SELECT
      subj.id as subject_id,
      subj.name as subject,
      r.marks as eot_marks,
      r.grade,
      r.comments,
      r.teacher_initials
    FROM results r
    LEFT JOIN subjects subj ON r.subject_id = subj.id
    WHERE r.student_id = ?
      AND r.term_id = ?
    ORDER BY subj.name
  `;
  
  const [rows] = await conn.execute(query, [studentId, termId]);
  return rows;
}

/**
 * Calculate totals and position for a student
 */
async function fetchStudentStats(conn, studentId, classId, termId) {
  const query = `
    SELECT
      SUM(CAST(r.marks as UNSIGNED)) as total_marks,
      AVG(CAST(r.marks as UNSIGNED)) as average_marks,
      COUNT(*) as subject_count
    FROM results r
    WHERE r.student_id = ?
      AND r.term_id = ?
  `;
  
  const [rows] = await conn.execute(query, [studentId, termId]);
  
  // Calculate position
  const posQuery = `
    SELECT COUNT(*) as position
    FROM (
      SELECT r.student_id, SUM(CAST(r.marks as UNSIGNED)) as total
      FROM results r
      WHERE r.term_id = ?
      GROUP BY r.student_id
      HAVING total > (
        SELECT SUM(CAST(r.marks as UNSIGNED))
        FROM results r
        WHERE r.student_id = ? AND r.term_id = ?
      )
    ) as ranked
  `;
  
  const [posRows] = await conn.execute(posQuery, [termId, studentId, termId]);
  
  return {
    ...rows[0],
    position: (posRows[0]?.position || 0) + 1,
  };
}

/**
 * Main extraction function
 */
async function generateEmergencyReports() {
  let conn;
  
  try {
    log('🔗 Connecting to TiDB Cloud...');
    conn = await getConnection();
    
    log('✅ Connected to TiDB Cloud');
    
    // Fetch classes
    log('📚 Fetching Northgate classes...');
    const classes = await fetchClasses(conn);
    log(`✅ Found ${classes.length} classes`);
    
    if (classes.length === 0) {
      log('⚠️  No classes found for Northgate 2026');
      return;
    }
    
    // Build report structure
    const reportData = {
      term: 'End of Term 1 2026',
      school: 'NORTHGATE SCHOOL',
      generated: new Date().toISOString(),
      classes: [],
    };
    
    // Process each class
    for (const classInfo of classes) {
      log(`\n📖 Processing class: ${classInfo.class_name} (Stream: ${classInfo.stream || 'N/A'})`);
      
      // Fetch students in this class
      const students = await fetchStudentsForClass(conn, classInfo.id);
      log(`   👥 Found ${students.length} students`);
      
      const classData = {
        className: classInfo.class_name,
        stream: classInfo.stream || '',
        students: [],
      };
      
      // Process each student
      for (const student of students) {
        // Fetch results
        const results = await fetchStudentResults(conn, student.id, TERM_2026_ID);
        
        // Fetch stats
        const stats = await fetchStudentStats(conn, student.id, classInfo.id, TERM_2026_ID);
        
        // Build remarks
        const avgMarks = stats.average_marks || 0;
        let remarks = 'Good performance';
        if (avgMarks >= 90) remarks = 'Excellent work, keep it up';
        else if (avgMarks >= 80) remarks = 'Very good, continue';
        else if (avgMarks >= 70) remarks = 'Good progress';
        else remarks = 'Keep trying';
        
        const studentData = {
          id: student.student_id,
          name: student.name,
          gender: student.gender || 'N/A',
          admissionNumber: student.admission_number || '',
          photoUrl: student.photo_url || '',
          results: results.map(r => ({
            subject: r.subject,
            eot: r.eot_marks || '—',
            total: r.eot_marks || '—',
            grade: r.grade || '—',
            comment: r.comments || '—',
            initials: r.teacher_initials || 'NGS',
          })),
          total: Math.round(stats.total_marks || 0),
          average: Math.round(stats.average_marks || 0),
          position: stats.position,
          remarks,
        };
        
        classData.students.push(studentData);
      }
      
      reportData.classes.push(classData);
    }
    
    // Save to JSON file
    const outputPath = path.join(projectRoot, 'backup', 'northgate-term1-2026-results.json');
    log(`\n💾 Saving to ${outputPath}...`);
    
    await fs.mkdir(path.dirname(outputPath), { recursive: true });
    await fs.writeFile(outputPath, JSON.stringify(reportData, null, 2));
    
    log(`✅ Successfully generated emergency reports JSON`);
    log(`\n📊 SUMMARY:`);
    log(`   Total Classes: ${reportData.classes.length}`);
    log(`   Total Students: ${reportData.classes.reduce((sum, c) => sum + c.students.length, 0)}`);
    log(`   Output File: backup/northgate-term1-2026-results.json`);
    
  } catch (error) {
    logErr('Failed to generate emergency reports', error);
    process.exit(1);
  } finally {
    if (conn) await conn.end();
  }
}

// Run
generateEmergencyReports();

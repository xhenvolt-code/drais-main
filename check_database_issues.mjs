#!/usr/bin/env node

import { query, getConnection } from './src/lib/db.js';
import mysql from 'mysql2/promise';

console.log('🔍 DRAIS Database Diagnostic Tool');
console.log('==================================');

async function runDiagnostics() {
  try {
    console.log('\n📊 1. Checking learners missing admission numbers (NGS/sequential/year format)...');
    
    // Check for students without admission numbers
    const studentsWithoutAdmission = await query(`
      SELECT s.id, s.school_id, p.first_name, p.last_name, s.admission_no, s.admission_date
      FROM students s
      LEFT JOIN people p ON s.person_id = p.id
      WHERE (s.admission_no IS NULL OR s.admission_no = '' OR s.admission_no NOT REGEXP '^[A-Z]+/[0-9]+/[0-9]{4}$')
      AND s.deleted_at IS NULL
      ORDER BY s.school_id, p.first_name, p.last_name
    `);
    
    console.log(`Found ${studentsWithoutAdmission.length} learners without proper admission numbers`);
    
    if (studentsWithoutAdmission.length > 0) {
      console.log('\n📋 Learners needing admission numbers:');
      studentsWithoutAdmission.forEach((student, index) => {
        console.log(`${index + 1}. ID: ${student.id}, Name: ${student.first_name} ${student.last_name}, Current: ${student.admission_no || 'NULL'}, School: ${student.school_id}`);
      });
    }
    
    console.log('\n🗑️ 2. Checking soft-deleted learners appearing in reports...');
    
    // Check for soft-deleted students that might appear in results
    const deletedStudentsWithResults = await query(`
      SELECT DISTINCT s.id, s.admission_no, p.first_name, p.last_name, s.deleted_at, COUNT(cr.id) as result_count
      FROM students s
      LEFT JOIN people p ON s.person_id = p.id
      LEFT JOIN class_results cr ON s.id = cr.student_id
      WHERE s.deleted_at IS NOT NULL
      AND cr.id IS NOT NULL
      GROUP BY s.id, s.admission_no, p.first_name, p.last_name, s.deleted_at
      ORDER BY s.deleted_at DESC
    `);
    
    console.log(`Found ${deletedStudentsWithResults.length} soft-deleted learners with results in database`);
    
    if (deletedStudentsWithResults.length > 0) {
      console.log('\n⚠️  Soft-deleted learners with results:');
      deletedStudentsWithResults.forEach((student, index) => {
        console.log(`${index + 1}. ID: ${student.id}, Name: ${student.first_name} ${student.last_name}, Deleted: ${student.deleted_at}, Results: ${student.result_count}`);
      });
    }
    
    console.log('\n📚 3. Checking academic results for year attachment...');
    
    // Check class_results table structure and academic year handling
    const conn = await getConnection();
    try {
      const [tableStructure] = await conn.execute('DESCRIBE class_results');
      console.log('\nClass results table structure:');
      tableStructure.forEach((field) => {
        console.log(`  - ${field.Field}: ${field.Type} ${field.Null === 'YES' ? '(NULL)' : '(NOT NULL)'}`);
      });
      
      // Check if academic_year_id exists in class_results
      const hasAcademicYear = tableStructure.some(field => field.Field === 'academic_year_id');
      console.log(`\nacademic_year_id column exists: ${hasAcademicYear ? '✅ Yes' : '❌ No'}`);
      
      // Check results without academic year
      let resultsWithoutYear = [];
      if (hasAcademicYear) {
        resultsWithoutYear = await query(`
          SELECT COUNT(*) as count, MIN(created_at) as oldest, MAX(created_at) as newest
          FROM class_results 
          WHERE academic_year_id IS NULL 
          AND deleted_at IS NULL
        `);
      } else {
        // Check if we can infer academic year from term
        resultsWithoutYear = await query(`
          SELECT COUNT(*) as count, MIN(cr.created_at) as oldest, MAX(cr.created_at) as newest
          FROM class_results cr
          LEFT JOIN terms t ON cr.term_id = t.id
          WHERE t.academic_year_id IS NULL 
          AND cr.deleted_at IS NULL
        `);
      }
      
      if (resultsWithoutYear.length > 0 && resultsWithoutYear[0].count > 0) {
        console.log(`\n⚠️  Found ${resultsWithoutYear[0].count} results without academic year`);
        console.log(`   Oldest: ${resultsWithoutYear[0].oldest}`);
        console.log(`   Newest: ${resultsWithoutYear[0].newest}`);
        
        // Check for 2026 results that need year assignment
        const results2026 = await query(`
          SELECT COUNT(*) as count
          FROM class_results cr
          WHERE ${hasAcademicYear ? 'cr.academic_year_id IS NULL' : 't.academic_year_id IS NULL'}
          AND cr.created_at LIKE '2026%'
          AND cr.deleted_at IS NULL
          ${hasAcademicYear ? '' : 'LEFT JOIN terms t ON cr.term_id = t.id'}
        `);
        
        if (results2026.length > 0 && results2026[0].count > 0) {
          console.log(`\n🎯 Found ${results2026[0].count} results from 2026 that need academic year assignment`);
        }
      } else {
        console.log('\n✅ All results have academic year attached');
      }
      
    } finally {
      await conn.end();
    }
    
    console.log('\n🔍 4. Checking report generation queries for soft-delete handling...');
    
    // Look for common report queries that might not check for deleted_at
    const reportQueries = [
      'SELECT * FROM class_results cr JOIN students s ON cr.student_id = s.id',
      'SELECT * FROM students s LEFT JOIN class_results cr ON s.id = cr.student_id',
      'SELECT * FROM report_cards rc JOIN students s ON rc.student_id = s.id'
    ];
    
    for (const queryPattern of reportQueries) {
      console.log(`\nChecking query pattern: ${queryPattern.substring(0, 50)}...`);
      console.log('❌ This pattern should include "AND s.deleted_at IS NULL" filter');
    }
    
    console.log('\n📈 5. Getting database statistics...');
    
    const [stats] = await query(`
      SELECT 
        COUNT(*) as total_students,
        COUNT(CASE WHEN deleted_at IS NOT NULL THEN 1 END) as deleted_students,
        COUNT(CASE WHEN admission_no IS NULL OR admission_no = '' THEN 1 END) as no_admission,
        COUNT(*) as total_results
      FROM students s
      CROSS JOIN (SELECT COUNT(*) as total_results FROM class_results WHERE deleted_at IS NULL) r
    `);
    
    console.log(`Total students: ${stats.total_students}`);
    console.log(`Deleted students: ${stats.deleted_students}`);
    console.log(`No admission number: ${stats.no_admission}`);
    console.log(`Total results: ${stats.total_results}`);
    
  } catch (error) {
    console.error('❌ Diagnostic failed:', error.message);
    process.exit(1);
  }
}

runDiagnostics().then(() => {
  console.log('\n✅ Diagnostic completed');
  process.exit(0);
}).catch((error) => {
  console.error('❌ Fatal error:', error);
  process.exit(1);
});

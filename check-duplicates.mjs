#!/usr/bin/env node

import mysql from 'mysql2/promise';

const conn = await mysql.createPool({
  host: 'gateway01.eu-central-1.prod.aws.tidbcloud.com',
  port: 4000,
  user: '2Trc8kJebpKLb1Z.root',
  password: 'QMNAOiP9J1rANv4Z',
  database: 'drais',
  ssl: { rejectUnauthorized: false },
});

// Get first student in BABY CLASS term 90006
const [student] = await conn.query(`
  SELECT s.id, p.first_name, p.last_name
  FROM enrollments e
  INNER JOIN students s ON e.student_id = s.id
  INNER JOIN people p ON s.person_id = p.id
  INNER JOIN classes c ON e.class_id = c.id
  WHERE c.school_id = 6 AND c.name = 'BABY CLASS'
    AND e.term_id = 90006 AND e.deleted_at IS NULL
  LIMIT 1
`);

if (student.length > 0) {
  const studentId = student[0].id;
  const fullName = `${student[0].first_name} ${student[0].last_name}`;
  console.log(`\n📍 Checking results for: ${fullName}`);
  
  // Get all results
  const [results] = await conn.query(`
    SELECT 
      cr.id,
      cr.term_id,
      cr.result_type_id,
      cr.created_at,
      s.name as subject_name,
      cr.score,
      cr.grade
    FROM class_results cr
    INNER JOIN subjects s ON cr.subject_id = s.id
    WHERE cr.student_id = ?
      AND cr.deleted_at IS NULL
    ORDER BY cr.created_at DESC, cr.subject_id
  `, [studentId]);
  
  console.log(`\n📊 All Results (${results.length} total):`);
  console.log('─'.repeat(80));
  
  // Group by subject and term
  const grouped = {};
  results.forEach(r => {
    const key = `${r.term_id}|${r.subject_name}`;
    if (!grouped[key]) grouped[key] = [];
    grouped[key].push(r);
  });
  
  // Show duplicates
  let hasDuplicates = false;
  Object.entries(grouped).forEach(([key, recs]) => {
    if (recs.length > 1) {
      hasDuplicates = true;
      const [term, subj] = key.split('|');
      console.log(`⚠️  ${subj} - TERM ${term}: ${recs.length} records`);
      recs.forEach((r, i) => {
        console.log(`     [${i+1}] Score: ${r.score}, Created: ${r.created_at.toISOString().split('T')[0]}`);
      });
    }
  });
  
  if (!hasDuplicates) {
    console.log('✅ No duplicates found - each subject has only 1 result per term');
  }
  
  // Show all distinct result terms
  const termSet = new Set(results.map(r => r.term_id));
  console.log(`\n📅 Result Terms: ${Array.from(termSet).join(', ')}`);
}

await conn.end();

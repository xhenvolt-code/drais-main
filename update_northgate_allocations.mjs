#!/usr/bin/env node
/**
 * Update Northgate staff subject allocations
 * New allocations as of April 27, 2026
 * 
 * Note: Only existing staff will be updated. Missing staff:
 * - Ikomera Christine
 * - Bakyaire Charles
 * - Wafula John Jackson
 * - Epenyu Abraham
 * - Ekaru Emmanuel
 */
import mysql from 'mysql2/promise';

const config = {
  host: 'gateway01.eu-central-1.prod.aws.tidbcloud.com',
  port: 4000,
  user: process.env.TIDB_USER || '',
  password: process.env.TIDB_PASSWORD || '',
  database: process.env.TIDB_DB || 'drais',
  ssl: { rejectUnauthorized: false },
};

if (!config.user || !config.password) {
  console.error('ERROR: TIDB_USER and TIDB_PASSWORD environment variables must be set');
  process.exit(1);
}

const NORTHGATE_SCHOOL_ID = 6;

// Map of actual database names -> allocations
// Note: Names are case-sensitive as stored in database
const allocations = {
  'APIO ESTHER': [
    ['Primary One', 'Mathematics'],
    ['Primary Two', 'Mathematics'],
    ['Primary Two', 'Literacy II'],
  ],
  'ASEKENYE GRACE': [
    ['Primary One', 'Literacy II'],
    ['Primary One', 'English'],
    ['Primary Three', 'English'],
  ],
  'Awor Topista': [
    ['Primary Five', 'English'],
    ['Primary Two', 'English'],
    ['Primary Three', 'Literacy II'],
    ['Primary One', 'R.E'],
  ],
  'EGAU GERALD': [
    ['Primary Four', 'Mathematics'],
    ['Primary Six', 'Mathematics'],
    ['Primary Seven', 'Mathematics'],
  ],
  'EMERU JOEL': [
    ['Primary Four', 'English'],
    ['Primary Six', 'English'],
    ['Primary Seven', 'English'],
  ],
};

// These staff don't exist in the database yet (can be created later)
const missingStaff = [
  'Ikomera Christine',
  'Bakyaire Charles',
  'Wafula John Jackson',
  'Epenyu Abraham',
  'Ekaru Emmanuel',
];

const conn = await mysql.createConnection(config);

try {
  console.log('\n========== UPDATING NORTHGATE SUBJECT ALLOCATIONS ==========\n');
  
  // Get school info
  const [schoolRows] = await conn.execute(
    'SELECT id, name FROM schools WHERE id = ?',
    [NORTHGATE_SCHOOL_ID]
  );
  
  if (!schoolRows.length) {
    console.error('❌ Northgate school not found!');
    process.exit(1);
  }
  
  console.log(`School: ${schoolRows[0].name}\n`);
  
  let totalAllocations = 0;
  let successCount = 0;
  let errorCount = 0;
  
  for (const [staffName, assignments] of Object.entries(allocations)) {
    // Find staff by name
    const [staffRows] = await conn.execute(`
      SELECT s.id, s.person_id, p.first_name, p.last_name
      FROM staff s
      JOIN people p ON s.person_id = p.id
      WHERE s.school_id = ? AND s.deleted_at IS NULL
        AND CONCAT_WS(' ', p.first_name, p.last_name) = ?
    `, [NORTHGATE_SCHOOL_ID, staffName]);
    
    if (!staffRows.length) {
      console.log(`⚠️  Staff not found: ${staffName}`);
      errorCount++;
      continue;
    }
    
    const staffId = staffRows[0].id;
    console.log(`✅ ${staffName} (ID: ${staffId})`);
    
    // Clear existing allocations for this staff member
    const [deleteResult] = await conn.execute(`
      DELETE FROM class_subjects
      WHERE teacher_id = ?
    `, [staffId]);
    
    console.log(`   Cleared ${deleteResult.affectedRows} previous allocations`);
    
    // Add new allocations
    let allocCount = 0;
    for (const [className, subjectName] of assignments) {
      try {
        // Get class ID
        const [classRows] = await conn.execute(`
          SELECT c.id
          FROM classes c
          WHERE c.school_id = ? AND c.name = ? AND c.deleted_at IS NULL
        `, [NORTHGATE_SCHOOL_ID, className]);
        
        if (!classRows.length) {
          console.log(`   ⚠️  Class not found: ${className}`);
          continue;
        }
        
        const classId = classRows[0].id;
        
        // Get subject ID
        const [subjectRows] = await conn.execute(`
          SELECT s.id
          FROM subjects s
          WHERE s.school_id = ? AND s.name = ? AND s.deleted_at IS NULL
        `, [NORTHGATE_SCHOOL_ID, subjectName]);
        
        if (!subjectRows.length) {
          console.log(`   ⚠️  Subject not found: ${subjectName}`);
          continue;
        }
        
        const subjectId = subjectRows[0].id;
        
        // Insert allocation
        await conn.execute(`
          INSERT INTO class_subjects (class_id, subject_id, teacher_id)
          VALUES (?, ?, ?)
        `, [classId, subjectId, staffId]);
        
        allocCount++;
        totalAllocations++;
        successCount++;
      } catch (err) {
        console.log(`   ❌ Error allocating ${className} - ${subjectName}: ${err.message}`);
        errorCount++;
      }
    }
    
    console.log(`   ➕ Added ${allocCount} new allocations\n`);
  }
  
  console.log('\n========== SUMMARY ==========');
  console.log(`✅ Total allocations successfully updated: ${successCount}`);
  console.log(`❌ Total errors: ${errorCount}`);
  
  if (missingStaff.length > 0) {
    console.log(`\n⚠️  Missing staff (not yet in database):`);
    missingStaff.forEach(name => console.log(`   - ${name}`));
  }
  
  console.log(`\n📊 Updated Northgate Allocations:`);
  
  // Display final allocations
  const [finalRows] = await conn.execute(`
    SELECT 
      CONCAT_WS(' ', p.first_name, p.last_name) as staff_name,
      c.name as class_name,
      s.name as subject_name
    FROM class_subjects cs
    JOIN staff st ON cs.teacher_id = st.id
    JOIN people p ON st.person_id = p.id
    JOIN classes c ON cs.class_id = c.id
    JOIN subjects s ON cs.subject_id = s.id
    WHERE st.school_id = ? AND st.deleted_at IS NULL
    ORDER BY p.last_name, p.first_name, c.name
  `, [NORTHGATE_SCHOOL_ID]);
  
  console.table(finalRows);
  
  console.log('\n✅ NORTHGATE ALLOCATIONS UPDATED\n');
  
} catch (error) {
  console.error('❌ Error:', error.message);
  process.exit(1);
} finally {
  await conn.end();
}

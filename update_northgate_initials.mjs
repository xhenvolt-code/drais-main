#!/usr/bin/env node
/**
 * Update Northgate staff initials and subject allocations on TiDB
 * Allocations provided by user - April 28, 2026
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

// Complete staff allocations with custom initials
const staffAllocations = {
  'APIO ESTHER': {
    initials: 'AE',
    subjects: [
      ['Primary One', 'Mathematics'],
      ['Primary Two', 'Mathematics'],
      ['Primary Two', 'Literacy II'],
    ],
  },
  'ASEKENYE GRACE': {
    initials: 'AG',
    subjects: [
      ['Primary One', 'Literacy II'],
      ['Primary One', 'English'],
      ['Primary Three', 'English'],
    ],
  },
  'IKOMERA CHRISTINE': {
    initials: 'IC',
    subjects: [
      ['Primary One', 'Literacy I'],
      ['Primary Two', 'Literacy I'],
      ['Primary Two', 'R.E'],
    ],
  },
  'AWOR TOPISTA': {
    initials: 'AT',
    subjects: [
      ['Primary Five', 'English'],
      ['Primary Two', 'English'],
      ['Primary Three', 'Literacy II'],
      ['Primary One', 'R.E'],
    ],
  },
  'BAKYAIRE CHARLES': {
    initials: 'BC',
    subjects: [
      ['Primary Three', 'Literacy I'],
      ['Primary Four', 'Social Studies'],
      ['Primary Six', 'Social Studies'],
    ],
  },
  'WAFULA JOHN JACKSON': {
    initials: 'WJ',
    subjects: [
      ['Primary Four', 'Science'],
      ['Primary Five', 'Science'],
      ['Primary Seven', 'Science'],
    ],
  },
  'EPENYU ABRAHAM': {
    initials: 'EA',
    subjects: [
      ['Primary Five', 'Social Studies'],
      ['Primary Seven', 'Social Studies'],
      ['Primary Six', 'Science'],
    ],
  },
  'EKARU EMMANUEL': {
    initials: 'EE',
    subjects: [
      ['Primary Three', 'R.E'],
      ['Primary Five', 'Mathematics'],
      ['Primary Three', 'Mathematics'],
    ],
  },
  'EGAU GERALD': {
    initials: 'EG',
    subjects: [
      ['Primary Four', 'Mathematics'],
      ['Primary Six', 'Mathematics'],
      ['Primary Seven', 'Mathematics'],
    ],
  },
  'EMERU JOEL': {
    initials: 'EJ',
    subjects: [
      ['Primary Four', 'English'],
      ['Primary Six', 'English'],
      ['Primary Seven', 'English'],
    ],
  },
};

const conn = await mysql.createConnection(config);

try {
  console.log('\n🔄 UPDATING NORTHGATE TEACHER INITIALS AND ALLOCATIONS ON TiDB\n');
  
  // Verify school exists
  const [schoolRows] = await conn.execute(
    'SELECT id, name FROM schools WHERE id = ?',
    [NORTHGATE_SCHOOL_ID]
  );
  
  if (!schoolRows.length) {
    console.error('❌ Northgate school (ID: 6) not found!');
    process.exit(1);
  }
  
  console.log(`✅ School Found: ${schoolRows[0].name}\n`);
  console.log('=' .repeat(70));
  
  let totalAllocations = 0;
  let successCount = 0;
  let errorCount = 0;
  const updatesSummary = [];
  
  for (const [staffName, { initials, subjects }] of Object.entries(staffAllocations)) {
    console.log(`\n👤 ${staffName} (Initials: ${initials})`);
    
    // Try multiple name formats for matching
    const nameVariations = [
      staffName,
      staffName.toUpperCase(),
      staffName.toLowerCase(),
      staffName.split(' ').map(n => n.charAt(0).toUpperCase() + n.slice(1).toLowerCase()).join(' '),
    ];
    
    let staffId = null;
    let foundStaffRow = null;

    // Try each name variation
    for (const nameVariation of nameVariations) {
      const [staffRows] = await conn.execute(`
        SELECT s.id, s.person_id, p.first_name, p.last_name
        FROM staff s
        JOIN people p ON s.person_id = p.id
        WHERE s.school_id = ? AND s.deleted_at IS NULL
          AND LOWER(CONCAT_WS(' ', p.first_name, p.last_name)) = LOWER(?)
      `, [NORTHGATE_SCHOOL_ID, nameVariation]);
      
      if (staffRows.length > 0) {
        staffId = staffRows[0].id;
        foundStaffRow = staffRows[0];
        break;
      }
    }
    
    if (!staffId) {
      console.log(`   ⚠️  NOT FOUND in database - will need to be added separately`);
      errorCount++;
      continue;
    }
    console.log(`   📌 Staff ID: ${staffId}`);
    
    // Clear existing allocations for this staff member
    const [deleteResult] = await conn.execute(`
      DELETE FROM class_subjects
      WHERE teacher_id = ?
    `, [staffId]);
    
    if (deleteResult.affectedRows > 0) {
      console.log(`   🗑️  Cleared ${deleteResult.affectedRows} previous allocations`);
    }
    
    // Add new allocations with custom initials
    let allocCount = 0;
    for (const [className, subjectName] of subjects) {
      try {
        // Get class ID (case-insensitive)
        const [classRows] = await conn.execute(`
          SELECT c.id
          FROM classes c
          WHERE c.school_id = ? AND LOWER(c.name) = LOWER(?) AND c.deleted_at IS NULL
        `, [NORTHGATE_SCHOOL_ID, className]);
        
        if (!classRows.length) {
          console.log(`   ⚠️  Class "${className}" not found`);
          continue;
        }
        
        const classId = classRows[0].id;
        
        // Get subject ID (case-insensitive)
        const [subjectRows] = await conn.execute(`
          SELECT s.id
          FROM subjects s
          WHERE s.school_id = ? AND LOWER(s.name) = LOWER(?) AND s.deleted_at IS NULL
        `, [NORTHGATE_SCHOOL_ID, subjectName]);
        
        if (!subjectRows.length) {
          console.log(`   ⚠️  Subject "${subjectName}" not found`);
          continue;
        }
        
        const subjectId = subjectRows[0].id;
        
        // Insert allocation with custom initials
        const [result] = await conn.execute(`
          INSERT INTO class_subjects (class_id, subject_id, teacher_id, custom_initials)
          VALUES (?, ?, ?, ?)
        `, [classId, subjectId, staffId, initials]);
        
        allocCount++;
        totalAllocations++;
        successCount++;
        
        console.log(`   ✅ ${className} - ${subjectName}`);
      } catch (err) {
        console.log(`   ❌ Error: ${className} - ${subjectName}: ${err.message}`);
        errorCount++;
      }
    }
    
    console.log(`   ➕ Added ${allocCount} allocations`);
    updatesSummary.push({
      staff: staffName,
      initials,
      allocations: allocCount,
    });
  }
  
  console.log('\n' + '='.repeat(70));
  console.log('\n📊 SUMMARY:\n');
  console.table(updatesSummary);
  
  console.log(`\n✅ Total allocations successfully updated: ${successCount}`);
  console.log(`❌ Total errors: ${errorCount}`);
  
  console.log('\n📋 CURRENT NORTHGATE ALLOCATIONS WITH INITIALS:\n');
  
  // Display final allocations
  const [finalRows] = await conn.execute(`
    SELECT 
      CONCAT_WS(' ', p.first_name, p.last_name) as staff_name,
      c.name as class_name,
      s.name as subject_name,
      cs.custom_initials as initials
    FROM class_subjects cs
    JOIN staff st ON cs.teacher_id = st.id
    JOIN people p ON st.person_id = p.id
    JOIN classes c ON cs.class_id = c.id
    JOIN subjects s ON cs.subject_id = s.id
    WHERE st.school_id = ? AND st.deleted_at IS NULL AND cs.custom_initials IS NOT NULL
    ORDER BY p.last_name, p.first_name, c.name
  `, [NORTHGATE_SCHOOL_ID]);
  
  console.table(finalRows);
  
  console.log('\n✅ NORTHGATE INITIALS UPDATED ON TiDB\n');
  
} catch (error) {
  console.error('❌ Error:', error.message);
  process.exit(1);
} finally {
  await conn.end();
}

#!/usr/bin/env node
/**
 * Add missing Northgate teachers to database
 * Creates people and staff records for the 6 missing teachers
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

// Teachers to add with their names parsed
const missingTeachers = [
  { firstName: 'Ikomera', lastName: 'Christine', fullName: 'Ikomera Christine' },
  { firstName: 'Awor', lastName: 'Topista', fullName: 'Awor Topista' },
  { firstName: 'Bakyaire', lastName: 'Charles', fullName: 'Bakyaire Charles' },
  { firstName: 'Wafula', lastName: 'John Jackson', fullName: 'Wafula John Jackson' },
  { firstName: 'Epenyu', lastName: 'Abraham', fullName: 'Epenyu Abraham' },
  { firstName: 'Ekaru', lastName: 'Emmanuel', fullName: 'Ekaru Emmanuel' },
];

const conn = await mysql.createConnection(config);

try {
  console.log('\n🔄 ADDING MISSING NORTHGATE TEACHERS\n');
  
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
  console.log('='.repeat(70));
  
  let createdCount = 0;
  let errorCount = 0;
  const createdStaff = [];
  
  for (const teacher of missingTeachers) {
    console.log(`\n👤 ${teacher.fullName}`);
    
    try {
      // Check if person already exists
      const [existingPerson] = await conn.execute(
        'SELECT id FROM people WHERE first_name = ? AND last_name = ?',
        [teacher.firstName, teacher.lastName]
      );
      
      let personId;
      
      if (existingPerson.length > 0) {
        personId = existingPerson[0].id;
        console.log(`   📌 Person already exists (ID: ${personId})`);
      } else {
        // Create new person
        const [personResult] = await conn.execute(
          'INSERT INTO people (first_name, last_name, email, phone) VALUES (?, ?, ?, ?)',
          [
            teacher.firstName,
            teacher.lastName,
            `${teacher.firstName.toLowerCase()}.${teacher.lastName.toLowerCase()}@northgate.sch.ke`,
            '',
          ]
        );
        personId = personResult.insertId;
        console.log(`   ✅ Created person (ID: ${personId})`);
      }
      
      // Check if staff record already exists
      const [existingStaff] = await conn.execute(
        'SELECT id FROM staff WHERE school_id = ? AND person_id = ?',
        [NORTHGATE_SCHOOL_ID, personId]
      );
      
      if (existingStaff.length > 0) {
        console.log(`   ⚠️  Staff record already exists (ID: ${existingStaff[0].id})`);
        createdStaff.push({
          name: teacher.fullName,
          personId,
          staffId: existingStaff[0].id,
          status: 'existing',
        });
      } else {
        // Create new staff record
        const [staffResult] = await conn.execute(
          `INSERT INTO staff (school_id, person_id, position, status)
           VALUES (?, ?, ?, ?)`,
          [NORTHGATE_SCHOOL_ID, personId, 'Teacher', 'active']
        );
        const staffId = staffResult.insertId;
        console.log(`   ✅ Created staff record (ID: ${staffId})`);
        
        createdStaff.push({
          name: teacher.fullName,
          personId,
          staffId,
          status: 'created',
        });
        createdCount++;
      }
    } catch (err) {
      console.log(`   ❌ Error: ${err.message}`);
      errorCount++;
    }
  }
  
  console.log('\n' + '='.repeat(70));
  console.log('\n📊 SUMMARY:\n');
  console.table(createdStaff);
  
  console.log(`\n✅ Teachers added: ${createdCount}`);
  console.log(`⚠️  Teachers already existed: ${createdStaff.length - createdCount}`);
  console.log(`❌ Errors: ${errorCount}`);
  
  console.log('\n📋 NEW NORTHGATE STAFF:\n');
  
  // Display all staff
  const [allStaff] = await conn.execute(`
    SELECT 
      s.id as staff_id,
      CONCAT_WS(' ', p.first_name, p.last_name) as staff_name,
      s.position,
      s.status,
      p.email
    FROM staff s
    JOIN people p ON s.person_id = p.id
    WHERE s.school_id = ? AND s.deleted_at IS NULL
    ORDER BY p.last_name, p.first_name
  `, [NORTHGATE_SCHOOL_ID]);
  
  console.table(allStaff);
  
  console.log('\n✅ MISSING TEACHERS ADDED TO TiDB\n');
  console.log('ℹ️  Next step: Run update_northgate_initials.mjs again to add their subject allocations\n');
  
} catch (error) {
  console.error('❌ Error:', error.message);
  process.exit(1);
} finally {
  await conn.end();
}

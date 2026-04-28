#!/usr/bin/env node

/**
 * Insert Albayan Quran Memorization Center Teacher Initials
 * Maps teacher initials to class-subject combinations
 */

import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

// Define Albayan teacher initials mapping
// Structure: [className, subjectName, initials]
const ALBAYAN_INITIALS = [
  // Baby Class
  ['BABY CLASS', 'Numbers', 'I.R'],
  ['BABY CLASS', 'Language', 'I.R'],
  ['BABY CLASS', 'Writing', 'I.R'],
  ['BABY CLASS', 'Reading', 'I.R'],
  ['BABY CLASS', 'SOCIAL DEVELOPMENT', 'K.L'],
  ['BABY CLASS', 'HEALTH HABITS', 'N.M'],
  
  // Top Class
  ['TOP CLASS', 'Numbers', 'K.B'],
  ['TOP CLASS', 'Language', 'K.B'],
  ['TOP CLASS', 'Writing', 'K.B'],
  ['TOP CLASS', 'SOCIAL DEVELOPMENT', 'K.L'],
  ['TOP CLASS', 'HEALTH HABITS', 'N.M'],
  
  // Middle Class
  ['MIDDLE CLASS', 'Numbers', 'K.L'],
  ['MIDDLE CLASS', 'Language', 'K.L'],
  ['MIDDLE CLASS', 'Writing', 'K.L'],
  ['MIDDLE CLASS', 'Reading', 'I.R'],
  ['MIDDLE CLASS', 'SOCIAL DEVELOPMENT', 'K.L'],
  ['MIDDLE CLASS', 'HEALTH HABITS', 'N.M'],
  
  // Primary One, Two, Three (shared)
  ['PRIMARY ONE', 'MATHEMATICS', 'M.S'],
  ['PRIMARY ONE', 'English', 'N.Z'],
  ['PRIMARY ONE', 'LITERACY I', 'K.Z'],
  ['PRIMARY ONE', 'LITERACY II', 'N.V'],
  
  ['PRIMARY TWO', 'MATHEMATICS', 'M.S'],
  ['PRIMARY TWO', 'English', 'N.Z'],
  ['PRIMARY TWO', 'LITERACY I', 'K.Z'],
  ['PRIMARY TWO', 'LITERACY II', 'N.V'],
  
  ['PRIMARY THREE', 'MATHEMATICS', 'M.S'],
  ['PRIMARY THREE', 'English', 'N.Z'],
  ['PRIMARY THREE', 'ICT', 'N.M'],
  ['PRIMARY THREE', 'LITERACY I', 'K.Z'],
  ['PRIMARY THREE', 'LITERACY II', 'N.V'],
  
  // Primary Four, Five (shared)
  ['PRIMARY FOUR', 'MATHEMATICS', 'M.H'],
  ['PRIMARY FOUR', 'English', 'S.A'],
  ['PRIMARY FOUR', 'Science', 'N.P'],
  ['PRIMARY FOUR', 'Social studies', 'K.M'],
  ['PRIMARY FOUR', 'ICT', 'N.M'],
  
  ['PRIMARY FIVE', 'MATHEMATICS', 'M.H'],
  ['PRIMARY FIVE', 'English', 'S.A'],
  ['PRIMARY FIVE', 'Science', 'N.P'],
  ['PRIMARY FIVE', 'Social studies', 'K.M'],
  ['PRIMARY FIVE', 'ICT', 'N.M'],
  
  // Primary Six
  ['PRIMARY SIX', 'MATHEMATICS', 'O.H'],
  ['PRIMARY SIX', 'English', 'W.A'],
  ['PRIMARY SIX', 'Science', 'F.S'],
  ['PRIMARY SIX', 'Social studies', 'O.S'],
  ['PRIMARY SIX', 'ICT', 'N.M'],
];

const ALBAYAN_SCHOOL_ID = 1;

async function main() {
  let conn;
  
  try {
    // Determine which database to use (TiDB or local MySQL)
    const useLocalDb = process.argv.includes('--local');
    
    const dbConfig = useLocalDb ? {
      host: process.env.DB_HOST || 'localhost',
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASS || '',
      database: process.env.DB_NAME || 'drais_school_test',
      port: parseInt(process.env.DB_PORT) || 3306,
    } : {
      host: process.env.TIDB_HOST,
      user: process.env.TIDB_USER,
      password: process.env.TIDB_PASSWORD,
      database: process.env.TIDB_DB,
      port: parseInt(process.env.TIDB_PORT) || 4000,
    };

    conn = await mysql.createConnection(dbConfig);

    const dbType = useLocalDb ? 'local MySQL' : 'TiDB';
    console.log(`✅ Connected to ${dbType}`);

    let updatedCount = 0;
    let skippedCount = 0;
    let errorCount = 0;

    for (const [className, subjectName, initials] of ALBAYAN_INITIALS) {
      try {
        // First, find the class_id for the given class name
        const [classRows] = await conn.execute(
          `SELECT id FROM classes WHERE school_id = ? AND UPPER(TRIM(name)) = UPPER(TRIM(?))`,
          [ALBAYAN_SCHOOL_ID, className]
        );

        if (!classRows || classRows.length === 0) {
          console.warn(`⚠️  Class not found: "${className}"`);
          skippedCount++;
          continue;
        }

        const classId = classRows[0].id;

        // Find the subject_id for the given subject name
        const [subjectRows] = await conn.execute(
          `SELECT id FROM subjects WHERE school_id = ? AND UPPER(TRIM(name)) = UPPER(TRIM(?))`,
          [ALBAYAN_SCHOOL_ID, subjectName]
        );

        if (!subjectRows || subjectRows.length === 0) {
          console.warn(`⚠️  Subject not found: "${subjectName}" for class "${className}"`);
          skippedCount++;
          continue;
        }

        const subjectId = subjectRows[0].id;

        // Check if class_subject assignment exists
        const [existingRows] = await conn.execute(
          `SELECT id FROM class_subjects WHERE school_id = ? AND class_id = ? AND subject_id = ? AND deleted_at IS NULL`,
          [ALBAYAN_SCHOOL_ID, classId, subjectId]
        );

        if (!existingRows || existingRows.length === 0) {
          console.warn(`⚠️  Class-Subject assignment not found: "${className}" → "${subjectName}"`);
          skippedCount++;
          continue;
        }

        const classSubjectId = existingRows[0].id;

        // Update custom_initials
        await conn.execute(
          `UPDATE class_subjects SET custom_initials = ?, updated_at = NOW() WHERE id = ?`,
          [initials, classSubjectId]
        );

        console.log(`✅ Updated: ${className} → ${subjectName} = ${initials}`);
        updatedCount++;
      } catch (error) {
        console.error(`❌ Error processing ${className} → ${subjectName}:`, error.message);
        errorCount++;
      }
    }

    console.log('\n📊 Summary:');
    console.log(`   ✅ Successfully updated: ${updatedCount}`);
    console.log(`   ⚠️  Skipped (not found): ${skippedCount}`);
    console.log(`   ❌ Errors: ${errorCount}`);
    console.log(`   📋 Total: ${ALBAYAN_INITIALS.length}`);

    // Show verification
    console.log('\n🔍 Verification - Current Albayan Initials:');
    const [results] = await conn.execute(`
      SELECT 
        c.name AS class_name,
        s.name AS subject_name,
        cs.custom_initials,
        COALESCE(cs.custom_initials, CONCAT(UPPER(LEFT(p.first_name, 1)), UPPER(LEFT(p.last_name, 1)))) AS display_initials
      FROM class_subjects cs
      JOIN classes c ON cs.class_id = c.id
      JOIN subjects s ON cs.subject_id = s.id
      LEFT JOIN staff st ON cs.teacher_id = st.id
      LEFT JOIN people p ON st.person_id = p.id
      WHERE c.school_id = ?
      ORDER BY c.name, s.name
    `, [ALBAYAN_SCHOOL_ID]);

    console.table(results.map(row => ({
      class: row.class_name,
      subject: row.subject_name,
      custom: row.custom_initials,
      display: row.display_initials,
    })));

  } catch (error) {
    console.error('❌ Database connection error:', error.message);
    process.exit(1);
  } finally {
    if (conn) {
      await conn.end();
      console.log('\n✅ Database connection closed');
    }
  }
}

main().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});

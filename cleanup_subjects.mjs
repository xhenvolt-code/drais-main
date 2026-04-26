import mysql from 'mysql2/promise.js';

const config = {
  host: 'gateway01.eu-central-1.prod.aws.tidbcloud.com',
  port: 4000,
  user: '2Trc8kJebpKLb1Z.root',
  password: 'QMNAOiP9J1rANv4Z',
  database: 'drais',
  ssl: { rejectUnauthorized: false }  // TiDB Cloud requires SSL
};

async function cleanupSubjects() {
  const connection = await mysql.createConnection(config);
  
  try {
    console.log('\n=== CLEANUP: Removing Soft-Deleted Subject Records ===\n');
    
    // Step 1: Find all soft-deleted subjects that have an active equivalent
    const [softDeletedDups] = await connection.execute(`
      SELECT 
        sd.id as soft_deleted_id,
        sd.school_id,
        sd.name as soft_deleted_name,
        s.id as active_id,
        s.name as active_name,
        sch.name as school_name
      FROM subjects sd
      LEFT JOIN subjects s ON 
        sd.school_id = s.school_id 
        AND LOWER(sd.name) = LOWER(s.name)
        AND sd.id != s.id
        AND s.deleted_at IS NULL
      LEFT JOIN schools sch ON sd.school_id = sch.id
      WHERE sd.deleted_at IS NOT NULL
      AND s.id IS NOT NULL
      ORDER BY sch.name, sd.name
    `);
    
    console.log(`Found ${softDeletedDups.length} soft-deleted subjects with active equivalents:\n`);
    if (softDeletedDups.length > 0) {
      console.table(softDeletedDups);
      
      // Hard delete these records
      console.log('\nHard-deleting soft-deleted duplicates...');
      for (const record of softDeletedDups) {
        await connection.execute('DELETE FROM subjects WHERE id = ?', [record.soft_deleted_id]);
        console.log(`✓ Deleted ID ${record.soft_deleted_id} (${record.soft_deleted_name}) - kept active ID ${record.active_id} (${record.active_name})`);
      }
      console.log('\n✓ Cleanup complete!');
    } else {
      console.log('✓ No soft-deleted duplicates found.');
    }
    
    // Step 2: Verify results
    console.log('\n=== VERIFICATION: Active Subjects by School ===\n');
    const [activeSubjects] = await connection.execute(`
      SELECT 
        sch.name as school_name,
        s.name,
        COUNT(*) as count
      FROM subjects s
      LEFT JOIN schools sch ON s.school_id = sch.id
      WHERE s.deleted_at IS NULL
      GROUP BY s.school_id, s.name
      ORDER BY sch.name, s.name
    `);
    if (activeSubjects.length > 0) {
      console.table(activeSubjects);
    }
    
    // Step 3: Check for case-insensitive duplicates within active subjects
    console.log('\n=== DUPLICATE CHECK: Case-Insensitive Duplicates (Active) ===\n');
    const [caseInsensitiveDups] = await connection.execute(`
      SELECT 
        sch.name as school_name,
        LOWER(s.name) as lowercase_name,
        COUNT(*) as count,
        GROUP_CONCAT(CONCAT(s.id, ' (', s.name, ')')) as records
      FROM subjects s
      LEFT JOIN schools sch ON s.school_id = sch.id
      WHERE s.deleted_at IS NULL
      GROUP BY s.school_id, LOWER(s.name)
      HAVING count > 1
      ORDER BY sch.name, lowercase_name
    `);
    
    if (caseInsensitiveDups.length > 0) {
      console.log('⚠️  Found case-insensitive duplicates:\n');
      console.table(caseInsensitiveDups);
    } else {
      console.log('✓ No case-insensitive duplicates found in active subjects.');
    }
    
  } finally {
    await connection.end();
  }
}

cleanupSubjects().catch(console.error);

import mysql from 'mysql2/promise.js';

const config = {
  host: 'gateway01.eu-central-1.prod.aws.tidbcloud.com',
  port: 4000,
  user: '2Trc8kJebpKLb1Z.root',
  password: 'QMNAOiP9J1rANv4Z',
  database: 'drais'
};

async function analyzeSubjects() {
  const connection = await mysql.createConnection(config);
  
  try {
    console.log('\n=== SUBJECTS TABLE SCHEMA ===');
    const [schema] = await connection.execute(`DESCRIBE subjects`);
    console.table(schema);
    
    console.log('\n=== ALL SUBJECTS IN DATABASE ===');
    const [subjects] = await connection.execute(`SELECT * FROM subjects LIMIT 50`);
    console.log(`Total subjects query returned: ${subjects.length} rows`);
    console.table(subjects);
    
    console.log('\n=== CHECK FOR SCHOOL-SCOPED COLUMNS ===');
    const columns = schema.map(c => c.Field);
    console.log('Columns:', columns);
    
    if (columns.includes('school_id')) {
      console.log('\n=== SUBJECTS BY SCHOOL ===');
      const [bySchool] = await connection.execute(`
        SELECT school_id, COUNT(*) as count, GROUP_CONCAT(DISTINCT name) as subjects
        FROM subjects
        GROUP BY school_id
      `);
      console.table(bySchool);
    }
    
    if (columns.includes('school_name')) {
      console.log('\n=== SUBJECTS BY SCHOOL NAME ===');
      const [bySchoolName] = await connection.execute(`
        SELECT school_name, COUNT(*) as count, GROUP_CONCAT(DISTINCT name) as subjects
        FROM subjects
        GROUP BY school_name
      `);
      console.table(bySchoolName);
    }
    
    console.log('\n=== ENGLISH SUBJECT DETAILS ===');
    const [english] = await connection.execute(`
      SELECT * FROM subjects WHERE name LIKE '%English%' OR name LIKE '%english%'
    `);
    console.table(english);
    
    console.log('\n=== NORTHGATE SCHOOL CHECK ===');
    const [northgate] = await connection.execute(`
      SELECT * FROM schools WHERE name LIKE '%northgate%' OR name LIKE '%Northgate%'
    `);
    console.table(northgate);
    
    console.log('\n=== AL BAYAN SCHOOL CHECK ===');
    const [albayan] = await connection.execute(`
      SELECT * FROM schools WHERE name LIKE '%albayan%' OR name LIKE '%Al Bayan%'
    `);
    console.table(albayan);
    
  } finally {
    await connection.end();
  }
}

analyzeSubjects().catch(console.error);

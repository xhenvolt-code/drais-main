import mysql from 'mysql2/promise';

const config = {
  host: 'gateway01.eu-central-1.prod.aws.tidbcloud.com',
  port: 4000,
  user: '2Trc8kJebpKLb1Z.root',
  password: 'QMNAOiP9J1rANv4Z',
  database: 'drais',
  ssl: { rejectUnauthorized: false }
};

const THEOLOGY_CLASS_NAMES = [
  'الروضة (BABY)',
  'الروضة (MIDDLE)',
  'الروضة (TOP)',
  'صف الأول',
  'صف الثاني',
  'صف الثالث',
  'صف الرابع',
  'صف الخامس',
  'صف السادس'
];

const THEOLOGY_SUBJECTS = ['التربية', 'الفقه', 'القرآن', 'اللغة'];

async function runExtraction() {
  let connection;
  try {
    connection = await mysql.createConnection(config);
    console.log('✅ Connected to TiDB Cloud database: drais');

    // Step 1: Find theology classes that match our names
    console.log('\n📖 Step 1: Finding theology classes...');
    const [classesResult] = await connection.query(
      `SELECT id, name FROM classes WHERE name IN (${THEOLOGY_CLASS_NAMES.map(() => '?').join(',')})`,
      THEOLOGY_CLASS_NAMES
    );
    
    console.log(`Found ${classesResult.length} theology classes:`, classesResult.map(c => ({ id: c.id, name: c.name })));

    if (classesResult.length === 0) {
      console.error('❌ NO theology classes found in database. Classes available:');
      const [allClasses] = await connection.query('SELECT id, name FROM classes LIMIT 20');
      console.table(allClasses);
      await connection.end();
      return;
    }

    // Step 2: Find theology subjects
    console.log('\n📚 Step 2: Finding theology subjects...');
    const [subjectsResult] = await connection.query(
      `SELECT id, name FROM subjects WHERE name IN (${THEOLOGY_SUBJECTS.map(() => '?').join(',')})`,
      THEOLOGY_SUBJECTS
    );
    
    console.log(`Found ${subjectsResult.length} theology subjects:`, subjectsResult.map(s => ({ id: s.id, name: s.name })));

    if (subjectsResult.length === 0) {
      console.error('❌ NO theology subjects found in database. Subjects available:');
      const [allSubjects] = await connection.query('SELECT id, name, subject_type FROM subjects LIMIT 30');
      console.table(allSubjects);
      await connection.end();
      return;
    }

    const classIds = classesResult.map(c => c.id);
    const subjectIds = subjectsResult.map(s => s.id);

    // Step 3: Get students in theology classes
    console.log('\n👥 Step 3: Finding students in theology classes...');
    const [studentsResult] = await connection.query(
      `SELECT DISTINCT s.id, s.person_id, s.theology_class_id, p.first_name, p.last_name, 
              c.name as class_name
       FROM students s
       LEFT JOIN people p ON s.person_id = p.id
       LEFT JOIN classes c ON s.theology_class_id = c.id
       WHERE s.theology_class_id IN (${classIds.map(() => '?').join(',')})
       ORDER BY c.name, p.first_name, p.last_name`,
      classIds
    );

    console.log(`Found ${studentsResult.length} students in theology classes`);
    if (studentsResult.length > 0) {
      console.log('Sample students:', studentsResult.slice(0, 5).map(s => ({
        id: s.id, 
        name: `${s.first_name} ${s.last_name}`,
        theology_class_id: s.theology_class_id,
        class_name: s.class_name
      })));
    }

    // Step 4: Get theology results
    console.log('\n📊 Step 4: Fetching theology results...');
    const [resultsResult] = await connection.query(
      `SELECT cr.id, cr.student_id, cr.class_id, cr.subject_id, 
              cr.score, cr.grade, cr.remarks, cr.term_id,
              s.name as subject_name, c.name as class_name
       FROM class_results cr
       LEFT JOIN subjects s ON cr.subject_id = s.id
       LEFT JOIN classes c ON cr.class_id = c.id
       WHERE cr.class_id IN (${classIds.map(() => '?').join(',')})
       AND cr.subject_id IN (${subjectIds.map(() => '?').join(',')})
       ORDER BY cr.class_id, cr.student_id, cr.subject_id`,
      [...classIds, ...subjectIds]
    );

    console.log(`Found ${resultsResult.length} theology result records`);
    if (resultsResult.length > 0) {
      console.log('Sample results:', resultsResult.slice(0, 5).map(r => ({
        student_id: r.student_id,
        subject: r.subject_name,
        score: r.score,
        grade: r.grade
      })));
    }

    // Step 5: Check class_subjects mapping
    console.log('\n🔗 Step 5: Checking class-subject mappings...');
    const [classSub] = await connection.query(
      `SELECT cs.id, cs.class_id, cs.subject_id, c.name as class_name, s.name as subject_name
       FROM class_subjects cs
       LEFT JOIN classes c ON cs.class_id = c.id
       LEFT JOIN subjects s ON cs.subject_id = s.id
       WHERE cs.class_id IN (${classIds.map(() => '?').join(',')})
       LIMIT 10`,
      classIds
    );

    console.log(`Found ${classSub.length} class-subject mappings (showing first 10):`);
    console.table(classSub);

    // Step 6: Check enrollments with theology_class_id
    console.log('\n📝 Step 6: Checking enrollments with theology_class_id...');
    const [enrollmentsCheck] = await connection.query(
      `SELECT COUNT(*) as count FROM enrollments WHERE theology_class_id IS NOT NULL AND theology_class_id > 0`
    );

    console.log(`Enrollments with theology_class_id: ${enrollmentsCheck[0].count}`);

    // Step 7: List all classes to see structure
    console.log('\n🏛️  Step 7: All available classes:');
    const [allClasses] = await connection.query('SELECT id, name FROM classes ORDER BY id');
    console.table(allClasses);

    // Step 8: List all subjects to see structure
    console.log('\n📕 Step 8: All subjects (first 50):');
    const [allSubjects] = await connection.query(
      'SELECT id, name, subject_type FROM subjects ORDER BY id LIMIT 50'
    );
    console.table(allSubjects);

    await connection.end();
    console.log('\n✅ Analysis complete');
  } catch (error) {
    console.error('❌ Database error:', error.message);
    if (connection) await connection.end();
    process.exit(1);
  }
}

runExtraction();

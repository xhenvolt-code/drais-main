import { query, getConnection } from './src/lib/db.js';
import mysql from 'mysql2/promise';

console.log('🎓 Northgate School Teacher Subject Allocation Update');
console.log('=====================================================');

// Teacher subject allocations provided by user
const teacherAllocations = [
  {
    name: 'Apio Esther',
    subjects: [
      { name: 'Mathematics', classes: ['Primary One', 'Primary Two'] }
    ]
  },
  {
    name: 'Asekenye Grace',
    subjects: [
      { name: 'Literacy II', classes: ['Primary One'] },
      { name: 'English', classes: ['Primary One', 'Primary Three'] }
    ]
  },
  {
    name: 'Ikomera Christine',
    subjects: [
      { name: 'Literacy I', classes: ['Primary One', 'Primary Two'] },
      { name: 'Religious Education', classes: ['Primary Two'] }
    ]
  },
  {
    name: 'Awor Topista',
    subjects: [
      { name: 'English', classes: ['Primary Five', 'Primary Two'] },
      { name: 'Literacy II', classes: ['Primary Three'] },
      { name: 'Religious Education', classes: ['Primary One'] }
    ]
  },
  {
    name: 'Bakyaire Charles',
    subjects: [
      { name: 'Literacy I', classes: ['Primary Three'] },
      { name: 'Social Studies', classes: ['Primary Four', 'Primary Six'] }
    ]
  },
  {
    name: 'Wafula John Jackson',
    subjects: [
      { name: 'Science', classes: ['Primary Four', 'Primary Five', 'Primary Seven'] }
    ]
  },
  {
    name: 'Epenyu Abraham',
    subjects: [
      { name: 'Social Studies', classes: ['Primary Five', 'Primary Seven'] },
      { name: 'Science', classes: ['Primary Six'] }
    ]
  },
  {
    name: 'Ekaru Emmanuel',
    subjects: [
      { name: 'Religious Education', classes: ['Primary Three'] },
      { name: 'Mathematics', classes: ['Primary Five', 'Primary Three'] }
    ]
  },
  {
    name: 'Egau Gerald',
    subjects: [
      { name: 'Mathematics', classes: ['Primary Four', 'Primary Six', 'Primary Seven'] }
    ]
  },
  {
    name: 'Emeru Joel',
    subjects: [
      { name: 'English', classes: ['Primary Four', 'Primary Six', 'Primary Seven'] }
    ]
  }
];

async function updateTeacherAllocations() {
  const conn = await getConnection();
  
  try {
    // Get Northgate school ID
    const [northgateSchool] = await query(
      'SELECT id FROM schools WHERE name LIKE ? OR short_code LIKE ?',
      ['%Northgate%', '%northgate%']
    );
    
    if (northgateSchool.length === 0) {
      throw new Error('Northgate school not found in database');
    }
    
    const schoolId = northgateSchool[0].id;
    console.log(`✅ Found Northgate school with ID: ${schoolId}`);
    
    // Get all classes for Northgate
    const [classes] = await query(
      'SELECT id, name FROM classes WHERE school_id = ? ORDER BY name',
      [schoolId]
    );
    
    console.log(`✅ Found ${classes.length} classes for Northgate`);
    const classMap = new Map();
    classes.forEach((cls: any) => {
      classMap.set(cls.name.toLowerCase(), cls.id);
    });
    
    // Get all subjects
    const [subjects] = await query(
      'SELECT id, name FROM subjects WHERE school_id = ? OR school_id IS NULL ORDER BY name',
      [schoolId]
    );
    
    console.log(`✅ Found ${subjects.length} subjects`);
    const subjectMap = new Map();
    subjects.forEach((subject: any) => {
      subjectMap.set(subject.name.toLowerCase(), subject.id);
    });
    
    // Get or create teachers
    console.log('\n👥 Processing teachers...');
    
    for (const teacherAllocation of teacherAllocations) {
      console.log(`\n📝 Processing: ${teacherAllocation.name}`);
      
      // Try to find existing teacher
      const nameParts = teacherAllocation.name.split(' ');
      const [existingTeachers] = await query(`
        SELECT s.id, p.first_name, p.last_name, p.email 
        FROM staff s
        JOIN people p ON s.person_id = p.id
        WHERE s.school_id = ? 
        AND (CONCAT(p.first_name, ' ', p.last_name) LIKE ? OR p.first_name LIKE ? OR p.last_name LIKE ?)
      `, [schoolId, `%${teacherAllocation.name}%`, `%${nameParts[0]}%`, `%${nameParts[1]}%`]);
      
      let teacherId: number;
      
      if (existingTeachers.length > 0) {
        teacherId = existingTeachers[0].id;
        console.log(`  ✅ Found existing teacher: ${existingTeachers[0].first_name} ${existingTeachers[0].last_name} (ID: ${teacherId})`);
      } else {
        // Create new teacher
        console.log(`  ⚠️  Teacher not found, creating new record for: ${teacherAllocation.name}`);
        
        // Split name into first and last name
        const nameParts = teacherAllocation.name.split(' ');
        const firstName = nameParts[0];
        const lastName = nameParts.slice(1).join(' ') || 'Unknown';
        
        // Create person record first
        const [personResult] = await query(
          'INSERT INTO people (first_name, last_name, created_at) VALUES (?, ?, NOW())',
          [firstName, lastName]
        );
        
        const personId = personResult.insertId;
        
        // Create staff record
        const [staffResult] = await query(
          'INSERT INTO staff (school_id, person_id, position, status, created_at) VALUES (?, ?, ?, ?, NOW())',
          [schoolId, personId, 'Teacher', 'active']
        );
        
        teacherId = staffResult.insertId;
        console.log(`  ✅ Created new teacher: ${firstName} ${lastName} (ID: ${teacherId})`);
      }
      
      // Process subject assignments
      for (const subjectAssignment of teacherAllocation.subjects) {
        console.log(`    📚 Subject: ${subjectAssignment.name}`);
        
        // Find subject ID
        const subjectId = subjectMap.get(subjectAssignment.name.toLowerCase());
        if (!subjectId) {
          console.log(`    ❌ Subject '${subjectAssignment.name}' not found in database`);
          continue;
        }
        
        // Process each class
        for (const className of subjectAssignment.classes) {
          const classId = classMap.get(className.toLowerCase());
          if (!classId) {
            console.log(`    ❌ Class '${className}' not found in database`);
            continue;
          }
          
          // Check if assignment already exists
          const [existingAssignment] = await query(
            'SELECT id FROM class_subjects WHERE school_id = ? AND class_id = ? AND subject_id = ?',
            [schoolId, classId, subjectId]
          );
          
          if (existingAssignment.length > 0) {
            // Update existing assignment
            await query(
              'UPDATE class_subjects SET teacher_id = ?, updated_at = NOW() WHERE id = ?',
              [teacherId, existingAssignment[0].id]
            );
            console.log(`      ✅ Updated assignment: ${className} - ${subjectAssignment.name} -> Teacher ID: ${teacherId}`);
          } else {
            // Create new assignment
            await query(
              'INSERT INTO class_subjects (school_id, class_id, subject_id, teacher_id, created_at) VALUES (?, ?, ?, ?, NOW())',
              [schoolId, classId, subjectId, teacherId]
            );
            console.log(`      ✅ Created assignment: ${className} - ${subjectAssignment.name} -> Teacher ID: ${teacherId}`);
          }
        }
      }
    }
    
    // Generate teacher initials for reports
    console.log('\n🔤 Generating teacher initials for reports...');
    
    const [allTeachers] = await query(`
      SELECT s.id, p.first_name, p.last_name
      FROM staff s
      JOIN people p ON s.person_id = p.id
      WHERE s.school_id = ? AND s.deleted_at IS NULL
    `, [schoolId]);
    
    for (const teacher of allTeachers) {
      const firstName = teacher.first_name || '';
      const lastName = teacher.last_name || '';
      const initials = (firstName.charAt(0) + lastName.charAt(0)).toUpperCase();
      
      // Update teacher record with initials (assuming there's a field for this)
      // If there's no initials field, we'll handle this in the report generation logic
      console.log(`  ${teacher.first_name} ${teacher.last_name} -> ${initials}`);
    }
    
    console.log('\n📊 Summary of updated assignments:');
    
    const [summary] = await query(`
      SELECT 
        p.first_name,
        p.last_name,
        c.name as class_name,
        sub.name as subject_name
      FROM class_subjects cs
      JOIN staff s ON cs.teacher_id = s.id
      JOIN people p ON s.person_id = p.id
      JOIN classes c ON cs.class_id = c.id
      JOIN subjects sub ON cs.subject_id = sub.id
      WHERE cs.school_id = ? AND cs.teacher_id IS NOT NULL
      ORDER BY p.last_name, p.first_name, c.name, sub.name
    `, [schoolId]);
    
    summary.forEach((row: any) => {
      console.log(`  • ${row.first_name} ${row.last_name} - ${row.class_name} - ${row.subject_name}`);
    });
    
    console.log(`\n✅ Total assignments updated: ${summary.length}`);
    
  } catch (error: any) {
    console.error('❌ Error updating teacher allocations:', error.message);
    throw error;
  } finally {
    await conn.end();
  }
}

updateTeacherAllocations().then(() => {
  console.log('\n🎉 Teacher subject allocation update completed successfully!');
  process.exit(0);
}).catch((error) => {
  console.error('❌ Fatal error:', error);
  process.exit(1);
});

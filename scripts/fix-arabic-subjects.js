// Quick fix: Convert subject names to Arabic in JSON
// Run with: node scripts/fix-arabic-subjects.js

const fs = require('fs').promises;

// Subject name mapping from English to Arabic
const subjectMapping = {
  'TARBIYAH': 'التربية',
  'الفقه': 'الفقه',
  'القرآن': 'القرآن',
  'اللغة': 'اللغة'
};

async function fixArabicSubjects() {
  try {
    console.log('Converting subject names to Arabic...');

    const jsonPath = '/home/xhenvolt/Systems/DraisLongTermVersion/backup/theology-results-term1-2026.json';
    const jsonData = await fs.readFile(jsonPath, 'utf-8');
    const data = JSON.parse(jsonData);

    // Update subject names in all classes
    data.classes.forEach(classInfo => {
      classInfo.students.forEach(student => {
        student.subjects.forEach(subject => {
          if (subjectMapping[subject.subject_name]) {
            subject.subject_name = subjectMapping[subject.subject_name];
            subject.subject_code = subjectMapping[subject.subject_name];
          }
        });
      });
    });

    // Save updated JSON
    await fs.writeFile(jsonPath, JSON.stringify(data, null, 2));
    console.log('✅ Subject names converted to Arabic');

    // Count subjects
    let totalArabicSubjects = 0;
    data.classes.forEach(cls => {
      cls.students.forEach(student => {
        student.subjects.forEach(subject => {
          if (['التربية', 'الفقه', 'القرآن', 'اللغة'].includes(subject.subject_name)) {
            totalArabicSubjects++;
          }
        });
      });
    });

    console.log(`📊 Found ${totalArabicSubjects} Arabic subjects across all students`);

  } catch (error) {
    console.error('Error:', error);
  }
}

fixArabicSubjects();
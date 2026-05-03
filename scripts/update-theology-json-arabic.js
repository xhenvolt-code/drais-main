// Update theology JSON with correct Arabic classes and subjects
// Run with: node scripts/update-theology-json-arabic.js

const fs = require('fs').promises;
const path = require('path');

async function updateTheologyJson() {
  try {
    console.log('Updating theology JSON with Arabic classes and subjects...');

    const jsonPath = path.join(__dirname, '..', 'backup', 'theology-results-term1-2026.json');
    const jsonData = await fs.readFile(jsonPath, 'utf-8');
    const data = JSON.parse(jsonData);

    // Class name mapping (English to Arabic)
    const classMapping = {
      'PRIMARY ONE': 'صف الأول',
      'PRIMARY TWO': 'صف الثاني',
      'PRIMARY THREE': 'صف الثالث',
      'PRIMARY FOUR': 'صف الرابع',
      'PRIMARY FIVE': 'صف الخامس',
      'PRIMARY SIX': 'صف السادس',
      'TAHFIZ': 'الروضة (T0P)' // Assuming TAHFIZ maps to TOP
    };

    // Subject name mapping (English to Arabic)
    const subjectMapping = {
      'Islamic Religious Education': 'التربية',
      'I.R.E': 'التربية'
    };

    // Update classes
    data.classes = data.classes.map(classInfo => ({
      ...classInfo,
      class_name: classMapping[classInfo.class_name] || classInfo.class_name
    }));

    // Add missing Arabic classes if they don't exist
    const existingClasses = data.classes.map(c => c.class_name);
    const requiredClasses = [
      'الروضة (BABY)',
      'الروضة (MIDDLE)',
      'الروضة (T0P)',
      'صف الأول',
      'صف الثاني',
      'صف الثالث',
      'صف الرابع',
      'صف الخامس',
      'صف السادس'
    ];

    // Add missing classes with empty students arrays
    requiredClasses.forEach(className => {
      if (!existingClasses.includes(className)) {
        data.classes.push({
          class_id: null, // Will be assigned later if needed
          class_name: className,
          students: []
        });
      }
    });

    // Update subjects in all students
    data.classes.forEach(classInfo => {
      classInfo.students.forEach(student => {
        // First, convert existing subjects to Arabic
        student.subjects.forEach(subject => {
          subject.subject_name = subjectMapping[subject.subject_name] || subject.subject_name;
          subject.subject_code = subjectMapping[subject.subject_code] || subject.subject_code;
        });

        // Then ensure all required Arabic subjects are included
        const arabicSubjects = [
          { subject_name: 'التربية', subject_code: 'التربية' },
          { subject_name: 'الفقه', subject_code: 'الفقه' },
          { subject_name: 'القرآن', subject_code: 'القرآن' },
          { subject_name: 'اللغة', subject_code: 'اللغة' }
        ];

        arabicSubjects.forEach(arSub => {
          if (!student.subjects.some(s => s.subject_name === arSub.subject_name)) {
            student.subjects.push({
              subject_id: null,
              subject_name: arSub.subject_name,
              subject_code: arSub.subject_code,
              results: [{
                score: "0.00",
                grade: "",
                remarks: "",
                result_type: "End of term"
              }]
            });
          }
        });

        // If student has more than 4 subjects, keep only the first 4 (the required ones)
        if (student.subjects.length > 4) {
          student.subjects = student.subjects.slice(0, 4);
        }
      });
    });

    // Recalculate totals and positions for each class
    data.classes.forEach(classInfo => {
      classInfo.students.forEach(student => {
        // Recalculate scores
        let totalScore = 0;
        let subjectCount = 0;

        student.subjects.forEach(subject => {
          const subjectTotal = subject.results.reduce((sum, r) => sum + (parseFloat(r.score) || 0), 0);
          totalScore += subjectTotal;
          subjectCount++;
        });

        student.total_score = subjectCount > 0 ? Math.round(totalScore * 100) / 100 : 0;
        student.average_score = subjectCount > 0 ? Math.round((totalScore / subjectCount) * 100) / 100 : 0;
      });

      // Recalculate positions
      classInfo.students.sort((a, b) => b.average_score - a.average_score);
      classInfo.students.forEach((stu, idx) => {
        stu.position = idx + 1;
      });
    });

    // Save updated JSON
    await fs.writeFile(jsonPath, JSON.stringify(data, null, 2));
    console.log('✅ Updated theology JSON with Arabic classes and subjects');

    const totalStudents = data.classes.reduce((sum, c) => sum + c.students.length, 0);
    console.log(`📊 ${data.classes.length} classes, ${totalStudents} students updated`);

  } catch (error) {
    console.error('❌ Error updating JSON:', error);
  }
}

updateTheologyJson();
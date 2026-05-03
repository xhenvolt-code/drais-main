import fs from 'fs/promises';

// Reverse mapping: Arabic → English numerals
const englishNumerals = {
  '٠': '0',
  '١': '1',
  '٢': '2',
  '٣': '3',
  '٤': '4',
  '٥': '5',
  '٦': '6',
  '٧': '7',
  '٨': '8',
  '٩': '9'
};

// Arabic numeral mapping
const arabicNumerals = {
  '0': '٠',
  '1': '١',
  '2': '٢',
  '3': '٣',
  '4': '٤',
  '5': '٥',
  '6': '٦',
  '7': '٧',
  '8': '٨',
  '9': '٩',
  '.': '٫'  // Arabic decimal point
};

// Convert Arabic numerals back to English for calculation
function fromArabicNumerals(arabicStr) {
  if (!arabicStr) return null;
  const str = String(arabicStr);
  return parseFloat(str.split('').map(d => englishNumerals[d] || d).join(''));
}

// Convert number to Arabic numerals - handles both number and string input
function toArabicNumerals(num) {
  if (num === null || num === undefined) return null;
  const str = String(num);
  return str.split('').map(d => arabicNumerals[d] || d).join('');
}

// Check if text is already Arabic
function isArabic(text) {
  if (!text) return false;
  const arabicRegex = /[\u0600-\u06FF]/;
  return arabicRegex.test(text);
}

// Simple English to Arabic transliteration mapping
const transliterationMap = {
  // A sounds
  'A': 'ا', 'a': 'ا',
  'AA': 'آ', 'aa': 'آ',
  // B
  'B': 'ب', 'b': 'ب',
  // T
  'T': 'ت', 't': 'ت',
  'TH': 'ث', 'Th': 'ث', 'th': 'ث',
  // J
  'J': 'ج', 'j': 'ج',
  // H
  'H': 'ح', 'h': 'ح',
  'KH': 'خ', 'Kh': 'خ', 'kh': 'خ',
  // D
  'D': 'د', 'd': 'د',
  'DH': 'ذ', 'Dh': 'ذ', 'dh': 'ذ',
  // R
  'R': 'ر', 'r': 'ر',
  // Z
  'Z': 'ز', 'z': 'ز',
  // S
  'S': 'س', 's': 'س',
  'SH': 'ش', 'Sh': 'ش', 'sh': 'ش',
  'SS': 'ص', 'Ss': 'ص', 'ss': 'ص',
  // D (emphatic)
  'DD': 'ض', 'Dd': 'ض', 'dd': 'ض',
  // T (emphatic)
  'TT': 'ط', 'Tt': 'ط', 'tt': 'ط',
  // Z (emphatic)
  'ZZ': 'ظ', 'Zz': 'ظ', 'zz': 'ظ',
  // AIN
  'AIN': 'ع', 'Ain': 'ع', 'ain': 'ع',
  // GHAIN
  'GH': 'غ', 'Gh': 'غ', 'gh': 'غ',
  // F
  'F': 'ف', 'f': 'ف',
  // Q
  'Q': 'ق', 'q': 'ق',
  // K
  'K': 'ك', 'k': 'ك',
  // L
  'L': 'ل', 'l': 'ل',
  // M
  'M': 'م', 'm': 'م',
  // N
  'N': 'ن', 'n': 'ن',
  // W
  'W': 'و', 'w': 'و',
  // Y
  'Y': 'ي', 'y': 'ي',
  // E
  'E': 'ي', 'e': 'ي',
  'I': 'ي', 'i': 'ي',
  // O, U
  'O': 'و', 'o': 'و',
  'U': 'و', 'u': 'و'
};

// Enhanced transliteration with common names
const commonNameMap = {
  // Common English names → Arabic
  'YUSUF': 'يوسف',
  'YOUSUF': 'يوسف',
  'ABDUL': 'عبدال',
  'ABDUL-KARIM': 'عبدالكريم',
  'ABDUL-RAHMAN': 'عبدالرحمن',
  'ABDUL-RAHIM': 'عبدالرحيم',
  'ABDALLAH': 'عبدالله',
  'ABUBAKAR': 'أبوبكر',
  'AYMAN': 'أيمن',
  'BASHIRA': 'بشيرة',
  'BASHIIRAH': 'بشيرة',
  'DALILLAH': 'دليلة',
  'HAMDAN': 'حمدان',
  'HAWA': 'هاوة',
  'HASSAN': 'حسن',
  'IDRIS': 'إدريس',
  'IBRAHIM': 'إبراهيم',
  'ISA': 'عيسى',
  'HARUNA': 'هارون',
  'ISOTA': 'إيسوتا',
  'JALIL': 'جليل',
  'JALIRUDIIN': 'جليل الدين',
  'KATEIKE': 'كاتيكي',
  'KHALID': 'خالد',
  'KHIDHIR': 'خضر',
  'KHADIJJAH': 'خديجة',
  'KIRABIRA': 'كيرابيرا',
  'KUMUGONZA': 'كومجونزا',
  'KYOTAITE': 'كيوتايتي',
  'LEELAH': 'ليلة',
  'MAHAD': 'محاد',
  'MAGANDA': 'ماجندا',
  'MARIAM': 'مريم',
  'MPAATA': 'مبّاتا',
  'MUDOOLA': 'موديولا',
  'MUHSIN': 'محسن',
  'MUSOBYA': 'موسوبيا',
  'MUSASIZI': 'موساسيزي',
  'MUSENZE': 'موسينزي',
  'MUTESI': 'موتيسي',
  'MUWAYA': 'موويا',
  'MUSA': 'موسى',
  'NABAWIRE': 'ناباوير',
  'NAKATO': 'ناكاتو',
  'NAKISANDA': 'ناكيساندا',
  'NANSAMBA': 'نانسامبا',
  'NANGOBI': 'ننجوبي',
  'NANGOBI AALIYAH': 'ننجوبي علية',
  'NAMATENDE': 'ناماتندي',
  'NANJIYA': 'ننجية',
  'NASSER': 'ناصر',
  'NASWIIBA': 'ناسويبا',
  'NIBRAS': 'نبراس',
  'NDYEKU': 'نديكو',
  'NINSIIMA': 'نينسيما',
  'NKOOBE': 'نكوبي',
  'NOORIAT': 'نورية',
  'NYOMBI': 'نيومبي',
  'RAJAB': 'رجب',
  'RAHMAH': 'رحمة',
  'RANIA': 'رانيا',
  'SHIFRAH': 'شفرة',
  'SHATURAH': 'شطورة',
  'SSEMBATYA': 'سيمباتيا',
  'SSONZI': 'سونزي',
  'SAID': 'سعيد',
  'TAIBU': 'تايبو',
  'TAUBAH': 'توبة',
  'UKASHA': 'عقاشة',
  'UTHMAN': 'عثمان',
  'WANDERA': 'واندرا',
  'WAGOGO': 'واجوجو',
  'AALIYAH': 'علية',
  'ABASI': 'أباسي',
  'AJAMBO': 'أجامبو',
  'BABIRYE': 'بابيري',
  'BOGERE': 'بوجير',
  'GOOBI': 'جوبي',
  'KAMBA': 'كامبا',
  'KHANIT': 'خنيت',
  'MAYEMBA': 'ماييمبا'
};

// Transliterate English name to Arabic
function transliterateToArabic(name) {
  if (!name || isArabic(name)) return name;

  const upperName = name.toUpperCase().trim();
  
  // Check common names first
  for (const [eng, ar] of Object.entries(commonNameMap)) {
    if (upperName === eng) return ar;
    if (upperName.includes(eng)) {
      // Partial match - split and replace
      const parts = name.split(' ');
      return parts.map(part => {
        const upperPart = part.toUpperCase();
        return commonNameMap[upperPart] || part;
      }).join(' ');
    }
  }

  // Fallback: keep as is if no mapping found
  return name;
}

// Get grade based on score
function getGrade(score) {
  if (score === null || score === undefined) return null;
  const numScore = typeof score === 'string' ? parseFloat(score) : score;
  
  if (numScore >= 90) return 'ممتاز';
  if (numScore >= 80) return 'جيد جدا';
  if (numScore >= 70) return 'جيد';
  if (numScore >= 60) return 'مقبول';
  if (numScore >= 50) return 'ضعيف';
  return 'ضعيف جدا';
}

// Get remarks based on average
function getRemarks(average) {
  if (average === null || average === undefined) return 'ضعيف جدا ويحتاج متابعة';
  const numAvg = typeof average === 'string' ? parseFloat(average) : average;
  
  if (numAvg >= 80) return 'أداء ممتاز';
  if (numAvg >= 70) return 'أداء جيد جدا';
  if (numAvg >= 60) return 'أداء جيد';
  if (numAvg >= 50) return 'يحتاج إلى تحسين';
  return 'ضعيف جدا ويحتاج متابعة';
}

async function arabizeTheologyData() {
  try {
    console.log('🔄 Starting arabization of theology results...\n');

    const jsonPath = '/home/xhenvolt/Systems/DraisLongTermVersion/backup/theology-results-term1-2026.json';
    const jsonData = await fs.readFile(jsonPath, 'utf-8');
    const data = JSON.parse(jsonData);

    let statsNameTranslit = 0;
    let statsNumeralConvert = 0;
    let statsGradesAdded = 0;
    let statsRemarksAdded = 0;

    // Transform each class
    for (const classInfo of data.classes) {
      // Normalize class name (should already be Arabic)
      classInfo.className = classInfo.className.trim();

      // Normalize subjects
      const validSubjects = ['التربية', 'الفقه', 'القرآن', 'اللغة'];
      classInfo.subjects = validSubjects;

      // Transform each student
      for (const student of classInfo.students) {
        // 1. Transliterate name if needed
        if (!isArabic(student.name)) {
          student.name = transliterateToArabic(student.name);
          statsNameTranslit++;
        }

        // 2. Process results
        let totalScore = 0;
        let scoredSubjects = 0;

        for (const result of student.results) {
          // Normalize subject name
          result.subject = result.subject.trim();

          // Calculate numeric score BEFORE conversion (scores might be Arabic already)
          let numericScore = null;
          if (result.score !== null && result.score !== undefined) {
            // Check if score is already Arabic numerals
            if (typeof result.score === 'string' && /[٠-٩]/.test(result.score)) {
              numericScore = fromArabicNumerals(result.score);
            } else {
              numericScore = typeof result.score === 'string' ? parseFloat(result.score) : result.score;
            }
            totalScore += numericScore;
            scoredSubjects++;
          }

          // Add/update grade based on NUMERIC score
          const grade = getGrade(numericScore);
          result.grade = grade;
          if (grade) statsGradesAdded++;

          // Ensure score is Arabic numerals
          if (result.score !== null && result.score !== undefined) {
            // If already Arabic, keep it; if English, convert it
            if (typeof result.score === 'string' && !/[٠-٩]/.test(result.score)) {
              result.score = toArabicNumerals(result.score);
              statsNumeralConvert++;
            } else if (typeof result.score !== 'string') {
              result.score = toArabicNumerals(result.score);
              statsNumeralConvert++;
            }
          }
        }

        // 3. Convert totals and averages to Arabic numerals
        // Note: these are already numeric, so just convert
        if (student.total !== null && student.total !== undefined) {
          student.total = toArabicNumerals(student.total);
          statsNumeralConvert++;
        }

        if (student.average !== null && student.average !== undefined) {
          student.average = toArabicNumerals(student.average);
          statsNumeralConvert++;
        }

        // 4. Convert position to Arabic numerals
        if (student.position !== null && student.position !== undefined) {
          student.position = toArabicNumerals(student.position);
          statsNumeralConvert++;
        }

        // 5. Add/update remarks based on NUMERIC average (handle Arabic numerals)
        let numericAverage = null;
        if (student.average !== null && student.average !== undefined) {
          if (typeof student.average === 'string' && /[٠-٩]/.test(student.average)) {
            numericAverage = fromArabicNumerals(student.average);
          } else {
            numericAverage = typeof student.average === 'string' 
              ? parseFloat(student.average)
              : student.average;
          }
        }
        
        if (!student.remarks || student.remarks === null) {
          student.remarks = getRemarks(numericAverage);
          statsRemarksAdded++;
        } else if (typeof student.remarks === 'string' && !isArabic(student.remarks)) {
          student.remarks = getRemarks(numericAverage);
          statsRemarksAdded++;
        }
      }
    }

    // Validation
    console.log('✓ Validation Checks:');
    let validationPass = true;

    // Check all numbers are Arabic
    const jsonStr = JSON.stringify(data);
    const englishNumbers = jsonStr.match(/[0-9]/g);
    if (englishNumbers && englishNumbers.length > 0) {
      console.log(`  ❌ Found ${englishNumbers.length} English numerals remaining`);
      validationPass = false;
    } else {
      console.log('  ✅ All numerals converted to Arabic');
    }

    // Check all names are Arabic
    let nonArabicNames = 0;
    for (const cls of data.classes) {
      for (const student of cls.students) {
        if (!isArabic(student.name)) {
          console.log(`    ⚠️  Non-Arabic name: ${student.name}`);
          nonArabicNames++;
        }
      }
    }
    if (nonArabicNames > 0) {
      console.log(`  ⚠️  ${nonArabicNames} names not transliterated`);
    } else {
      console.log('  ✅ All names converted to Arabic');
    }

    // Check subject normalization
    let subjectIssues = 0;
    for (const cls of data.classes) {
      for (const student of cls.students) {
        if (student.results.length !== 4) {
          console.log(`  ❌ Student ${student.id} has ${student.results.length} subjects (expected 4)`);
          subjectIssues++;
        }
        for (const result of student.results) {
          if (!['التربية', 'الفقه', 'القرآن', 'اللغة'].includes(result.subject)) {
            console.log(`    ❌ Invalid subject: ${result.subject}`);
            subjectIssues++;
          }
        }
      }
    }
    if (subjectIssues === 0) {
      console.log('  ✅ All subjects normalized correctly');
    }

    // Check grades are Arabic
    let noGrades = 0;
    for (const cls of data.classes) {
      for (const student of cls.students) {
        for (const result of student.results) {
          if (!result.grade) {
            noGrades++;
          }
        }
      }
    }
    if (noGrades === 0) {
      console.log('  ✅ All students have grades');
    } else {
      console.log(`  ⚠️  ${noGrades} results missing grades`);
    }

    // Check remarks
    let noRemarks = 0;
    for (const cls of data.classes) {
      for (const student of cls.students) {
        if (!student.remarks) noRemarks++;
      }
    }
    if (noRemarks === 0) {
      console.log('  ✅ All students have remarks');
    } else {
      console.log(`  ⚠️  ${noRemarks} students missing remarks`);
    }

    // Write back
    await fs.writeFile(jsonPath, JSON.stringify(data, null, 2), 'utf-8');

    console.log('\n📊 Transformation Statistics:');
    console.log(`  Names transliterated: ${statsNameTranslit}`);
    console.log(`  Numerals converted: ${statsNumeralConvert}`);
    console.log(`  Grades added/updated: ${statsGradesAdded}`);
    console.log(`  Remarks auto-filled: ${statsRemarksAdded}`);

    console.log('\n✅ File written: /backup/theology-results-term1-2026.json');
    console.log(`   Ready for Arabic-language report generation`);

  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

arabizeTheologyData();

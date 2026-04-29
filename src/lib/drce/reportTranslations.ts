/**
 * src/lib/drce/reportTranslations.ts
 * 
 * Master translation system for DRCE bilingual report engine.
 * Provides all report labels, terminology, and academic vocabulary in English and Arabic.
 * 
 * This is the source of truth for all report UI text.
 * NO hardcoded strings in components — everything comes through here.
 */

export type Language = 'en' | 'ar';

/**
 * Report vocabulary translation dictionary
 * Covers all labels, headers, comments, and academic terminology
 */
export const reportTranslations = {
  en: {
    // ─── School Information ─────────────────────────────────────────────
    schoolLogo: 'School Logo',
    schoolName: 'School Name',
    schoolAddress: 'Address',
    schoolContact: 'Contact',
    schoolEmail: 'Email',
    schoolWebsite: 'Website',
    schoolMotto: 'Motto',
    centerNumber: 'Center Number',
    registrationNumber: 'Registration Number',

    // ─── Student Information ─────────────────────────────────────────────
    studentInfo: 'Student Information',
    studentNumber: 'Student No.',
    admissionNo: 'Admission No.',
    name: 'Name',
    firstName: 'First Name',
    lastName: 'Last Name',
    sex: 'Sex',
    gender: 'Gender',
    dateOfBirth: 'Date of Birth',
    class: 'Class',
    classNumber: 'Class Number',
    stream: 'Stream',
    division: 'Division',
    photo: 'Photo',

    // ─── Results & Grades ──────────────────────────────────────────────
    results: 'Results',
    subject: 'Subject',
    subjectCode: 'Code',
    subjectName: 'Subject Name',
    score: 'Score',
    marks: 'Marks',
    points: 'Points',
    grade: 'Grade',
    division: 'Division',
    position: 'Position',
    classPosition: 'Class Position',
    total: 'Total',
    totalMarks: 'Total Marks',
    totalPoints: 'Total Points',
    average: 'Average',
    averageMarks: 'Average Marks',
    aggregate: 'Aggregate',
    aggregates: 'Aggregates',

    // ─── Assessment Components ────────────────────────────────────────────
    midTermScore: 'Mid Term',
    endTermScore: 'End Term',
    regularScore: 'Score',
    assessment: 'Assessment',
    attendance: 'Attendance',
    presentDays: 'Present Days',
    absentDays: 'Absent Days',
    totalDays: 'Total Days',
    attendancePercentage: 'Attendance %',

    // ─── Comments & Remarks ────────────────────────────────────────────
    comments: 'Comments',
    remark: 'Remark',
    remarks: 'Remarks',
    classTeacherComment: 'Class Teacher Comment',
    headteacherComment: 'Headteacher Comment',
    dosComment: 'DOS Comment',
    directorComment: 'Director Comment',
    teacherComment: 'Teacher Comment',
    subjectComment: 'Subject Comment',

    // ─── Grading System ────────────────────────────────────────────────
    gradeDescriptors: 'Grade Descriptors',
    scoreRange: 'Score Range',
    gradeTable: 'Grade Table',
    gradesLegend: 'Grades Legend',

    // ─── Terms & Academic Year ─────────────────────────────────────────
    term: 'Term',
    term1: 'Term 1',
    term2: 'Term 2',
    term3: 'Term 3',
    termBeginning: 'Term Beginning',
    termEnding: 'Term Ending',
    academicYear: 'Academic Year',
    endOfTermReport: 'End of Term Report',
    nextTermBegins: 'Next Term Begins',
    promotion: 'Promotion',
    promoted: 'Promoted',
    notPromoted: 'Not Promoted',
    graduation: 'Graduation',
    graduated: 'Graduated',

    // ─── Signatures & Approvals ────────────────────────────────────────
    signature: 'Signature',
    classTeacherSignature: 'Class Teacher Signature',
    headteacherSignature: 'Headteacher Signature',
    date: 'Date',
    printDate: 'Print Date',
    printedBy: 'Printed by',
    approvedBy: 'Approved by',
    verifiedBy: 'Verified by',

    // ─── Curriculum Types ──────────────────────────────────────────────
    secular: 'Secular',
    theology: 'Theology',
    secular_subjects: 'Secular Subjects',
    theology_subjects: 'Theology Subjects',
    secularProgram: 'Secular Program',
    theologyProgram: 'Theology Program',

    // ─── Islamic Subjects ──────────────────────────────────────────────
    quran: 'Quran',
    fiqh: 'Fiqh',
    tawhid: 'Tawhid',
    hadith: 'Hadith',
    akhlaq: 'Akhlaq',
    islamicStudies: 'Islamic Studies',

    // ─── General Terms ────────────────────────────────────────────────
    barcode: 'Barcode',
    printable: 'Printable',
    exportable: 'Exportable',
    report: 'Report',
    reportCard: 'Report Card',
    transcript: 'Transcript',
    certificate: 'Certificate',
    medal: 'Medal',
    honor: 'Honor',
    excellentAttendance: 'Excellent Attendance',

    // ─── Ribbon Labels ─────────────────────────────────────────────────
    ribbonBest: 'Best in Class',
    ribbonTop: 'Top 3',
    ribbonGood: 'Good Performance',
    ribbonImprovement: 'Improvement',
    ribbonEncouragement: 'Encouragement',

    // ─── Canned Comments (Examples) ────────────────────────────────────
    cannedComment_excellent: 'Brilliant!! all my hopes are in you',
    cannedComment_good: 'Great work done, keep it up',
    cannedComment_fair: 'Fair performance, work harder',
    cannedComment_needsImprovement: 'Needs improvement in core subjects',
    cannedComment_encouraging: 'Encouraging progress, continue the good work',
    cannedComment_encouragement: 'You have the potential, work hard and achieve your goals',
  },

  ar: {
    // ─── School Information ─────────────────────────────────────────────
    schoolLogo: 'شعار المدرسة',
    schoolName: 'اسم المدرسة',
    schoolAddress: 'العنوان',
    schoolContact: 'جهات الاتصال',
    schoolEmail: 'البريد الإلكتروني',
    schoolWebsite: 'الموقع الإلكتروني',
    schoolMotto: 'شعار المدرسة',
    centerNumber: 'رقم المركز',
    registrationNumber: 'رقم التسجيل',

    // ─── Student Information ─────────────────────────────────────────────
    studentInfo: 'معلومات الطالب',
    studentNumber: 'رقم الطالب',
    admissionNo: 'رقم القبول',
    name: 'الاسم',
    firstName: 'الاسم الأول',
    lastName: 'اسم العائلة',
    sex: 'الجنس',
    gender: 'الجنس',
    dateOfBirth: 'تاريخ الميلاد',
    class: 'الصف',
    classNumber: 'رقم الفصل',
    stream: 'الشعبة',
    division: 'القسم',
    photo: 'الصورة',

    // ─── Results & Grades ──────────────────────────────────────────────
    results: 'النتائج',
    subject: 'المادة',
    subjectCode: 'الرمز',
    subjectName: 'اسم المادة',
    score: 'الدرجة',
    marks: 'العلامات',
    points: 'النقاط',
    grade: 'التقدير',
    division: 'الدرجة',
    position: 'الترتيب',
    classPosition: 'الترتيب في الصف',
    total: 'المجموع',
    totalMarks: 'مجموع العلامات',
    totalPoints: 'مجموع النقاط',
    average: 'المتوسط',
    averageMarks: 'متوسط العلامات',
    aggregate: 'المجموع الكلي',
    aggregates: 'المجاميع الكلية',

    // ─── Assessment Components ────────────────────────────────────────────
    midTermScore: 'منتصف الفصل',
    endTermScore: 'نهاية الفصل',
    regularScore: 'الدرجة',
    assessment: 'التقويم',
    attendance: 'الحضور',
    presentDays: 'أيام الحضور',
    absentDays: 'أيام الغياب',
    totalDays: 'إجمالي الأيام',
    attendancePercentage: 'نسبة الحضور %',

    // ─── Comments & Remarks ────────────────────────────────────────────
    comments: 'التعليقات',
    remark: 'ملاحظة',
    remarks: 'ملاحظات',
    classTeacherComment: 'تعليق معلم الفصل',
    headteacherComment: 'تعليق المدير',
    dosComment: 'تعليق مدير الدراسة',
    directorComment: 'تعليق المدير',
    teacherComment: 'تعليق المعلم',
    subjectComment: 'تعليق المادة',

    // ─── Grading System ────────────────────────────────────────────────
    gradeDescriptors: 'وصف التقديرات',
    scoreRange: 'نطاق الدرجات',
    gradeTable: 'جدول التقديرات',
    gradesLegend: 'مفتاح التقديرات',

    // ─── Terms & Academic Year ─────────────────────────────────────────
    term: 'الفصل',
    term1: 'الفصل الأول',
    term2: 'الفصل الثاني',
    term3: 'الفصل الثالث',
    termBeginning: 'بداية الفصل',
    termEnding: 'نهاية الفصل',
    academicYear: 'السنة الدراسية',
    endOfTermReport: 'تقرير نهاية الفصل الدراسي',
    nextTermBegins: 'بدء الفصل القادم',
    promotion: 'الترفيع',
    promoted: 'تم ترفيعه',
    notPromoted: 'لم يتم ترفيعه',
    graduation: 'التخرج',
    graduated: 'تخرج',

    // ─── Signatures & Approvals ────────────────────────────────────────
    signature: 'التوقيع',
    classTeacherSignature: 'توقيع معلم الفصل',
    headteacherSignature: 'توقيع المدير',
    date: 'التاريخ',
    printDate: 'تاريخ الطباعة',
    printedBy: 'طبع بواسطة',
    approvedBy: 'وافق عليه',
    verifiedBy: 'تحقق من قبل',

    // ─── Curriculum Types ──────────────────────────────────────────────
    secular: 'عام',
    theology: 'ديني',
    secular_subjects: 'المواد العامة',
    theology_subjects: 'المواد الدينية',
    secularProgram: 'البرنامج العام',
    theologyProgram: 'البرنامج الديني',

    // ─── Islamic Subjects ──────────────────────────────────────────────
    quran: 'القرآن الكريم',
    fiqh: 'الفقه',
    tawhid: 'التوحيد',
    hadith: 'الحديث الشريف',
    akhlaq: 'الأخلاق',
    islamicStudies: 'الدراسات الإسلامية',

    // ─── General Terms ────────────────────────────────────────────────
    barcode: 'الرمز',
    printable: 'قابل للطباعة',
    exportable: 'قابل للتصدير',
    report: 'التقرير',
    reportCard: 'بطاقة التقرير',
    transcript: 'نسخة رسمية',
    certificate: 'شهادة',
    medal: 'ميدالية',
    honor: 'شرف',
    excellentAttendance: 'حضور ممتاز',

    // ─── Ribbon Labels ─────────────────────────────────────────────────
    ribbonBest: 'الأفضل في الصف',
    ribbonTop: 'الأفضل 3',
    ribbonGood: 'أداء جيد',
    ribbonImprovement: 'تحسن',
    ribbonEncouragement: 'تشجيع',

    // ─── Canned Comments (Examples) ────────────────────────────────────
    cannedComment_excellent: 'ممتاز جدًا، كل آمالي معلقة بك',
    cannedComment_good: 'عمل رائع، واصل التميز',
    cannedComment_fair: 'أداء مرضي، اعمل بجد أكثر',
    cannedComment_needsImprovement: 'يحتاج إلى تحسن في المواد الأساسية',
    cannedComment_encouraging: 'تقدم مشجع، استمر في العمل الجيد',
    cannedComment_encouragement: 'لديك القدرة، اعمل بجد وحقق أحلامك',
  },
} as const;

/**
 * Academic subject translation map
 * Supports both secular and Islamic subjects
 */
export const subjectTranslations: Record<string, { en: string; ar: string }> = {
  // ─── Core Secular Subjects ───────────────────────────────────────
  'Mathematics': { en: 'Mathematics', ar: 'الرياضيات' },
  'English': { en: 'English', ar: 'اللغة الإنجليزية' },
  'English Language': { en: 'English Language', ar: 'اللغة الإنجليزية' },
  'Science': { en: 'Science', ar: 'العلوم' },
  'Biology': { en: 'Biology', ar: 'الأحياء' },
  'Chemistry': { en: 'Chemistry', ar: 'الكيمياء' },
  'Physics': { en: 'Physics', ar: 'الفيزياء' },
  'Social Studies': { en: 'Social Studies', ar: 'الدراسات الاجتماعية' },
  'Geography': { en: 'Geography', ar: 'الجغرافيا' },
  'History': { en: 'History', ar: 'التاريخ' },
  'Civics': { en: 'Civics', ar: 'التربية المدنية' },
  'Arabic': { en: 'Arabic', ar: 'اللغة العربية' },
  'French': { en: 'French', ar: 'الفرنسية' },
  'German': { en: 'German', ar: 'الألمانية' },
  'Information & Communication Technology': { en: 'Information & Communication Technology', ar: 'تكنولوجيا المعلومات والاتصالات' },
  'ICT': { en: 'ICT', ar: 'تقنية المعلومات' },
  'Computer Science': { en: 'Computer Science', ar: 'علوم الحاسوب' },
  'Physical Education': { en: 'Physical Education', ar: 'التربية البدنية' },
  'Sports': { en: 'Sports', ar: 'الرياضة' },
  'Music': { en: 'Music', ar: 'الموسيقى' },
  'Art': { en: 'Art', ar: 'الفنون' },
  'Fine Art': { en: 'Fine Art', ar: 'الفن التشكيلي' },
  'Business Studies': { en: 'Business Studies', ar: 'دراسات الأعمال' },
  'Economics': { en: 'Economics', ar: 'الاقتصاد' },
  'Accounting': { en: 'Accounting', ar: 'المحاسبة' },
  'Literature': { en: 'Literature', ar: 'الأدب' },
  'English Literature': { en: 'English Literature', ar: 'الأدب الإنجليزي' },

  // ─── Islamic/Theology Subjects ────────────────────────────────────
  'Quran': { en: 'Quran', ar: 'القرآن الكريم' },
  'Quranic Studies': { en: 'Quranic Studies', ar: 'دراسات قرآنية' },
  'Quran Memorization': { en: 'Quran Memorization', ar: 'حفظ القرآن' },
  'Fiqh': { en: 'Fiqh', ar: 'الفقه' },
  'Islamic Jurisprudence': { en: 'Islamic Jurisprudence', ar: 'الفقه الإسلامي' },
  'Tawhid': { en: 'Tawhid', ar: 'التوحيد' },
  'Islamic Theology': { en: 'Islamic Theology', ar: 'العقيدة الإسلامية' },
  'Hadith': { en: 'Hadith', ar: 'الحديث الشريف' },
  'Hadith Studies': { en: 'Hadith Studies', ar: 'دراسات الحديث' },
  'Sunnah': { en: 'Sunnah', ar: 'السنة النبوية' },
  'Akhlaq': { en: 'Akhlaq', ar: 'الأخلاق' },
  'Islamic Ethics': { en: 'Islamic Ethics', ar: 'الأخلاق الإسلامية' },
  'Islamic Studies': { en: 'Islamic Studies', ar: 'الدراسات الإسلامية' },
  'Islamic History': { en: 'Islamic History', ar: 'التاريخ الإسلامي' },
  'Sirah': { en: 'Sirah', ar: 'السيرة النبوية' },
  'Tajweed': { en: 'Tajweed', ar: 'أحكام التجويد' },

  // ─── Supplementary Subjects ──────────────────────────────────────
  'Kiswahlii': { en: 'Kiswahili', ar: 'لغة السواحيلية' },
  'Swahili': { en: 'Swahili', ar: 'السواحيلية' },
  'Environmental Science': { en: 'Environmental Science', ar: 'العلوم البيئية' },
  'Agriculture': { en: 'Agriculture', ar: 'الزراعة' },
  'Health': { en: 'Health', ar: 'الصحة' },
  'Life Skills': { en: 'Life Skills', ar: 'مهارات الحياة' },
};

/**
 * Get a translation by key
 * Falls back to English key if not found
 */
export function t(key: keyof typeof reportTranslations['en'], language: Language = 'en'): string {
  const translations = reportTranslations[language];
  return (translations[key as keyof typeof translations] as string) || key;
}

/**
 * Get a subject translation
 */
export function translateSubject(subjectName: string, language: Language = 'en'): string {
  if (!subjectName) return '';
  
  // Try exact match first
  const translation = subjectTranslations[subjectName];
  if (translation) {
    return translation[language] || translation.en;
  }

  // Try case-insensitive match
  const match = Object.entries(subjectTranslations).find(
    ([key]) => key.toLowerCase() === subjectName.toLowerCase()
  );

  if (match) {
    const [, translation] = match;
    return translation[language] || translation.en;
  }

  // Return original if no translation found
  return subjectName;
}

/**
 * Get all available translations for a subject
 */
export function getSubjectTranslations(subjectName: string): { en: string; ar: string } {
  return subjectTranslations[subjectName] || { en: subjectName, ar: subjectName };
}

/**
 * Batch translate multiple keys
 */
export function tMany(keys: (keyof typeof reportTranslations['en'])[], language: Language = 'en'): Record<string, string> {
  const result: Record<string, string> = {};
  keys.forEach(key => {
    result[key] = t(key, language);
  });
  return result;
}

/**
 * Get all translations for a language
 */
export function getAllTranslations(language: Language = 'en'): typeof reportTranslations['en'] {
  return reportTranslations[language];
}

/**
 * Merge user/school custom translations with defaults
 * Allows schools to override standard translations for customization
 */
export function mergeTranslations(
  defaults: typeof reportTranslations['en'],
  custom?: Record<string, string>,
  language: Language = 'en'
): Record<string, string> {
  return {
    ...defaults,
    ...(custom || {}),
  };
}

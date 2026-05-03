/**
 * Teacher Initials Mapping for Northgate School
 * Maps class + subject combinations to teacher initials
 */

export const TEACHER_MAPPING = {
  // Nursery Classes - Apio Esther (A.E)
  "BABY CLASS:NUMBERS": "A.E",
  "BABY CLASS:LANGUAGE DEVELOPMENT II": "A.E",
  "MIDDLE CLASS:NUMBERS": "A.E",
  "MIDDLE CLASS:LANGUAGE DEVELOPMENT II": "A.E",
  "TOP CLASS:NUMBERS": "A.E",
  "TOP CLASS:LANGUAGE DEVELOPMENT II": "A.E",

  // Nursery Classes - Asekenye Grace (A.G)
  "BABY CLASS:LANGUAGE DEVELOPMENT II": "A.G",
  "MIDDLE CLASS:LANGUAGE DEVELOPMENT II": "A.G",
  "TOP CLASS:LANGUAGE DEVELOPMENT II": "A.G",

  // Nursery Classes - Ikomera Christine (I.C)
  "BABY CLASS:LANGUAGE DEVELOPMENT I": "I.C",
  "BABY CLASS:RELIGIOUS EDUCATION": "I.C",
  "MIDDLE CLASS:LANGUAGE DEVELOPMENT I": "I.C",
  "MIDDLE CLASS:RELIGIOUS EDUCATION": "I.C",
  "TOP CLASS:LANGUAGE DEVELOPMENT I": "I.C",
  "TOP CLASS:RELIGIOUS EDUCATION": "I.C",

  // PRIMARY ONE - Awor Topista (A.T)
  "PRIMARY ONE:ENGLISH": "A.T",
  "PRIMARY ONE:RELIGIOUS EDUCATION": "A.T",

  // PRIMARY TWO - Awor Topista (A.T)
  "PRIMARY TWO:ENGLISH": "A.T",

  // PRIMARY THREE - Multiple Teachers
  "PRIMARY THREE:ENGLISH": "NGS",        // Not specified
  "PRIMARY THREE:MATHEMATICS": "E.E",    // Ekaru Emmanuel
  "PRIMARY THREE:RELIGIOUS EDUCATION": "E.E",  // Ekaru Emmanuel
  "PRIMARY THREE:LITERACY I": "B.C",     // Bakyaire Charles
  "PRIMARY THREE:LITERACY II": "A.T",    // Awor Topista
  "PRIMARY THREE:SOCIAL STUDIES": "NGS", // Not specified

  // PRIMARY FOUR - Multiple Teachers  
  "PRIMARY FOUR:ENGLISH": "E.J",         // Emeru Joel
  "PRIMARY FOUR:MATHEMATICS": "E.G",     // Egau Gerald
  "PRIMARY FOUR:SCIENCE": "W.J",         // Wafula John Jackson
  "PRIMARY FOUR:SOCIAL STUDIES": "B.C",  // Bakyaire Charles
  "PRIMARY FOUR:RELIGIOUS EDUCATION": "NGS", // Not specified

  // PRIMARY FIVE - Multiple Teachers
  "PRIMARY FIVE:ENGLISH": "A.T",         // Awor Topista
  "PRIMARY FIVE:MATHEMATICS": "E.E",     // Ekaru Emmanuel
  "PRIMARY FIVE:SCIENCE": "W.J",         // Wafula John Jackson
  "PRIMARY FIVE:SOCIAL STUDIES": "E.A",  // Epenyu Abraham

  // PRIMARY SIX - Multiple Teachers
  "PRIMARY SIX:ENGLISH": "E.J",          // Emeru Joel
  "PRIMARY SIX:MATHEMATICS": "E.G",      // Egau Gerald
  "PRIMARY SIX:SCIENCE": "E.A",          // Epenyu Abraham
  "PRIMARY SIX:SOCIAL STUDIES": "B.C",   // Bakyaire Charles

  // PRIMARY SEVEN - Multiple Teachers
  "PRIMARY SEVEN:ENGLISH": "E.J",        // Emeru Joel
  "PRIMARY SEVEN:MATHEMATICS": "E.G",    // Egau Gerald
  "PRIMARY SEVEN:SCIENCE": "W.J",        // Wafula John Jackson
  "PRIMARY SEVEN:SOCIAL STUDIES": "E.A", // Epenyu Abraham
};

/**
 * Get teacher initials for a class and subject
 * Falls back to "NGS" (Northgate School) if mapping not found
 */
export function getTeacherInitials(className, subjectName) {
  // Normalize subject name to uppercase for consistent lookup
  const normalizedSubject = subjectName ? subjectName.toUpperCase().trim() : '';
  const key = `${className}:${normalizedSubject}`;
  return TEACHER_MAPPING[key] || "NGS";
}

/**
 * Subject Allocation Validation Library
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 *
 * Provides validation to ensure report subjects match class subject allocations.
 * Prevents invalid subjects (not allocated to the class) from appearing on reports.
 * Used by report generation, marks entry, and result validation systems.
 */

/**
 * Get all valid subject IDs allocated to a specific class
 * 
 * @param connection - Database connection
 * @param classId - Class ID
 * @returns Array of subject IDs allocated to this class
 */
export async function getValidSubjectsForClass(connection: any, classId: number): Promise<number[]> {
  try {
    const [rows]: any = await connection.execute(
      `SELECT DISTINCT cs.subject_id
       FROM class_subjects cs
       WHERE cs.class_id = ? AND cs.deleted_at IS NULL
       ORDER BY cs.subject_id`,
      [classId]
    );
    return rows.map((r: any) => r.subject_id);
  } catch (error) {
    console.error(`Error fetching valid subjects for class ${classId}:`, error);
    return [];
  }
}

/**
 * Get all valid subjects with details for a specific class
 * 
 * @param connection - Database connection
 * @param classId - Class ID
 * @returns Array of subject objects with ID, name, code
 */
export async function getValidSubjectDetailsForClass(connection: any, classId: number): Promise<any[]> {
  try {
    const [rows]: any = await connection.execute(
      `SELECT DISTINCT cs.subject_id, s.id, s.name, s.code, s.description, cs.custom_initials
       FROM class_subjects cs
       JOIN subjects s ON cs.subject_id = s.id
       WHERE cs.class_id = ? AND cs.deleted_at IS NULL AND s.deleted_at IS NULL
       ORDER BY s.name`,
      [classId]
    );
    return rows;
  } catch (error) {
    console.error(`Error fetching valid subject details for class ${classId}:`, error);
    return [];
  }
}

/**
 * Validate if a subject is allocated to a class
 * 
 * @param connection - Database connection
 * @param classId - Class ID
 * @param subjectId - Subject ID
 * @returns true if subject is allocated to the class, false otherwise
 */
export async function isSubjectAllocatedToClass(
  connection: any,
  classId: number,
  subjectId: number
): Promise<boolean> {
  try {
    const [rows]: any = await connection.execute(
      `SELECT cs.id
       FROM class_subjects cs
       WHERE cs.class_id = ? AND cs.subject_id = ? AND cs.deleted_at IS NULL
       LIMIT 1`,
      [classId, subjectId]
    );
    return rows.length > 0;
  } catch (error) {
    console.error(`Error validating subject allocation:`, error);
    return false;
  }
}

/**
 * Filter subject results to include only allocated subjects
 * 
 * @param connection - Database connection
 * @param classId - Class ID
 * @param subjectResults - Subject results to filter
 * @returns Filtered results containing only allocated subjects
 */
export async function filterToAllocatedSubjects(
  connection: any,
  classId: number,
  subjectResults: any[]
): Promise<any[]> {
  const validSubjectIds = await getValidSubjectsForClass(connection, classId);
  const validSet = new Set(validSubjectIds);
  
  const filtered = subjectResults.filter(sr => validSet.has(sr.subject_id));
  
  const excluded = subjectResults.filter(sr => !validSet.has(sr.subject_id));
  if (excluded.length > 0) {
    console.warn(
      `[Subject Allocation Warning] Class ${classId}: Filtered out ${excluded.length} non-allocated subject(s): ` +
      excluded.map(e => `Subject ID ${e.subject_id}`).join(', ')
    );
  }
  
  return filtered;
}

/**
 * Enforce subject allocation for a class
 * Throws error if invalid subjects exist in results
 * 
 * @param connection - Database connection
 * @param classId - Class ID
 * @param subjectIds - Subject IDs to validate
 * @throws Error if any subject is not allocated to the class
 */
export async function enforceSubjectAllocation(
  connection: any,
  classId: number,
  subjectIds: number[]
): Promise<void> {
  const validSubjectIds = await getValidSubjectsForClass(connection, classId);
  const validSet = new Set(validSubjectIds);
  
  const invalidSubjects = subjectIds.filter(id => !validSet.has(id));
  
  if (invalidSubjects.length > 0) {
    // Get subject names for better error message
    const [subjectNames]: any = await connection.execute(
      `SELECT id, name FROM subjects WHERE id IN (${invalidSubjects.join(',')})`,
      []
    );
    const names = subjectNames.map((s: any) => `${s.name} (ID: ${s.id})`).join(', ');
    
    throw new Error(
      `Subject Allocation Violation: The following subjects are not allocated to this class: ${names}. ` +
      `Only subjects in the class allocation can appear on reports.`
    );
  }
}

/**
 * Get a summary of subject allocations for a class
 * Useful for logging and debugging
 * 
 * @param connection - Database connection
 * @param classId - Class ID
 * @returns Object with allocation summary
 */
export async function getSubjectAllocationSummary(connection: any, classId: number): Promise<any> {
  try {
    const [classInfo]: any = await connection.execute(
      `SELECT c.id, c.name, c.school_id FROM classes c WHERE c.id = ? LIMIT 1`,
      [classId]
    );
    
    if (classInfo.length === 0) {
      throw new Error(`Class ${classId} not found`);
    }
    
    const subjects = await getValidSubjectDetailsForClass(connection, classId);
    
    return {
      class_id: classId,
      class_name: classInfo[0].name,
      school_id: classInfo[0].school_id,
      allocated_subject_count: subjects.length,
      subjects: subjects.map(s => ({
        id: s.id,
        name: s.name,
        code: s.code,
        custom_initials: s.custom_initials
      }))
    };
  } catch (error) {
    console.error(`Error getting subject allocation summary for class ${classId}:`, error);
    throw error;
  }
}

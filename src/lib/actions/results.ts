'use server'

import { revalidatePath } from 'next/cache';

export async function updateResultScore(
  resultId: number,
  newScore: number | null,
  grade?: string | null,
  remarks?: string | null
) {
  try {
    // Validate input
    if (newScore !== null && (isNaN(newScore) || newScore < 0 || newScore > 100)) {
      throw new Error('Score must be between 0 and 100');
    }

    // This would connect to your MySQL database using your preferred ORM/query builder
    // Example query: UPDATE class_results SET score = ?, grade = ?, remarks = ?, updated_at = NOW() WHERE id = ?
    
    console.log(`Updating result ${resultId} with score: ${newScore}, grade: ${grade}, remarks: ${remarks}`);
    
    // Simulate database update - replace with actual database call
    const updatedResult = {
      id: resultId,
      score: newScore,
      grade: grade || null,
      remarks: remarks || null,
      updated_at: new Date().toISOString()
    };

    // Log audit trail
    // INSERT INTO audit_log (actor_user_id, action, entity_type, entity_id, changes_json, ip, user_agent, created_at)
    // VALUES (?, 'edit_result', 'class_result', ?, ?, ?, ?, NOW())

    // Revalidate the page to refresh server-side data
    revalidatePath('/academics/results');
    
    return { success: true, data: updatedResult };
    
  } catch (error) {
    console.error('Server action error:', error);
    return { 
      success: false, 
      error: error instanceof Error ? error.message : 'Failed to update result' 
    };
  }
}

export async function fetchClassResults(filters: {
  class_id?: string;
  subject_id?: string;
  result_type_id?: string;
  term_id?: string;
}) {
  try {
    // This would fetch from your database
    // Example: SELECT cr.*, p.first_name, p.last_name, s.name as subject_name, c.name as class_name 
    // FROM class_results cr 
    // JOIN students st ON cr.student_id = st.id
    // JOIN people p ON st.person_id = p.id
    // JOIN subjects s ON cr.subject_id = s.id
    // JOIN classes c ON cr.class_id = c.id
    // WHERE ...filters
    
    console.log('Fetching results with filters:', filters);
    
    // Mock data - replace with actual database query
    const mockResults = [
      {
        id: 1,
        student_id: 1,
        student_name: 'John Doe',
        class_id: 1,
        class_name: 'Primary 1',
        subject_id: 1,
        subject_name: 'Mathematics',
        term_id: 1,
        result_type_id: 1,
        score: 85,
        grade: 'B',
        remarks: 'Good work'
      },
      // ... more results
    ];
    
    return { success: true, data: mockResults };
    
  } catch (error) {
    console.error('Error fetching results:', error);
    return { success: false, error: 'Failed to fetch results' };
  }
}

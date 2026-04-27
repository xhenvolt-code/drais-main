import { NextRequest } from 'next/server';
import { query, getConnection } from '@/lib/db';
import { getSessionSchoolId } from '@/lib/auth';
import { ok, fail } from '@/lib/apiResponse';

export async function GET(req: NextRequest) {
  const session = await getSessionSchoolId(req);
  if (!session) return fail('Not authenticated', 401);

  const classId = req.nextUrl.searchParams.get('classId');
  const subjectId = req.nextUrl.searchParams.get('subjectId');

  let whereClause = 'WHERE cs.school_id = ? AND cs.deleted_at IS NULL';
  const params: any[] = [session.schoolId];

  if (classId) {
    whereClause += ' AND cs.class_id = ?';
    params.push(parseInt(classId));
  }
  if (subjectId) {
    whereClause += ' AND cs.subject_id = ?';
    params.push(parseInt(subjectId));
  }

  const rows = await query(`
    SELECT 
      cs.id,
      cs.class_id,
      cs.subject_id,
      cs.teacher_id,
      cs.custom_initials,
      c.name AS class_name,
      sub.name AS subject_name,
      sub.code AS subject_code,
      COALESCE(
        cs.custom_initials,
        CONCAT(UPPER(LEFT(p.first_name, 1)), UPPER(LEFT(p.last_name, 1)))
      ) AS display_initials,
      p.first_name AS teacher_first_name,
      p.last_name AS teacher_last_name,
      CONCAT(p.first_name, ' ', p.last_name) AS teacher_full_name
    FROM class_subjects cs
    LEFT JOIN classes c ON cs.class_id = c.id
    LEFT JOIN subjects sub ON cs.subject_id = sub.id
    LEFT JOIN staff s ON cs.teacher_id = s.id
    LEFT JOIN people p ON s.person_id = p.id
    ${whereClause}
    ORDER BY c.name, sub.name
  `, params);

  return ok('Teacher initials fetched', rows);
}

export async function POST(req: NextRequest) {
  const session = await getSessionSchoolId(req);
  if (!session) return fail('Not authenticated', 401);

  const { classId, subjectId, initials } = await req.json();
  if (!classId || !subjectId || initials === undefined) {
    return fail('classId, subjectId, and initials are required');
  }

  // Validate initials format (optional - allow empty, max 10 chars)
  if (initials && (typeof initials !== 'string' || initials.length > 10)) {
    return fail('Initials must be a string with maximum 10 characters');
  }

  const conn = await getConnection();
  try {
    // Check if class_subject assignment exists
    const [existingAssignment] = await conn.execute(`
      SELECT id, custom_initials FROM class_subjects 
      WHERE school_id = ? AND class_id = ? AND subject_id = ? AND deleted_at IS NULL
    `, [session.schoolId, parseInt(classId), parseInt(subjectId)]) as any[];

    if (existingAssignment.length === 0) {
      return fail('Class-subject assignment not found', 404);
    }

    // Update custom initials
    await conn.execute(`
      UPDATE class_subjects 
      SET custom_initials = ?, updated_at = NOW() 
      WHERE id = ?
    `, [initials || null, existingAssignment[0].id]);

    // Get updated data for response
    const [updatedData] = await conn.execute(`
      SELECT 
        cs.id,
        cs.class_id,
        cs.subject_id,
        cs.custom_initials,
        c.name AS class_name,
        sub.name AS subject_name,
        COALESCE(
          cs.custom_initials,
          CONCAT(UPPER(LEFT(p.first_name, 1)), UPPER(LEFT(p.last_name, 1)))
        ) AS display_initials,
        p.first_name AS teacher_first_name,
        p.last_name AS teacher_last_name
      FROM class_subjects cs
      LEFT JOIN classes c ON cs.class_id = c.id
      LEFT JOIN subjects sub ON cs.subject_id = sub.id
      LEFT JOIN staff s ON cs.teacher_id = s.id
      LEFT JOIN people p ON s.person_id = p.id
      WHERE cs.id = ?
    `, [existingAssignment[0].id]);

    return ok('Initials updated successfully', updatedData[0]);
  } catch (error: any) {
    console.error('Error updating teacher initials:', error);
    return fail('Failed to update initials', 500);
  } finally {
    await conn.end();
  }
}

export async function PUT(req: NextRequest) {
  const session = await getSessionSchoolId(req);
  if (!session) return fail('Not authenticated', 401);

  const { classId, subjectId, initials } = await req.json();
  if (!classId || !subjectId || initials === undefined) {
    return fail('classId, subjectId, and initials are required');
  }

  // Validate initials format
  if (initials && (typeof initials !== 'string' || initials.length > 10)) {
    return fail('Initials must be a string with maximum 10 characters');
  }

  const conn = await getConnection();
  try {
    // Check if class_subject assignment exists
    const [existingAssignment] = await conn.execute(`
      SELECT id FROM class_subjects 
      WHERE school_id = ? AND class_id = ? AND subject_id = ? AND deleted_at IS NULL
    `, [session.schoolId, parseInt(classId), parseInt(subjectId)]) as any[];

    if (existingAssignment.length === 0) {
      return fail('Class-subject assignment not found', 404);
    }

    // Update or clear custom initials
    await conn.execute(`
      UPDATE class_subjects 
      SET custom_initials = ?, updated_at = NOW() 
      WHERE id = ?
    `, [initials || null, existingAssignment[0].id]);

    return ok('Initials updated successfully');
  } catch (error: any) {
    console.error('Error updating teacher initials:', error);
    return fail('Failed to update initials', 500);
  } finally {
    await conn.end();
  }
}

export async function DELETE(req: NextRequest) {
  const session = await getSessionSchoolId(req);
  if (!session) return fail('Not authenticated', 401);

  const { classId, subjectId } = await req.json();
  if (!classId || !subjectId) {
    return fail('classId and subjectId are required');
  }

  const conn = await getConnection();
  try {
    // Clear custom initials (revert to auto-generated)
    const [result] = await conn.execute(`
      UPDATE class_subjects 
      SET custom_initials = NULL, updated_at = NOW() 
      WHERE school_id = ? AND class_id = ? AND subject_id = ? AND deleted_at IS NULL
    `, [session.schoolId, parseInt(classId), parseInt(subjectId)]) as any[];

    if (result.affectedRows === 0) {
      return fail('Class-subject assignment not found', 404);
    }

    return ok('Custom initials cleared, reverted to auto-generated');
  } catch (error: any) {
    console.error('Error clearing teacher initials:', error);
    return fail('Failed to clear initials', 500);
  } finally {
    await conn.end();
  }
}

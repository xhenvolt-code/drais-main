/**
 * API Route: GET /api/class-initials
 * Retrieves editable initials for a class
 */

import { NextRequest, NextResponse } from 'next/server';
import { getSessionSchoolId } from '@/lib/auth';
import { getClassInitials } from '@/lib/editable-initials';

export async function GET(req: NextRequest) {
  try {
    const session = await getSessionSchoolId(req);
    if (!session) {
      return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
    }

    const { searchParams } = new URL(req.url);
    const classId = searchParams.get('classId');

    if (!classId) {
      return NextResponse.json(
        { error: 'classId is required' },
        { status: 400 }
      );
    }

    const initialsMap = await getClassInitials(parseInt(classId), session.schoolId);
    
    // Convert map to array for JSON serialization
    const initials = Array.from(initialsMap.entries()).map(([subjectId, config]) => ({
      subjectId,
      ...config
    }));

    return NextResponse.json({
      success: true,
      initials
    });
  } catch (error: any) {
    console.error('Error fetching class initials:', error);
    return NextResponse.json(
      { error: error.message || 'Failed to fetch class initials' },
      { status: 500 }
    );
  }
}

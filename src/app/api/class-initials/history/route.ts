/**
 * API Route: GET /api/class-initials/history
 * Retrieves edit history for initials in a class
 */

import { NextRequest, NextResponse } from 'next/server';
import { getSessionSchoolId } from '@/lib/auth';
import { getInitialsHistory } from '@/lib/editable-initials';

export async function GET(req: NextRequest) {
  try {
    const session = await getSessionSchoolId(req);
    if (!session) {
      return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
    }

    const { searchParams } = new URL(req.url);
    const classId = searchParams.get('classId');
    const limit = parseInt(searchParams.get('limit') || '50', 10);

    if (!classId) {
      return NextResponse.json(
        { error: 'classId is required' },
        { status: 400 }
      );
    }

    if (limit < 1 || limit > 500) {
      return NextResponse.json(
        { error: 'Limit must be between 1 and 500' },
        { status: 400 }
      );
    }

    const history = await getInitialsHistory(parseInt(classId), limit);

    return NextResponse.json({
      success: true,
      history
    });
  } catch (error: any) {
    console.error('Error fetching initials history:', error);
    return NextResponse.json(
      { error: error.message || 'Failed to fetch initials history' },
      { status: 500 }
    );
  }
}

/**
 * API Route: GET /api/marks-migration/history
 * Retrieves migration audit trail
 */

import { NextRequest, NextResponse } from 'next/server';
import { getSessionSchoolId } from '@/lib/auth';
import { getMigrationHistory } from '@/lib/marks-migration';

export async function GET(req: NextRequest) {
  try {
    const session = await getSessionSchoolId(req);
    if (!session) {
      return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
    }

    const { searchParams } = new URL(req.url);
    const limit = parseInt(searchParams.get('limit') || '50', 10);

    if (limit < 1 || limit > 500) {
      return NextResponse.json(
        { error: 'Limit must be between 1 and 500' },
        { status: 400 }
      );
    }

    // Get migration history
    const history = await getMigrationHistory(session.schoolId, limit);

    return NextResponse.json({
      success: true,
      history
    });
  } catch (error: any) {
    console.error('Error fetching migration history:', error);
    return NextResponse.json(
      { error: error.message || 'Failed to fetch migration history' },
      { status: 500 }
    );
  }
}

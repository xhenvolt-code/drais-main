/**
 * API Route: POST /api/marks-migration/rollback
 * Rolls back a previously executed migration
 */

import { NextRequest, NextResponse } from 'next/server';
import { getSessionSchoolId } from '@/lib/auth';
import { rollbackMigration } from '@/lib/marks-migration';

export async function POST(req: NextRequest) {
  try {
    const session = await getSessionSchoolId(req);
    if (!session) {
      return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
    }

    const body = await req.json();
    const { migrationId } = body;

    if (!migrationId) {
      return NextResponse.json(
        { error: 'Migration ID is required' },
        { status: 400 }
      );
    }

    // Execute rollback
    const result = await rollbackMigration(migrationId, session.userId);

    return NextResponse.json({
      success: true,
      rollback: result
    });
  } catch (error: any) {
    console.error('Error rolling back migration:', error);
    return NextResponse.json(
      { error: error.message || 'Failed to rollback migration' },
      { status: 500 }
    );
  }
}

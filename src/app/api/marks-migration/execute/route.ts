/**
 * API Route: POST /api/marks-migration/execute
 * Executes the migration with transaction safety and audit logging
 */

import { NextRequest, NextResponse } from 'next/server';
import { getSessionSchoolId } from '@/lib/auth';
import { executeMigration } from '@/lib/marks-migration';

export async function POST(req: NextRequest) {
  try {
    const session = await getSessionSchoolId(req);
    if (!session) {
      return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
    }

    const body = await req.json();
    const {
      classId,
      academicYearId,
      termId,
      sourceSubjectId,
      destinationSubjectId,
      resultTypeId,
      conflictResolution,
      reason
    } = body;

    // Validation
    if (!classId || !academicYearId || !termId || !sourceSubjectId || !destinationSubjectId || !resultTypeId) {
      return NextResponse.json(
        { error: 'Missing required parameters' },
        { status: 400 }
      );
    }

    if (!['overwrite', 'skip', 'merge'].includes(conflictResolution)) {
      return NextResponse.json(
        { error: 'Invalid conflict resolution strategy' },
        { status: 400 }
      );
    }

    // Execute migration
    const result = await executeMigration({
      schoolId: session.schoolId,
      classId,
      academicYearId,
      termId,
      sourceSubjectId,
      destinationSubjectId,
      resultTypeId,
      conflictResolution,
      confirmedBy: session.userId,
      reason
    });

    return NextResponse.json({
      success: true,
      migration: result
    });
  } catch (error: any) {
    console.error('Error executing migration:', error);
    return NextResponse.json(
      { error: error.message || 'Failed to execute migration' },
      { status: 500 }
    );
  }
}

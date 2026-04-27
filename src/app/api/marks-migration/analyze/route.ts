/**
 * API Route: POST /api/marks-migration/analyze
 * Analyzes potential migration impact before execution
 */

import { NextRequest, NextResponse } from 'next/server';
import { getSessionSchoolId } from '@/lib/auth';
import { analyzeMigration } from '@/lib/marks-migration';

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
      resultTypeId
    } = body;

    // Validation
    if (!classId || !academicYearId || !termId || !sourceSubjectId || !destinationSubjectId || !resultTypeId) {
      return NextResponse.json(
        { error: 'Missing required parameters' },
        { status: 400 }
      );
    }

    if (sourceSubjectId === destinationSubjectId) {
      return NextResponse.json(
        { error: 'Source and destination subjects must be different' },
        { status: 400 }
      );
    }

    // Perform analysis
    const analysis = await analyzeMigration({
      schoolId: session.schoolId,
      classId,
      academicYearId,
      termId,
      sourceSubjectId,
      destinationSubjectId,
      resultTypeId
    });

    return NextResponse.json({
      success: true,
      analysis
    });
  } catch (error: any) {
    console.error('Error analyzing migration:', error);
    return NextResponse.json(
      { error: error.message || 'Failed to analyze migration' },
      { status: 500 }
    );
  }
}

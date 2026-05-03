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
      sourceClassId,
      sourceAcademicYearId,
      sourceTermId,
      sourceSubjectId,
      sourceResultTypeId,
      destinationClassId,
      destinationAcademicYearId,
      destinationTermId,
      destinationSubjectId,
      destinationResultTypeId
    } = body;

    // Validation
    if (
      !sourceClassId ||
      !sourceAcademicYearId ||
      !sourceTermId ||
      !sourceSubjectId ||
      !sourceResultTypeId ||
      !destinationClassId ||
      !destinationAcademicYearId ||
      !destinationTermId ||
      !destinationSubjectId ||
      !destinationResultTypeId
    ) {
      return NextResponse.json(
        { error: 'Missing required parameters' },
        { status: 400 }
      );
    }

    if (
      sourceClassId === destinationClassId &&
      sourceAcademicYearId === destinationAcademicYearId &&
      sourceTermId === destinationTermId &&
      sourceSubjectId === destinationSubjectId &&
      sourceResultTypeId === destinationResultTypeId
    ) {
      return NextResponse.json(
        { error: 'Source and destination cannot be identical' },
        { status: 400 }
      );
    }

    // Perform analysis
    const analysis = await analyzeMigration({
      schoolId: session.schoolId,
      sourceClassId,
      sourceAcademicYearId,
      sourceTermId,
      sourceSubjectId,
      sourceResultTypeId,
      destinationClassId,
      destinationAcademicYearId,
      destinationTermId,
      destinationSubjectId,
      destinationResultTypeId
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

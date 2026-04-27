/**
 * API Route: PUT /api/class-initials
 * Updates editable initials for a subject in a class
 * Single edit syncs to entire class
 */

import { NextRequest, NextResponse } from 'next/server';
import { getSessionSchoolId } from '@/lib/auth';
import { updateInitials, bulkUpdateInitials } from '@/lib/editable-initials';

export async function PUT(req: NextRequest) {
  try {
    const session = await getSessionSchoolId(req);
    if (!session) {
      return NextResponse.json({ error: 'Not authenticated' }, { status: 401 });
    }

    const body = await req.json();
    const { classId, subjectId, initials, bulkUpdates } = body;

    if (bulkUpdates) {
      // Bulk update mode
      if (!Array.isArray(bulkUpdates)) {
        return NextResponse.json(
          { error: 'bulkUpdates must be an array' },
          { status: 400 }
        );
      }

      if (!classId) {
        return NextResponse.json(
          { error: 'classId is required for bulk updates' },
          { status: 400 }
        );
      }

      const result = await bulkUpdateInitials(
        session.schoolId,
        parseInt(classId),
        bulkUpdates.map((u: any) => ({
          subjectId: parseInt(u.subjectId),
          initials: u.initials
        })),
        session.userId
      );

      return NextResponse.json({
        success: true,
        result
      });
    } else {
      // Single update mode
      if (!classId || !subjectId || !initials) {
        return NextResponse.json(
          { error: 'classId, subjectId, and initials are required' },
          { status: 400 }
        );
      }

      const result = await updateInitials({
        schoolId: session.schoolId,
        classId: parseInt(classId),
        subjectId: parseInt(subjectId),
        newInitials: initials,
        updatedBy: session.userId
      });

      return NextResponse.json({
        success: true,
        result
      });
    }
  } catch (error: any) {
    console.error('Error updating initials:', error);
    return NextResponse.json(
      { error: error.message || 'Failed to update initials' },
      { status: 500 }
    );
  }
}

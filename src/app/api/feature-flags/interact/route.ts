import { NextRequest, NextResponse } from 'next/server';
import { getConnection } from '@/lib/db';

export async function POST(req: NextRequest) {
  let connection;
  
  try {
    const body = await req.json();
    const { user_id = 1, feature_flag_id, interaction_type } = body;

    if (!feature_flag_id || !interaction_type) {
      return NextResponse.json({
        success: false,
        error: 'Feature flag ID and interaction type are required'
      }, { status: 400 });
    }

    connection = await getConnection();

    // Record the interaction
    await connection.execute(`
      INSERT INTO user_feature_interactions (user_id, feature_flag_id, interaction_type)
      VALUES (?, ?, ?)
    `, [user_id, feature_flag_id, interaction_type]);

    // If user clicked the feature, mark it as seen for them
    if (interaction_type === 'clicked') {
      // This could be used for personalized "new" badge hiding logic
    }

    return NextResponse.json({
      success: true,
      message: 'Interaction recorded'
    });

  } catch (error: any) {
    console.error('Feature interaction error:', error);
    return NextResponse.json({
      success: false,
      error: 'Failed to record interaction'
    }, { status: 500 });
  } finally {
    if (connection) await connection.end();
  }
}

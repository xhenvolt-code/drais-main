// Template for creating new API routes in DRAIS
// Always add this line first for routes that use Node.js modules
export const runtime = "nodejs";

import { NextRequest, NextResponse } from 'next/server';
import { getConnection } from '@/lib/db';

// Example API route structure
export async function GET(req: NextRequest) {
  let connection;
  
  try {
    // Get query parameters
    const { searchParams } = new URL(req.url);
    const schoolId = parseInt(searchParams.get('school_id') || '1');

    // Get database connection
    connection = await getConnection();

    // Your database operations here
    const [results] = await connection.execute('SELECT * FROM your_table WHERE school_id = ?', [schoolId]);

    return NextResponse.json({
      success: true,
      data: results
    });

  } catch (error: any) {
    console.error('API error:', error);
    return NextResponse.json({
      success: false,
      error: 'Operation failed'
    }, { status: 500 });
  } finally {
    if (connection) await connection.end();
  }
}

export async function POST(req: NextRequest) {
  // ...existing code...
}
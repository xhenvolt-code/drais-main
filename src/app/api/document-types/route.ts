import { NextRequest, NextResponse } from 'next/server';
import { getConnection } from '@/lib/db';

export async function GET(req: NextRequest) {
  let connection;
  
  try {
    connection = await getConnection();

    const [documentTypes] = await connection.execute(`
      SELECT id, code, label 
      FROM document_types 
      ORDER BY label
    `);

    return NextResponse.json({
      success: true,
      data: documentTypes
    });

  } catch (error: any) {
    console.error('Document types fetch error:', error);
    return NextResponse.json({
      success: false,
      error: 'Failed to fetch document types'
    }, { status: 500 });
  } finally {
    if (connection) await connection.end();
  }
}

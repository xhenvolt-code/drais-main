import { NextRequest, NextResponse } from 'next/server';

export async function GET(req: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  return NextResponse.json({ 
    success: false, 
    error: 'This endpoint is not yet implemented' 
  }, { status: 501 });
}

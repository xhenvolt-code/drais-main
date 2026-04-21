import { NextRequest, NextResponse } from 'next/server';

export async function PUT(req: NextRequest) {
  return NextResponse.json({ 
    success: false, 
    error: 'This endpoint is not yet implemented' 
  }, { status: 501 });
}

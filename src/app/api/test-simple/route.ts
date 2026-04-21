import { NextResponse } from 'next/server';

export async function GET() {
  try {
    // Test basic response
    return NextResponse.json({ 
      status: 'ok',
      message: 'API is working'
    });
  } catch (error: any) {
    return NextResponse.json({ 
      error: error.message 
    }, { status: 500 });
  }
}

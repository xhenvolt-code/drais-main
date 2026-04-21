import { NextRequest, NextResponse } from 'next/server';
import QRCode from 'qrcode';

export async function GET(req: NextRequest) {
  const searchParams = req.nextUrl.searchParams;
  const data = searchParams.get('data');

  if (!data) {
    return new NextResponse('Missing data parameter', { status: 400 });
  }

  try {
    const qrDataUrl = await QRCode.toDataURL(data, {
      errorCorrectionLevel: 'H',
      margin: 1,
      width: 90,
      color: {
        dark: '#000000',
        light: '#ffffff',
      },
    });

    return new NextResponse(qrDataUrl.split(',')[1], {
      headers: {
        'Content-Type': 'image/png',
        'Content-Disposition': 'inline',
      },
    });
  } catch (error) {
    return new NextResponse('Error generating barcode', { status: 500 });
  }
}

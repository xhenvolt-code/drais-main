import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

/**
 * Proxy route for frontend to communicate with PHP API backend.
 * Forwards method, query string and body. Does not mutate responses headers beyond essential ones.
 * Environment:
 *   NEXT_PUBLIC_PHP_API_BASE (recommended) -> e.g. http://localhost/drais/api
 *
 * Note: This is a simple proxy. In production you may add authentication, rate-limiting,
 * caching, response sanitization, and stricter header handling.
 */

export async function GET(req: NextRequest, { params }: { params: Promise<{ path: string[] }> }) {
  return proxy(req, await params);
}
export async function POST(req: NextRequest, { params }: { params: Promise<{ path: string[] }> }) {
  return proxy(req, await params);
}
export async function PUT(req: NextRequest, { params }: { params: Promise<{ path: string[] }> }) {
  return proxy(req, await params);
}
export async function DELETE(req: NextRequest, { params }: { params: Promise<{ path: string[] }> }) {
  return proxy(req, await params);
}
export async function PATCH(req: NextRequest, { params }: { params: Promise<{ path: string[] }> }) {
  return proxy(req, await params);
}

async function proxy(req: NextRequest, { path }: { path: string[] }) {
  try {
    const phpBase = process.env.NEXT_PUBLIC_PHP_API_BASE || 'http://localhost/drais/api';
    const relPath = (path || []).join('/');
    const url = new URL(`${phpBase.replace(/\/+$/,'')}/${relPath}`);

    // Forward query params
    const incomingUrl = new URL(req.url);
    incomingUrl.searchParams.forEach((v, k) => url.searchParams.set(k, v));

    // Forward body for non-GET
    const method = req.method || 'GET';
    const init: RequestInit = {
      method,
      headers: {},
    };

    // Copy content-type and other safe headers
    const allowedForwardHeaders = ['content-type', 'authorization', 'x-api-key'];
    for (const [k, v] of req.headers) {
      if (allowedForwardHeaders.includes(k.toLowerCase())) {
        (init.headers as Record<string,string>)[k] = v;
      }
    }

    if (method !== 'GET' && method !== 'HEAD') {
      try {
        const body = await req.arrayBuffer();
        init.body = body.byteLength ? body : undefined;
      } catch {
        // ignore
      }
    }

    // Fetch backend
    const resp = await fetch(url.toString(), init);

    // Build response with same status and JSON/text body forwarded
    const contentType = resp.headers.get('content-type') || '';
    const responseBody = contentType.includes('application/json') ? await resp.json().catch(() => null) : await resp.text().catch(() => null);
    const headers: Record<string,string> = {};
    // forward certain headers
    const forwardHeaders = ['content-type', 'content-disposition'];
    forwardHeaders.forEach(h => {
      const val = resp.headers.get(h);
      if (val) headers[h] = val;
    });

    return NextResponse.json(responseBody ?? {}, { status: resp.status, headers });
  } catch (err: any) {
    console.error('Proxy error:', err);
    return NextResponse.json({ error: err?.message || 'Proxy error' }, { status: 502 });
  }
}

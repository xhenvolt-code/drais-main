/**
 * Utility to check if we're running in Node.js or Edge runtime
 */
export function isNodeRuntime(): boolean {
  return typeof process !== 'undefined' && process.versions && process.versions.node;
}

export function isEdgeRuntime(): boolean {
  return typeof EdgeRuntime !== 'undefined';
}

/**
 * Throw an error if trying to use Node.js modules in Edge runtime
 */
export function requireNodeRuntime(functionName: string): void {
  if (!isNodeRuntime()) {
    throw new Error(`${functionName} requires Node.js runtime. Add 'export const runtime = "nodejs";' to your API route.`);
  }
}

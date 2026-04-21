// Lightweight translation helper
// Injected dictionary via window.__I18N__ in layout.
export function t(key: string, fallback?: string): string {
  if (typeof window !== 'undefined' && (window as any).__I18N__) {
    return (window as any).__I18N__[key] ?? fallback ?? key;
  }
  return fallback ?? key;
}

export function currentLocale(): string {
  if (typeof window !== 'undefined') return (window as any).__LOCALE__ || 'en';
  return 'en';
}

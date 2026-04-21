import { cookies } from 'next/headers';

export async function loadDictionary() {
  const cookieStore = await cookies();
  const lang = cookieStore.get('lang')?.value;
  const locale = (lang && ['en','ar'].includes(lang)) ? lang : 'en';
  const dict = await import(`../locales/${locale}.json`).then(m=>m.default).catch(()=>({}));
  return { locale, dict } as { locale: string; dict: Record<string,string> };
}

export function tServer(dict: Record<string,string>, key: string, fallback?: string){
  return dict[key] ?? fallback ?? key;
}

"use client";
import React from 'react';
import Link from 'next/link';
import useSWR from 'swr';
import { TermProgress } from './TermProgress';
import { TermReports } from './TermReports';
import { TermRequirementsManager } from './TermRequirementsManager';
import { t } from '@/lib/i18n';

const API_BASE = process.env.NEXT_PUBLIC_PHP_API_BASE || 'http://localhost/drais/api';
const fetcher=(u:string)=>fetch(u).then(r=>r.json());

export default function TermDetail({ id }: { id:string }){
  const { data } = useSWR(`${API_BASE}/term_item.php?id=${id}`, fetcher);
  if(!data) return <div className="text-sm text-gray-500">{t('terms.loading','Loading term...')}</div>;
  return (
    <div className="rounded-2xl border border-blue-200 dark:border-indigo-700 bg-gradient-to-br from-white/80 via-blue-50/60 to-pink-50/60 dark:from-slate-900/80 dark:via-indigo-900/60 dark:to-purple-900/60 shadow-2xl p-8 mx-20">
      <div className="flex items-center justify-between mb-4">
        <div>
          <h1 className="text-2xl font-semibold text-indigo-700 dark:text-pink-300">{data.name}</h1>
          <p className="text-xs text-gray-500">{t('terms.dates','Dates')}: {data.start_date||'-'} → {data.end_date||'-'}</p>
        </div>
        <Link href="/terms/list" className="text-xs text-[var(--color-primary)] font-medium">{t('common.back_to_list','Back to list')}</Link>
      </div>
      <div className="grid md:grid-cols-3 gap-6 text-sm">
        <div className="p-5 rounded-xl border bg-white/60 dark:bg-slate-900/60 backdrop-blur border-white/30 dark:border-white/10 md:col-span-1">
          <b>{t('terms.progress', 'Term Progress')}</b>
          <TermProgress termId={parseInt(id,10)} />
        </div>
        <div className="p-5 rounded-xl border bg-white/60 dark:bg-slate-900/60 backdrop-blur border-white/30 dark:border-white/10 md:col-span-1">
          <b>{t('terms.reports', 'Term Reports')}</b>
          <TermReports termId={parseInt(id,10)} />
        </div>
        <div className="p-5 rounded-xl border bg-white/60 dark:bg-slate-900/60 backdrop-blur border-white/30 dark:border-white/10 md:col-span-1">
          <b>{t('terms.requirements', 'Term Requirements')}</b>
          <TermRequirementsManager termId={parseInt(id,10)} />
        </div>
      </div>
    </div>
  );
}

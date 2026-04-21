"use client";
import React, { useState } from 'react';
import useSWR from 'swr';
import { Plus, Loader2 } from 'lucide-react';
import { useRouter } from 'next/navigation';
import { TermWizard } from './TermWizard';
import { t } from '@/lib/i18n';

const API_BASE = '/api';
const fetcher=(u:string)=>fetch(u).then(r=>r.json());

export default function TermTable(){
  const { data, isLoading, mutate } = useSWR(`${API_BASE}/terms`, fetcher);
  const rows = data?.data||[];
  const [open,setOpen]=useState(false);
  const router=useRouter();
  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-xl font-semibold">{t('terms.title','Terms')}</h1>
        <button onClick={()=>setOpen(true)} className="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-[var(--color-primary)] text-white text-sm"><Plus className="w-4 h-4" /> {t('terms.add','Add Term')}</button>
      </div>
      <div className="rounded-2xl overflow-hidden border border-blue-200 dark:border-indigo-700 backdrop-blur bg-gradient-to-br from-white/80 via-blue-50/60 to-pink-50/60 dark:from-slate-900/80 dark:via-indigo-900/60 dark:to-purple-900/60 shadow-2xl mx-20">
        <table className="w-full text-sm">
          <caption className="text-left px-4 py-2 text-xs text-blue-500 font-semibold bg-gradient-to-r from-blue-100 via-white to-pink-100 dark:from-slate-800 dark:via-slate-900 dark:to-indigo-900 rounded-t-xl">{t('terms.title','Terms')}</caption>
          <thead className="text-left bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500 text-white">
            <tr>
              <th className="px-4 py-2 font-semibold">{t('terms.name','Name')}</th>
              <th className="px-4 py-2 font-semibold">{t('terms.start','Start Date')}</th>
              <th className="px-4 py-2 font-semibold">{t('terms.end','End Date')}</th>
              <th className="px-4 py-2 font-semibold">{t('terms.status','Status')}</th>
            </tr>
          </thead>
          <tbody>
            {isLoading && (
              <tr><td colSpan={4} className="px-4 py-8 text-center text-blue-500"><Loader2 className="w-5 h-5 animate-spin mx-auto mb-2" /> {t('common.loading','Loading...')}</td></tr>
            )}
            {!isLoading && rows.length===0 && (
              <tr><td colSpan={4} className="px-4 py-8 text-center text-blue-400">{t('terms.none','No terms found.')}</td></tr>
            )}
            {rows.map((r:any)=>(
              <tr key={r.id} onClick={()=>router.push(`/terms/${r.id}`)} className="cursor-pointer hover:bg-gradient-to-r hover:from-blue-100 hover:via-pink-100 hover:to-indigo-100 dark:hover:from-indigo-900 dark:hover:via-purple-900 dark:hover:to-pink-900 transition-colors">
                <td className="px-4 py-2 font-semibold text-indigo-700 dark:text-pink-300">{r.name}</td>
                <td className="px-4 py-2 text-xs">{r.start_date||''}</td>
                <td className="px-4 py-2 text-xs">{r.end_date||''}</td>
                <td className="px-4 py-2">
                  <span className={`px-2 py-0.5 rounded-xl text-xs font-bold shadow ${r.status==='scheduled'?'bg-gradient-to-r from-green-400 to-blue-400 text-white':'bg-gradient-to-r from-gray-400 to-gray-700 text-gray-100'}`}>{t(`status.${r.status}`, r.status)}</span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <TermWizard open={open} onClose={()=>setOpen(false)} onCreated={()=>{ setOpen(false); mutate(); }} />
    </div>
  );
}

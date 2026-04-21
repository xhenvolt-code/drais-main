"use client";
import React,{useState} from 'react';
import useSWR from 'swr';
import { t } from '@/lib/i18n';
const API_BASE=process.env.NEXT_PUBLIC_PHP_API_BASE||'http://localhost/drais/api';
const fetcher=(u:string)=>fetch(u).then(r=>r.json());
export const EventsManager: React.FC=()=>{
  const {data,mutate}=useSWR(`${API_BASE}/events.php`,fetcher); const rows=data?.data||[];
  const [form,setForm]=useState({ title:'', start_datetime:'', end_datetime:'', location:'' });
  const add=async()=>{ if(!form.title) return; await fetch(`${API_BASE}/events.php`,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({ title:form.title, start_datetime: form.start_datetime||undefined, end_datetime: form.end_datetime||undefined, location: form.location||undefined })}); setForm({ title:'', start_datetime:'', end_datetime:'', location:''}); mutate(); };
  return <div className="space-y-4"> <h2 className="font-semibold text-sm">{t('general.events','Events')}</h2>
    <div className="grid md:grid-cols-6 gap-2 text-xs"> <input placeholder={t('general.title','Title')} value={form.title} onChange={e=>setForm({...form,title:e.target.value})} className="px-2 py-1 rounded border" /> <input type="datetime-local" value={form.start_datetime} onChange={e=>setForm({...form,start_datetime:e.target.value})} className="px-2 py-1 rounded border" /> <input type="datetime-local" value={form.end_datetime} onChange={e=>setForm({...form,end_datetime:e.target.value})} className="px-2 py-1 rounded border" /> <input placeholder={t('general.location','Location')} value={form.location} onChange={e=>setForm({...form,location:e.target.value})} className="px-2 py-1 rounded border" /> <button onClick={add} disabled={!form.title} className="px-2 py-1 rounded bg-[var(--color-primary)] text-white disabled:opacity-40">{t('common.add','Add')}</button> </div>
    <div className="rounded border divide-y bg-white/40 dark:bg-slate-800/40 text-xs"> {rows.map((r:any)=>(<div key={r.id} className="grid md:grid-cols-6 gap-2 px-3 py-2"><span className="col-span-2 truncate">{r.title}</span><span>{r.start_datetime||'-'}</span><span>{r.end_datetime||'-'}</span><span>{r.location||'-'}</span><span className="text-[10px]">{r.id}</span></div>))} {rows.length===0 && <div className="px-3 py-6 text-center text-gray-400">{t('general.no_events','No events')}</div>} </div>
  </div>;
};
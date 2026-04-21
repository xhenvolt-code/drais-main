"use client";
import React, { useState, useEffect, useRef } from 'react';
import { useTheme } from "@/components/theme/ThemeProvider";
import { motion, AnimatePresence } from "framer-motion";
import { SlidersHorizontal } from "lucide-react";
import clsx from "clsx";
import { useThemeStore } from "@/hooks/useThemeStore";
import { useI18n } from "@/components/i18n/I18nProvider";
import { Move } from "lucide-react";
import { X } from "lucide-react";

const palette = ["#2563eb", "#7c3aed", "#db2777", "#dc2626", "#ea580c", "#16a34a", "#0891b2", "#4f46e5"];

export const ThemeCustomizerPanel: React.FC = () => {
  const theme = useTheme();
  const store = useThemeStore();
  const { t: translate, lang } = useI18n();
  const [open, setOpen] = useState(false);

  const fontFamilies = [
    'Inter, system-ui, Segoe UI, Arial, sans-serif',
    'Segoe UI, Inter, Arial, sans-serif',
    'Calibri, Segoe UI, Arial, sans-serif',
    'Cambria, Georgia, serif',
    'Georgia, Cambria, serif',
    'Times New Roman, Times, serif',
    'Arial, Helvetica, sans-serif',
    'Tahoma, Segoe UI, sans-serif',
    'Verdana, Segoe UI, sans-serif'
  ];

  const launcherRef = useRef<HTMLButtonElement|null>(null);
  const panelRef = useRef<HTMLDivElement|null>(null);
  const customizerPlacement = store.customizerPlacement;
  const customizerOpen = store.customizerOpen;

  useEffect(()=>{ setOpen(!!customizerOpen); }, [customizerOpen]);

  const startDrag = (e: React.MouseEvent) => {
    if (customizerPlacement !== 'float') return;
    const startX = e.clientX; const startY = e.clientY;
    const initX = store.customizerPosX || 0; const initY = store.customizerPosY || 0;
    const onMove = (ev: MouseEvent) => {
      store.setCustomizerPosition?.(initX + (ev.clientX - startX), initY + (ev.clientY - startY));
    };
    const onUp = () => { window.removeEventListener('mousemove', onMove); window.removeEventListener('mouseup', onUp); };
    window.addEventListener('mousemove', onMove); window.addEventListener('mouseup', onUp);
  };

  useEffect(()=>{
    const handleDown = (e: MouseEvent) => {
      if(!open) return;
      const target = e.target as Node;
      if(panelRef.current && panelRef.current.contains(target)) return;
      if(launcherRef.current && launcherRef.current.contains(target)) return;
      // Close if open
      if(store.customizerOpen) store.toggleCustomizer?.();
    };
    document.addEventListener('mousedown', handleDown);
    return ()=> document.removeEventListener('mousedown', handleDown);
  },[open, store.customizerOpen]);

  return (
    <div className={clsx("fixed z-50", customizerPlacement==='float' && 'bottom-20 right-4', customizerPlacement==='navbar' && 'top-2 right-20', customizerPlacement==='sidebar' && (lang==='ar'? 'top-20 right-20':'top-20 left-20'))} style={customizerPlacement==='float'?{ transform:`translate(${store.customizerPosX}px,${store.customizerPosY}px)` }:undefined}>
      {customizerPlacement==='float' && (
        <button ref={launcherRef} onMouseDown={startDrag} onClick={()=>store.toggleCustomizer?.()} className="p-3 rounded-full shadow-xl bg-[var(--color-primary)] text-white hover:scale-110 transition active:scale-95 flex items-center gap-1">
          <SlidersHorizontal className="w-5 h-5" />
          <Move className="w-3 h-3 opacity-70" />
        </button>
      )}
      {customizerPlacement!=='float' && (
        <button onClick={()=>store.toggleCustomizer?.()} className="p-2 rounded-md bg-[var(--color-primary)] text-white text-xs font-semibold shadow flex items-center gap-1"> <SlidersHorizontal className="w-4 h-4"/> {translate('theme.panel')} </button>
      )}
      <AnimatePresence>
        {open && (
          <motion.div ref={panelRef} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: 10 }} className={clsx("relative mt-3 w-80 rounded-2xl p-5 backdrop-blur-xl border shadow-2xl", theme.glass ? "bg-white/60 dark:bg-slate-900/60 border-white/30 dark:border-white/10" : "bg-white dark:bg-slate-900 border-gray-200 dark:border-gray-800")}>
            <button aria-label="Close" onClick={()=>store.toggleCustomizer?.()} className="absolute top-2 right-2 p-1 rounded-md hover:bg-black/5 dark:hover:bg-white/10"><X className="w-4 h-4"/></button>
            <h4 className="font-semibold mb-4 text-sm">{translate('theme.panel')}</h4>
            <div className="space-y-5 max-h-[70vh] overflow-y-auto pr-1 custom-scroll">
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">Customizer Placement</p>
                <div className="flex gap-2 flex-wrap">
                  {(['float','navbar','sidebar'] as const).map(p => (
                    <button key={p} onClick={()=>store.setCustomizerPlacement?.(p)} className={clsx("px-3 py-1 rounded-md text-xs font-medium border capitalize", store.customizerPlacement===p?"bg-[var(--color-primary)] text-white border-[var(--color-primary)]":"bg-white/40 dark:bg-slate-800/40 border-gray-300 dark:border-gray-700")}>{p}</button>
                  ))}
                </div>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">{translate('theme.mode')}</p>
                <div className="flex gap-2">
                  {(["light","dark"] as const).map(m => (
                    <button key={m} onClick={() => theme.setMode(m)} className={clsx("px-3 py-1 rounded-md text-xs font-medium border capitalize", theme.mode===m?"bg-[var(--color-primary)] text-white border-[var(--color-primary)]":"bg-white/40 dark:bg-slate-800/40 border-gray-300 dark:border-gray-700")}>{m}</button>
                  ))}
                </div>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">{translate('theme.primaryColor')}</p>
                <div className="grid grid-cols-8 gap-2">
                  {palette.map(c => (
                    <button key={c} onClick={() => theme.setPrimary(c)} style={{ background: c }} className={clsx("h-7 rounded-md border", theme.primary===c?"ring-2 ring-offset-1 ring-[var(--color-primary)] border-white":"border-black/10 dark:border-white/10")}></button>
                  ))}
                </div>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">{translate('theme.gradient')}</p>
                <div className="flex gap-2">
                  <input type="color" value={theme.gradientFrom} onChange={(e)=>theme.setGradient(e.target.value,theme.gradientTo)} className="w-10 h-10 rounded-md" />
                  <input type="color" value={theme.gradientTo} onChange={(e)=>theme.setGradient(theme.gradientFrom,e.target.value)} className="w-10 h-10 rounded-md" />
                </div>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">{translate('theme.glass')}</p>
                <button onClick={theme.toggleGlass} className={clsx("px-3 py-1 rounded-md text-xs font-medium border", theme.glass?"bg-[var(--color-primary)] text-white border-[var(--color-primary)]":"bg-white/40 dark:bg-slate-800/40 border-gray-300 dark:border-gray-700")}>{theme.glass?"On":"Off"}</button>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">{translate('theme.fontScale')}</p>
                <input type="range" min={0.85} max={1.8} step={0.01} value={theme.fontScale} onChange={e=>theme.setFontScale(parseFloat(e.target.value))} className="w-full" />
                <div className="mt-1 text-[10px] tracking-wide">{(theme.fontScale*100).toFixed(0)}%</div>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">{translate('theme.sidebar')}</p>
                <button onClick={theme.toggleSidebar} className={clsx("px-3 py-1 rounded-md text-xs font-medium border", theme.sidebarCollapsed?"bg-[var(--color-primary)] text-white border-[var(--color-primary)]":"bg-white/40 dark:bg-slate-800/40 border-gray-300 dark:border-gray-700")}>{theme.sidebarCollapsed?"Expand":"Collapse"}</button>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">{translate('theme.language')}</p>
                <div className="flex gap-2">
                  {['en','ar'].map(l => (
                    <button key={l} onClick={()=>store.setLanguage(l)} className={clsx("px-3 py-1 rounded-md text-xs font-medium border", store.language===l?"bg-[var(--color-primary)] text-white border-[var(--color-primary)]":"bg-white/40 dark:bg-slate-800/40 border-gray-300 dark:border-gray-700")}>{l==='en'?'English':'العربية'}</button>
                  ))}
                </div>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">{translate('theme.sidebarPosition')}</p>
                <div className="flex gap-2">
                  {(['left','right'] as const).map(p => (
                    <button key={p} onClick={()=>store.setSidebarPosition(p)} className={clsx("px-3 py-1 rounded-md text-xs font-medium border capitalize", store.sidebarPosition===p?"bg-[var(--color-primary)] text-white border-[var(--color-primary)]":"bg-white/40 dark:bg-slate-800/40 border-gray-300 dark:border-gray-700")}>{p}</button>
                  ))}
                </div>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">{translate('theme.iconScale')}</p>
                <input type="range" min={0.8} max={1.4} step={0.05} value={store.iconScale} onChange={e=>store.setIconScale(parseFloat(e.target.value))} className="w-full" />
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">Layout Width</p>
                <div className="flex gap-2 flex-wrap">
                  {(['full','boxed','wide'] as const).map(w => (
                    <button key={w} onClick={()=>store.setLayoutWidth?.(w)} className={clsx("px-3 py-1 rounded-md text-xs font-medium border capitalize", store.layoutWidth===w?"bg-[var(--color-primary)] text-white border-[var(--color-primary)]":"bg-white/40 dark:bg-slate-800/40 border-gray-300 dark:border-gray-700")}>{w}</button>
                  ))}
                </div>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">Navbar Style</p>
                <div className="flex gap-2 flex-wrap">
                  {(['glass','solid','transparent'] as const).map(v => (
                    <button key={v} onClick={()=>store.setNavbarStyle?.(v)} className={clsx("px-3 py-1 rounded-md text-xs font-medium border capitalize", store.navbarStyle===v?"bg-[var(--color-primary)] text-white border-[var(--color-primary)]":"bg-white/40 dark:bg-slate-800/40 border-gray-300 dark:border-gray-700")}>{v}</button>
                  ))}
                </div>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">Sidebar Surface</p>
                <div className="flex gap-2 flex-wrap">
                  {(['glass','solid'] as const).map(v => (
                    <button key={v} onClick={()=>store.setSidebarSurface?.(v)} className={clsx("px-3 py-1 rounded-md text-xs font-medium border capitalize", store.sidebarSurface===v?"bg-[var(--color-primary)] text-white border-[var(--color-primary)]":"bg-white/40 dark:bg-slate-800/40 border-gray-300 dark:border-gray-700")}>{v}</button>
                  ))}
                </div>
              </section>
              <section>
                <p className="text-xs font-medium mb-2 uppercase tracking-wide text-gray-500 dark:text-gray-400">Font Family</p>
                <select value={store.fontFamily} onChange={e=>store.setFontFamily?.(e.target.value)} className="w-full text-xs rounded-md border border-gray-300 dark:border-gray-700 bg-white/60 dark:bg-slate-800/60 p-2">
                  {fontFamilies.map(f => <option key={f} value={f}>{f.split(',')[0]}</option>)}
                </select>
              </section>
              {"resetTheme" in theme && (
                <section>
                  <button onClick={(theme as any).resetTheme} className="w-full mt-4 bg-red-500/90 hover:bg-red-600 text-white px-4 py-2 rounded-md text-xs font-semibold shadow">{translate('actions.reset')}</button>
                </section>
              )}
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};

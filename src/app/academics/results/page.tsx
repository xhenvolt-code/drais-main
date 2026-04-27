"use client";
import React, { useState, useEffect } from 'react';
import { Settings2, GraduationCap, BookOpen, ArrowRightLeft } from 'lucide-react';
import Button from '@/components/ui/Button.jsx';
import ResultTypesManager from '@/components/academics/ResultTypesManager';
import ClassResultsManager from '@/components/academics/ClassResultsManager';
import TheologyResultsManager from '@/components/academics/TheologyResultsManager';
import { MarksMigrationWizard } from '@/components/academics/MarksMigrationWizard';

const tabs = [
  { id: 'result-types',      label: 'Result Types',      icon: Settings2 },
  { id: 'secular-results',   label: 'Academic Results',   icon: GraduationCap },
  { id: 'theology-results',  label: 'Theology Results',   icon: BookOpen },
];

interface WizardData {
  academicYears: Array<{ id: number; name: string }>;
  terms: Array<{ id: number; name: string }>;
  classes: Array<{ id: number; name: string }>;
  subjects: Array<{ id: number; name: string }>;
  resultTypes: Array<{ id: number; name: string }>;
}

export default function ResultsPage() {
  const [activeTab, setActiveTab] = useState(1); // default to Academic Results
  const [migrationOpen, setMigrationOpen] = useState(false);
  const [wizardData, setWizardData] = useState<WizardData>({
    academicYears: [],
    terms: [],
    classes: [],
    subjects: [],
    resultTypes: []
  });
  const [loadingWizardData, setLoadingWizardData] = useState(false);

  // Load wizard data when component mounts or modal opens
  useEffect(() => {
    if (migrationOpen && wizardData.academicYears.length === 0) {
      console.log('[Migration] Opening modal, loading data...');
      loadWizardData();
    }
  }, [migrationOpen]);

  const loadWizardData = async () => {
    setLoadingWizardData(true);
    try {
      const [yearsRes, termsRes, classesRes, subjectsRes, typesRes] = await Promise.all([
        fetch('/api/academic_years'),
        fetch('/api/terms'),
        fetch('/api/classes'),
        fetch('/api/subjects'),
        fetch('/api/result-types')
      ]);

      const years = yearsRes.ok ? await yearsRes.json() : [];
      const terms = termsRes.ok ? await termsRes.json() : [];
      const classes = classesRes.ok ? await classesRes.json() : [];
      const subjects = subjectsRes.ok ? await subjectsRes.json() : [];
      const types = typesRes.ok ? await typesRes.json() : [];

      setWizardData({
        academicYears: Array.isArray(years) ? years : [],
        terms: Array.isArray(terms) ? terms : [],
        classes: Array.isArray(classes) ? classes : [],
        subjects: Array.isArray(subjects) ? subjects : [],
        resultTypes: Array.isArray(types) ? types : []
      });
    } catch (error) {
      console.error('Error loading wizard data:', error);
      // Fallback to empty arrays - UI will still work
    } finally {
      setLoadingWizardData(false);
    }
  };

  return (
    <div className="flex flex-col h-screen bg-slate-50 dark:bg-slate-950 overflow-hidden">

      {/* ── TOOLBAR (48px) ──────────────────────────────────────────── */}
      <div className="flex-shrink-0 sticky top-0 z-40 h-12 flex items-center justify-between gap-2 px-3 bg-white/95 dark:bg-slate-900/95 backdrop-blur-md border-b border-slate-200 dark:border-slate-800 shadow-sm">
        {/* Compact tab pills */}
        <div className="flex items-center gap-1 bg-slate-100 dark:bg-slate-800 rounded-lg p-0.5">
          {tabs.map((tab, idx) => {
            const Icon = tab.icon;
            const active = activeTab === idx;
            return (
              <button
                key={tab.id}
                onClick={() => setActiveTab(idx)}
                className={`flex items-center gap-1.5 px-3 py-1.5 rounded-md text-xs font-semibold transition-all whitespace-nowrap ${
                  active
                    ? 'bg-white dark:bg-slate-700 text-indigo-700 dark:text-indigo-300 shadow-sm'
                    : 'text-slate-500 dark:text-slate-400 hover:text-slate-700 dark:hover:text-slate-200'
                }`}
              >
                <Icon className="w-3.5 h-3.5" />
                {tab.label}
              </button>
            );
          })}
        </div>

        {/* Right-side actions */}
        {activeTab === 1 && (
          <Button 
            onClick={() => {
              console.log('[Migration] Button clicked, setting migrationOpen to true');
              setMigrationOpen(true);
            }}
            disabled={loadingWizardData || wizardData.academicYears.length === 0}
            className="text-xs"
          >
            <ArrowRightLeft className="w-3.5 h-3.5 mr-1.5" />
            Migrate Marks
          </Button>
        )}
      </div>

      {/* ── CONTENT (fills remaining space) ─────────────────────────── */}
      <div className="flex-1 overflow-y-auto">
        {activeTab === 0 && <div className="p-4"><ResultTypesManager /></div>}
        {activeTab === 1 && <ClassResultsManager academicType="secular" />}
        {activeTab === 2 && <TheologyResultsManager />}
      </div>

      {/* Migration Wizard */}
      <MarksMigrationWizard
        open={migrationOpen}
        onOpenChange={setMigrationOpen}
        academicYears={wizardData.academicYears}
        terms={wizardData.terms}
        classes={wizardData.classes}
        subjects={wizardData.subjects}
        resultTypes={wizardData.resultTypes}
        onMigrationComplete={(result) => {
          console.log('Migration complete:', result);
          // Optionally refresh results
        }}
      />
    </div>
  );
}
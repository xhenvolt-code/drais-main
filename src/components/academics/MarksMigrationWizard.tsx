'use client';

import React, { useState } from 'react';
import Modal from '@/components/ui/Modal';
import Button from '@/components/ui/Button.jsx';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue
} from '@/components/ui/Select';
import { AlertCircle, CheckCircle2, Loader2 } from 'lucide-react';

interface MigrationWizardProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  academicYears: Array<{ id: number; name: string }>;
  terms: Array<{ id: number; name: string }>;
  classes: Array<{ id: number; name: string }>;
  subjects: Array<{ id: number; name: string }>;
  resultTypes: Array<{ id: number; name: string }>;
  onMigrationComplete?: (result: any) => void;
}

type WizardStep = 'selection' | 'preview' | 'resolution' | 'confirmation';

interface SelectionState {
  academicYearId: string;
  termId: string;
  classId: string;
  sourceSubjectId: string;
  destinationSubjectId: string;
  resultTypeId: string;
}

interface MigrationAnalysis {
  totalLearnersAffected: number;
  learnersWithMarks: number;
  conflictCount: number;
  conflicts: any[];
  preview: any[];
}

export function MarksMigrationWizard({
  open,
  onOpenChange,
  academicYears,
  terms,
  classes,
  subjects,
  resultTypes,
  onMigrationComplete
}: MigrationWizardProps) {
  const [currentStep, setCurrentStep] = useState<WizardStep>('selection');
  const [selection, setSelection] = useState<SelectionState>({
    academicYearId: '',
    termId: '',
    classId: '',
    sourceSubjectId: '',
    destinationSubjectId: '',
    resultTypeId: ''
  });
  
  const [analysis, setAnalysis] = useState<MigrationAnalysis | null>(null);
  const [conflictResolution, setConflictResolution] = useState<'overwrite' | 'skip' | 'merge'>('skip');
  const [reason, setReason] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const isSelectionValid =
    selection.academicYearId &&
    selection.termId &&
    selection.classId &&
    selection.sourceSubjectId &&
    selection.destinationSubjectId &&
    selection.resultTypeId &&
    selection.sourceSubjectId !== selection.destinationSubjectId;

  const handleAnalyze = async () => {
    setLoading(true);
    setError(null);

    try {
      const response = await fetch('/api/marks-migration/analyze', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          classId: parseInt(selection.classId),
          academicYearId: parseInt(selection.academicYearId),
          termId: parseInt(selection.termId),
          sourceSubjectId: parseInt(selection.sourceSubjectId),
          destinationSubjectId: parseInt(selection.destinationSubjectId),
          resultTypeId: parseInt(selection.resultTypeId)
        })
      });

      if (!response.ok) {
        const data = await response.json();
        throw new Error(data.error || 'Failed to analyze migration');
      }

      const data = await response.json();
      setAnalysis(data.analysis);
      setCurrentStep('preview');
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleExecute = async () => {
    setLoading(true);
    setError(null);

    try {
      const response = await fetch('/api/marks-migration/execute', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          classId: parseInt(selection.classId),
          academicYearId: parseInt(selection.academicYearId),
          termId: parseInt(selection.termId),
          sourceSubjectId: parseInt(selection.sourceSubjectId),
          destinationSubjectId: parseInt(selection.destinationSubjectId),
          resultTypeId: parseInt(selection.resultTypeId),
          conflictResolution,
          reason
        })
      });

      if (!response.ok) {
        const data = await response.json();
        throw new Error(data.error || 'Failed to execute migration');
      }

      const data = await response.json();
      onMigrationComplete?.(data.migration);
      setCurrentStep('confirmation');
      setTimeout(() => onOpenChange(false), 2000);
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const sourceSubjectName = subjects.find(s => s.id === parseInt(selection.sourceSubjectId))?.name;
  const destSubjectName = subjects.find(s => s.id === parseInt(selection.destinationSubjectId))?.name;

  return (
    <Modal
      isOpen={open}
      onClose={() => onOpenChange(false)}
      title="Migrate Subject Marks"
      size="lg"
    >
      <div className="space-y-6 py-4">
        {error && (
          <div className="bg-red-50 border border-red-200 rounded-lg p-4 flex gap-3">
            <AlertCircle className="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" />
            <div>
              <h4 className="font-medium text-red-900">Error</h4>
              <p className="text-sm text-red-800 mt-1">{error}</p>
            </div>
          </div>
        )}

        <div className="flex gap-2 justify-center">
          {(['selection', 'preview', 'resolution', 'confirmation'] as const).map((step) => (
            <div
              key={step}
              className={`h-2 flex-1 rounded-full transition-colors ${
                step === currentStep ? 'bg-blue-600' :
                (['selection', 'preview', 'resolution', 'confirmation'] as const).indexOf(currentStep) > (['selection', 'preview', 'resolution', 'confirmation'] as const).indexOf(step) ? 'bg-green-600' :
                'bg-gray-200'
              }`}
            />
          ))}
        </div>

        {currentStep === 'selection' && (
          <div className="space-y-4">
            <h3 className="font-semibold text-lg">Step 1: Select Migration Parameters</h3>
            
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium mb-2">Academic Year</label>
                <Select
                  value={selection.academicYearId}
                  onValueChange={(v) => setSelection({...selection, academicYearId: v})}
                >
                  <SelectTrigger className="w-full">
                    <SelectValue placeholder="Select year" />
                  </SelectTrigger>
                  <SelectContent>
                    {academicYears.map(y => (
                      <SelectItem key={y.id} value={y.id.toString()}>
                        {y.name}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div>
                <label className="block text-sm font-medium mb-2">Term</label>
                <Select
                  value={selection.termId}
                  onValueChange={(v) => setSelection({...selection, termId: v})}
                >
                  <SelectTrigger className="w-full">
                    <SelectValue placeholder="Select term" />
                  </SelectTrigger>
                  <SelectContent>
                    {terms.map(t => (
                      <SelectItem key={t.id} value={t.id.toString()}>
                        {t.name}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div>
                <label className="block text-sm font-medium mb-2">Class</label>
                <Select
                  value={selection.classId}
                  onValueChange={(v) => setSelection({...selection, classId: v})}
                >
                  <SelectTrigger className="w-full">
                    <SelectValue placeholder="Select class" />
                  </SelectTrigger>
                  <SelectContent>
                    {classes.map(c => (
                      <SelectItem key={c.id} value={c.id.toString()}>
                        {c.name}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div>
                <label className="block text-sm font-medium mb-2">Result Type</label>
                <Select
                  value={selection.resultTypeId}
                  onValueChange={(v) => setSelection({...selection, resultTypeId: v})}
                >
                  <SelectTrigger className="w-full">
                    <SelectValue placeholder="Select type" />
                  </SelectTrigger>
                  <SelectContent>
                    {resultTypes.map(r => (
                      <SelectItem key={r.id} value={r.id.toString()}>
                        {r.name}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div>
                <label className="block text-sm font-medium mb-2">FROM Subject (Wrong)</label>
                <Select
                  value={selection.sourceSubjectId}
                  onValueChange={(v) => setSelection({...selection, sourceSubjectId: v})}
                >
                  <SelectTrigger className="w-full">
                    <SelectValue placeholder="Select source" />
                  </SelectTrigger>
                  <SelectContent>
                    {subjects.map(s => (
                      <SelectItem key={s.id} value={s.id.toString()}>
                        {s.name}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div>
                <label className="block text-sm font-medium mb-2">TO Subject (Correct)</label>
                <Select
                  value={selection.destinationSubjectId}
                  onValueChange={(v) => setSelection({...selection, destinationSubjectId: v})}
                >
                  <SelectTrigger className="w-full">
                    <SelectValue placeholder="Select destination" />
                  </SelectTrigger>
                  <SelectContent>
                    {subjects.map(s => (
                      <SelectItem key={s.id} value={s.id.toString()}>
                        {s.name}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>
          </div>
        )}

        {currentStep === 'preview' && analysis && (
          <div className="space-y-4">
            <h3 className="font-semibold text-lg">Step 2: Migration Analysis</h3>
            
            <div className="grid grid-cols-3 gap-4">
              <div className="bg-blue-50 p-4 rounded-lg">
                <p className="text-sm text-gray-600">Total Learners</p>
                <p className="text-2xl font-bold text-blue-600">{analysis.totalLearnersAffected}</p>
              </div>
              <div className="bg-green-50 p-4 rounded-lg">
                <p className="text-sm text-gray-600">With Marks</p>
                <p className="text-2xl font-bold text-green-600">{analysis.learnersWithMarks}</p>
              </div>
              <div className="bg-orange-50 p-4 rounded-lg">
                <p className="text-sm text-gray-600">Conflicts</p>
                <p className="text-2xl font-bold text-orange-600">{analysis.conflictCount}</p>
              </div>
            </div>

            {analysis.preview && analysis.preview.length > 0 && (
              <div className="mt-4">
                <h4 className="font-medium mb-2">Preview</h4>
                <div className="max-h-64 overflow-y-auto border rounded-lg">
                  <table className="w-full text-sm">
                    <thead className="sticky top-0 bg-gray-100 border-b">
                      <tr>
                        <th className="px-4 py-2 text-left">Learner</th>
                        <th className="px-4 py-2 text-center">Source</th>
                        <th className="px-4 py-2 text-center">Dest</th>
                        <th className="px-4 py-2 text-left">Status</th>
                      </tr>
                    </thead>
                    <tbody>
                      {analysis.preview.slice(0, 10).map((item, idx) => (
                        <tr key={idx} className="border-b hover:bg-gray-50">
                          <td className="px-4 py-2 text-sm">{item.studentName || 'N/A'}</td>
                          <td className="px-4 py-2 text-center text-sm">{item.sourceMarks !== null ? item.sourceMarks : '-'}</td>
                          <td className="px-4 py-2 text-center text-sm">{item.destinationMarks !== null ? item.destinationMarks : '-'}</td>
                          <td className="px-4 py-2 text-sm">
                            {item.conflict ? (
                              <span className="text-orange-600 text-xs font-medium">⚠ Conflict</span>
                            ) : (
                              <span className="text-green-600 text-xs font-medium">✓ OK</span>
                            )}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            )}
          </div>
        )}

        {currentStep === 'resolution' && (
          <div className="space-y-4">
            <h3 className="font-semibold text-lg">Step 3: Conflict Resolution</h3>
            
            <div className="space-y-3">
              <label className="flex items-center gap-3 p-3 border rounded-lg cursor-pointer hover:bg-gray-50">
                <input
                  type="radio"
                  name="resolution"
                  value="skip"
                  checked={conflictResolution === 'skip'}
                  onChange={(e) => setConflictResolution(e.target.value as any)}
                  className="w-4 h-4"
                />
                <div>
                  <p className="font-medium">Skip Conflicts</p>
                  <p className="text-sm text-gray-600">Leave existing marks unchanged</p>
                </div>
              </label>

              <label className="flex items-center gap-3 p-3 border rounded-lg cursor-pointer hover:bg-gray-50">
                <input
                  type="radio"
                  name="resolution"
                  value="overwrite"
                  checked={conflictResolution === 'overwrite'}
                  onChange={(e) => setConflictResolution(e.target.value as any)}
                  className="w-4 h-4"
                />
                <div>
                  <p className="font-medium">Overwrite</p>
                  <p className="text-sm text-gray-600">Replace existing marks with new ones</p>
                </div>
              </label>

              <label className="flex items-center gap-3 p-3 border rounded-lg cursor-pointer hover:bg-gray-50">
                <input
                  type="radio"
                  name="resolution"
                  value="merge"
                  checked={conflictResolution === 'merge'}
                  onChange={(e) => setConflictResolution(e.target.value as any)}
                  className="w-4 h-4"
                />
                <div>
                  <p className="font-medium">Merge (Average)</p>
                  <p className="text-sm text-gray-600">Take average of both marks</p>
                </div>
              </label>
            </div>

            <div>
              <label className="block text-sm font-medium mb-2">Reason for Migration</label>
              <textarea
                value={reason}
                onChange={(e) => setReason(e.target.value)}
                placeholder="Explain why this migration is necessary..."
                className="w-full px-3 py-2 border rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                rows={4}
              />
            </div>
          </div>
        )}

        {currentStep === 'confirmation' && (
          <div className="text-center space-y-4">
            <CheckCircle2 className="w-12 h-12 text-green-600 mx-auto" />
            <div>
              <h3 className="font-semibold text-lg">Migration Complete!</h3>
              <p className="text-gray-600 text-sm mt-1">
                Successfully migrated marks from {sourceSubjectName} to {destSubjectName}
              </p>
            </div>
          </div>
        )}

        <div className="flex gap-3 justify-end pt-4 border-t">
          <Button
            onClick={() => {
              if (currentStep === 'selection') {
                onOpenChange(false);
              } else if (currentStep === 'preview') {
                setCurrentStep('selection');
              } else if (currentStep === 'resolution') {
                setCurrentStep('preview');
              }
            }}
            disabled={currentStep === 'confirmation' || loading}
          >
            Back
          </Button>

          <Button
            onClick={() => {
              if (currentStep === 'selection') {
                handleAnalyze();
              } else if (currentStep === 'preview') {
                setCurrentStep('resolution');
              } else if (currentStep === 'resolution') {
                handleExecute();
              }
            }}
            disabled={
              (currentStep === 'selection' && !isSelectionValid) ||
              loading ||
              currentStep === 'confirmation'
            }
          >
            {loading && <Loader2 className="w-4 h-4 mr-2 animate-spin" />}
            {currentStep === 'selection' && 'Analyze'}
            {currentStep === 'preview' && 'Continue'}
            {currentStep === 'resolution' && 'Execute'}
            {currentStep === 'confirmation' && 'Done'}
          </Button>
        </div>
      </div>
    </Modal>
  );
}

export default MarksMigrationWizard;

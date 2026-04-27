'use client';

/**
 * Marks Migration Wizard Modal
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * 
 * Multi-step wizard for controlled, safe marks migration:
 * STEP 1: Selection (academic year, term, class, subjects)
 * STEP 2: Analysis (impact preview, conflict detection)
 * STEP 3: Preview (learner-by-learner mark changes)
 * STEP 4: Conflict Resolution (strategy selection)
 * STEP 5: Confirmation & Execution
 */

import React, { useState } from 'react';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue
} from '@/components/ui/select';
import { Label } from '@/components/ui/label';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { AlertCircle, CheckCircle2, AlertTriangle, Loader2 } from 'lucide-react';
import { Alert, AlertDescription } from '@/components/ui/alert';

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

type WizardStep = 'selection' | 'analysis' | 'preview' | 'resolution' | 'confirmation';

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
  assessmentsInvolved: string[];
  conflictCount: number;
  conflicts: any[];
  noConflicts: any[];
  destinationHasExistingMarks: number;
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

  // STEP 1: Selection form validation
  const isSelectionValid =
    selection.academicYearId &&
    selection.termId &&
    selection.classId &&
    selection.sourceSubjectId &&
    selection.destinationSubjectId &&
    selection.resultTypeId &&
    selection.sourceSubjectId !== selection.destinationSubjectId;

  // Analyze migration impact
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
      setCurrentStep('analysis');
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // Execute migration
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
      onOpenChange(false);
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const sourceSubjectName = subjects.find(s => s.id === parseInt(selection.sourceSubjectId))?.name;
  const destSubjectName = subjects.find(s => s.id === parseInt(selection.destinationSubjectId))?.name;

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>Migrate Subject Marks</DialogTitle>
          <DialogDescription>
            Safely migrate marks from one subject to another with conflict detection and preview
          </DialogDescription>
        </DialogHeader>

        {error && (
          <Alert variant="destructive">
            <AlertCircle className="h-4 w-4" />
            <AlertDescription>{error}</AlertDescription>
          </Alert>
        )}

        {/* STEP 1: Selection */}
        {currentStep === 'selection' && (
          <div className="space-y-4">
            <h3 className="font-semibold">Step 1: Select Migration Parameters</h3>
            
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label htmlFor="academic-year">Academic Year</Label>
                <Select
                  value={selection.academicYearId}
                  onValueChange={(v) => setSelection({...selection, academicYearId: v})}
                >
                  <SelectTrigger id="academic-year">
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
                <Label htmlFor="term">Term</Label>
                <Select
                  value={selection.termId}
                  onValueChange={(v) => setSelection({...selection, termId: v})}
                >
                  <SelectTrigger id="term">
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
                <Label htmlFor="class">Class</Label>
                <Select
                  value={selection.classId}
                  onValueChange={(v) => setSelection({...selection, classId: v})}
                >
                  <SelectTrigger id="class">
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
                <Label htmlFor="result-type">Result Type</Label>
                <Select
                  value={selection.resultTypeId}
                  onValueChange={(v) => setSelection({...selection, resultTypeId: v})}
                >
                  <SelectTrigger id="result-type">
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
                <Label htmlFor="source-subject">FROM Subject (Wrong)</Label>
                <Select
                  value={selection.sourceSubjectId}
                  onValueChange={(v) => setSelection({...selection, sourceSubjectId: v})}
                >
                  <SelectTrigger id="source-subject">
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
                <Label htmlFor="destination-subject">TO Subject (Correct)</Label>
                <Select
                  value={selection.destinationSubjectId}
                  onValueChange={(v) => setSelection({...selection, destinationSubjectId: v})}
                >
                  <SelectTrigger id="destination-subject">
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

        {/* STEP 2: Analysis */}
        {currentStep === 'analysis' && analysis && (
          <div className="space-y-4">
            <h3 className="font-semibold">Step 2: Impact Analysis</h3>
            
            <div className="grid grid-cols-2 gap-4">
              <Alert>
                <CheckCircle2 className="h-4 w-4" />
                <AlertDescription>
                  <strong>Learners with marks:</strong> {analysis.learnersWithMarks}
                </AlertDescription>
              </Alert>

              {analysis.conflictCount > 0 && (
                <Alert variant="destructive">
                  <AlertTriangle className="h-4 w-4" />
                  <AlertDescription>
                    <strong>Conflicts:</strong> {analysis.conflictCount} learners have existing marks in destination
                  </AlertDescription>
                </Alert>
              )}
            </div>

            {analysis.assessmentsInvolved.length > 0 && (
              <div>
                <Label>Assessments Involved</Label>
                <p className="text-sm text-gray-600">
                  {analysis.assessmentsInvolved.join(', ')}
                </p>
              </div>
            )}

            <div>
              <Label>Destination Status</Label>
              <p className="text-sm text-gray-600">
                {analysis.destinationHasExistingMarks > 0
                  ? `${analysis.destinationHasExistingMarks} learners already have marks in destination`
                  : 'No existing marks in destination subject'}
              </p>
            </div>
          </div>
        )}

        {/* STEP 3: Preview */}
        {currentStep === 'preview' && analysis && (
          <div className="space-y-4">
            <h3 className="font-semibold">Step 3: Preview Learner Impact</h3>
            
            <div className="max-h-80 overflow-y-auto border rounded">
              <table className="w-full text-sm">
                <thead className="bg-gray-100 sticky top-0">
                  <tr>
                    <th className="text-left p-2">Learner</th>
                    <th className="text-left p-2">Admission No</th>
                    <th className="text-center p-2">{sourceSubjectName}</th>
                    <th className="text-center p-2">{destSubjectName}</th>
                    <th className="text-center p-2">After Migration</th>
                    <th className="text-center p-2">Status</th>
                  </tr>
                </thead>
                <tbody>
                  {analysis.preview.map((learner, idx) => (
                    <tr key={idx} className={learner.hasConflict ? 'bg-red-50' : ''}>
                      <td className="p-2">{learner.studentName}</td>
                      <td className="p-2">{learner.admissionNo}</td>
                      <td className="text-center p-2">{learner.currentSourceMark?.toFixed(2) || '-'}</td>
                      <td className="text-center p-2">{learner.currentDestinationMark?.toFixed(2) || '-'}</td>
                      <td className="text-center p-2 font-semibold">{learner.afterMigrationMark?.toFixed(2) || '-'}</td>
                      <td className="text-center p-2">
                        {learner.hasConflict ? (
                          <span className="text-xs bg-red-100 text-red-800 px-2 py-1 rounded">
                            Conflict
                          </span>
                        ) : (
                          <span className="text-xs bg-green-100 text-green-800 px-2 py-1 rounded">
                            OK
                          </span>
                        )}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* STEP 4: Conflict Resolution */}
        {currentStep === 'resolution' && (
          <div className="space-y-4">
            <h3 className="font-semibold">Step 4: Conflict Resolution Strategy</h3>
            
            <Alert>
              <AlertCircle className="h-4 w-4" />
              <AlertDescription>
                {analysis?.conflictCount === 0
                  ? 'No conflicts detected - you can proceed safely'
                  : `${analysis?.conflictCount} learners have existing marks in destination`}
              </AlertDescription>
            </Alert>

            <div className="space-y-3">
              <Label>How should conflicts be handled?</Label>

              <div className="space-y-2">
                <label className="flex items-center p-3 border rounded cursor-pointer hover:bg-gray-50"
                  onClick={() => setConflictResolution('skip')}>
                  <input
                    type="radio"
                    checked={conflictResolution === 'skip'}
                    readOnly
                    className="mr-3"
                  />
                  <div>
                    <div className="font-medium">Skip Conflicting Learners</div>
                    <div className="text-xs text-gray-600">
                      Keep destination marks as-is, don't migrate for learners with existing marks
                    </div>
                  </div>
                </label>

                <label className="flex items-center p-3 border rounded cursor-pointer hover:bg-gray-50"
                  onClick={() => setConflictResolution('overwrite')}>
                  <input
                    type="radio"
                    checked={conflictResolution === 'overwrite'}
                    readOnly
                    className="mr-3"
                  />
                  <div>
                    <div className="font-medium">Overwrite Destination</div>
                    <div className="text-xs text-gray-600">
                      Replace destination marks with source marks
                    </div>
                  </div>
                </label>

                <label className="flex items-center p-3 border rounded cursor-pointer hover:bg-gray-50"
                  onClick={() => setConflictResolution('merge')}>
                  <input
                    type="radio"
                    checked={conflictResolution === 'merge'}
                    readOnly
                    className="mr-3"
                  />
                  <div>
                    <div className="font-medium">Merge (Average)</div>
                    <div className="text-xs text-gray-600">
                      Average source and destination marks
                    </div>
                  </div>
                </label>
              </div>
            </div>

            <div>
              <Label htmlFor="reason">Migration Reason (Optional)</Label>
              <textarea
                id="reason"
                className="w-full border rounded p-2 text-sm"
                placeholder="Document why this migration is needed..."
                value={reason}
                onChange={(e) => setReason(e.target.value)}
                rows={3}
              />
            </div>
          </div>
        )}

        {/* STEP 5: Confirmation */}
        {currentStep === 'confirmation' && (
          <div className="space-y-4">
            <h3 className="font-semibold">Step 5: Confirm & Execute</h3>
            
            <Alert>
              <AlertCircle className="h-4 w-4" />
              <AlertDescription>
                Review the migration details below before confirming. This action is transactional but irreversible without rollback.
              </AlertDescription>
            </Alert>

            <div className="bg-gray-50 p-4 rounded space-y-2 text-sm">
              <div><strong>From Subject:</strong> {sourceSubjectName}</div>
              <div><strong>To Subject:</strong> {destSubjectName}</div>
              <div><strong>Learners Affected:</strong> {analysis?.learnersWithMarks}</div>
              <div><strong>Conflicts:</strong> {analysis?.conflictCount}</div>
              <div><strong>Strategy:</strong> {conflictResolution}</div>
              {reason && <div><strong>Reason:</strong> {reason}</div>}
            </div>
          </div>
        )}

        <DialogFooter className="gap-2">
          <Button
            variant="outline"
            onClick={() => {
              if (currentStep === 'selection') {
                onOpenChange(false);
              } else if (currentStep === 'analysis') {
                setCurrentStep('selection');
              } else if (currentStep === 'preview') {
                setCurrentStep('analysis');
              } else if (currentStep === 'resolution') {
                setCurrentStep('preview');
              } else if (currentStep === 'confirmation') {
                setCurrentStep('resolution');
              }
            }}
          >
            Back
          </Button>

          {currentStep !== 'confirmation' && (
            <Button
              onClick={() => {
                if (currentStep === 'selection') {
                  handleAnalyze();
                } else if (currentStep === 'analysis') {
                  setCurrentStep('preview');
                } else if (currentStep === 'preview') {
                  setCurrentStep('resolution');
                } else if (currentStep === 'resolution') {
                  setCurrentStep('confirmation');
                }
              }}
              disabled={
                (currentStep === 'selection' && !isSelectionValid) ||
                loading
              }
            >
              {loading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
              Next
            </Button>
          )}

          {currentStep === 'confirmation' && (
            <Button
              onClick={handleExecute}
              disabled={loading}
            >
              {loading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
              Execute Migration
            </Button>
          )}
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

"use client";
import React, { useEffect, useState, useMemo } from 'react';
import { Dialog, Transition } from '@headlessui/react';
import { X, Edit3, History, Undo, Save, Search, AlertTriangle } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

interface EditableResult {
  id: string;
  student_id: number;
  student_name: string;
  class_name: string;
  subject_name: string;
  term_name: string;
  result_type: string;
  score: number | null;
  grade: string | null;
  remarks: string | null;
  exam_id?: number;
  class_id?: number;
  subject_id?: number;
  term_id?: number;
  result_type_id?: number;
  table_type: 'results' | 'class_results';
  original_values: any;
  is_modified: boolean;
}

interface AuditLog {
  id: number;
  actor_user_id: number;
  actor_name: string;
  action: string;
  entity_type: string;
  entity_id: string;
  changes_json: any;
  ip: string;
  user_agent: string;
  created_at: string;
}

const EditResultsManager: React.FC = () => {
  const [results, setResults] = useState<EditableResult[]>([]);
  const [filteredResults, setFilteredResults] = useState<EditableResult[]>([]);
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedClass, setSelectedClass] = useState('');
  const [selectedSubject, setSelectedSubject] = useState('');
  const [showHistory, setShowHistory] = useState(false);
  const [auditLogs, setAuditLogs] = useState<AuditLog[]>([]);
  const [selectedResult, setSelectedResult] = useState<string | null>(null);
  const [undoStack, setUndoStack] = useState<EditableResult[]>([]);
  const [message, setMessage] = useState('');
  const [hasPermission, setHasPermission] = useState(false);

  // Check user permissions
  useEffect(() => {
    checkEditPermissions();
  }, []);

  const checkEditPermissions = async () => {
    try {
      const response = await fetch('/api/auth/permissions');
      const data = await response.json();
      setHasPermission(data.permissions?.includes('edit_results') || false);
    } catch (error) {
      console.error('Permission check failed:', error);
      setHasPermission(false);
    }
  };

  // Load results for editing
  const loadResults = async () => {
    if (!hasPermission) return;
    
    setLoading(true);
    try {
      const response = await fetch('/api/results/editable');
      const data = await response.json();
      
      if (data.success) {
        const editableResults = data.data.map((item: any) => ({
          ...item,
          id: `${item.table_type}_${item.student_id}_${item.subject_id || item.exam_id}`,
          original_values: {
            score: item.score,
            grade: item.grade,
            remarks: item.remarks
          },
          is_modified: false
        }));
        
        setResults(editableResults);
        setFilteredResults(editableResults);
      }
    } catch (error) {
      console.error('Failed to load results:', error);
      setMessage('Failed to load results');
    } finally {
      setLoading(false);
    }
  };

  // Filter results based on search criteria
  useEffect(() => {
    let filtered = results;
    
    if (searchTerm) {
      filtered = filtered.filter(r => 
        r.student_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        r.student_id.toString().includes(searchTerm)
      );
    }
    
    if (selectedClass) {
      filtered = filtered.filter(r => r.class_name === selectedClass);
    }
    
    if (selectedSubject) {
      filtered = filtered.filter(r => r.subject_name === selectedSubject);
    }
    
    setFilteredResults(filtered);
  }, [searchTerm, selectedClass, selectedSubject, results]);

  // Update result field
  const updateResult = (resultId: string, field: keyof EditableResult, value: any) => {
    setResults(prev => prev.map(result => {
      if (result.id === resultId) {
        const updated = {
          ...result,
          [field]: value,
          is_modified: true
        };
        
        // Add to undo stack
        setUndoStack(prev => [...prev.slice(-9), result]);
        
        return updated;
      }
      return result;
    }));
  };

  // Validate score input
  const validateScore = (score: number | null): boolean => {
    if (score === null) return true;
    return score >= 0 && score <= 100;
  };

  // Save changes to backend
  const saveChanges = async () => {
    const modifiedResults = results.filter(r => r.is_modified);
    
    if (modifiedResults.length === 0) {
      setMessage('No changes to save');
      return;
    }

    // Validate all scores
    const invalidScores = modifiedResults.filter(r => !validateScore(r.score));
    if (invalidScores.length > 0) {
      setMessage('Invalid scores detected. Scores must be between 0 and 100.');
      return;
    }

    setSaving(true);
    try {
      const response = await fetch('/api/results/edit', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ 
          updates: modifiedResults.map(r => ({
            id: r.id,
            table_type: r.table_type,
            student_id: r.student_id,
            exam_id: r.exam_id,
            class_id: r.class_id,
            subject_id: r.subject_id,
            term_id: r.term_id,
            result_type_id: r.result_type_id,
            score: r.score,
            grade: r.grade,
            remarks: r.remarks,
            original_values: r.original_values
          }))
        })
      });

      const data = await response.json();
      
      if (data.success) {
        setMessage(`Successfully updated ${modifiedResults.length} results`);
        setResults(prev => prev.map(r => ({
          ...r,
          is_modified: false,
          original_values: {
            score: r.score,
            grade: r.grade,
            remarks: r.remarks
          }
        })));
        setUndoStack([]);
      } else {
        setMessage(data.error || 'Failed to save changes');
      }
    } catch (error) {
      console.error('Save failed:', error);
      setMessage('Failed to save changes');
    } finally {
      setSaving(false);
    }
  };

  // Undo last change
  const undoLastChange = () => {
    if (undoStack.length === 0) return;
    
    const lastState = undoStack[undoStack.length - 1];
    setResults(prev => prev.map(r => 
      r.id === lastState.id ? lastState : r
    ));
    setUndoStack(prev => prev.slice(0, -1));
  };

  // Load audit logs for a result
  const loadAuditLogs = async (resultId: string) => {
    try {
      const response = await fetch(`/api/results/audit/${resultId}`);
      const data = await response.json();
      
      if (data.success) {
        setAuditLogs(data.data);
        setSelectedResult(resultId);
        setShowHistory(true);
      }
    } catch (error) {
      console.error('Failed to load audit logs:', error);
    }
  };

  // Get unique values for filters
  const uniqueClasses = useMemo(() => 
    [...new Set(results.map(r => r.class_name))].sort(), [results]
  );
  
  const uniqueSubjects = useMemo(() => 
    [...new Set(results.map(r => r.subject_name))].sort(), [results]
  );

  if (!hasPermission) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-center">
          <AlertTriangle className="w-16 h-16 text-red-500 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 dark:text-gray-100">Access Denied</h3>
          <p className="text-gray-600 dark:text-gray-400">You don&apos;t have permission to edit results.</p>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header Controls */}
      <div className="flex flex-wrap gap-4 items-center justify-between">
        <h2 className="text-2xl font-bold text-gray-900 dark:text-gray-100">Edit Results</h2>
        <div className="flex gap-2">
          <button
            onClick={undoLastChange}
            disabled={undoStack.length === 0}
            className="flex items-center gap-2 px-4 py-2 bg-gray-600 text-white rounded-lg disabled:opacity-50"
          >
            <Undo className="w-4 h-4" />
            Undo
          </button>
          <button
            onClick={saveChanges}
            disabled={saving || !results.some(r => r.is_modified)}
            className="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-lg disabled:opacity-50"
          >
            <Save className="w-4 h-4" />
            {saving ? 'Saving...' : 'Save Changes'}
          </button>
        </div>
      </div>

      {/* Filters */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="relative">
          <Search className="w-4 h-4 absolute left-3 top-3 text-gray-400" />
          <input
            type="text"
            placeholder="Search student..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full pl-10 pr-4 py-2 border rounded-lg"
          />
        </div>
        
        <select
          value={selectedClass}
          onChange={(e) => setSelectedClass(e.target.value)}
          className="px-4 py-2 border rounded-lg"
        >
          <option value="">All Classes</option>
          {uniqueClasses.map(className => (
            <option key={className} value={className}>{className}</option>
          ))}
        </select>
        
        <select
          value={selectedSubject}
          onChange={(e) => setSelectedSubject(e.target.value)}
          className="px-4 py-2 border rounded-lg"
        >
          <option value="">All Subjects</option>
          {uniqueSubjects.map(subject => (
            <option key={subject} value={subject}>{subject}</option>
          ))}
        </select>
        
        <button
          onClick={loadResults}
          disabled={loading}
          className="px-4 py-2 bg-blue-600 text-white rounded-lg disabled:opacity-50"
        >
          {loading ? 'Loading...' : 'Load Results'}
        </button>
      </div>

      {/* Message */}
      {message && (
        <motion.div
          initial={{ opacity: 0, y: -10 }}
          animate={{ opacity: 1, y: 0 }}
          className="p-4 bg-blue-100 border border-blue-200 rounded-lg"
        >
          {message}
        </motion.div>
      )}

      {/* Results Table */}
      <div className="overflow-x-auto">
        <table className="w-full border-collapse bg-white dark:bg-gray-800 rounded-lg shadow">
          <thead>
            <tr className="bg-gray-50 dark:bg-gray-700">
              <th className="px-4 py-3 text-left text-sm font-medium">Student</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Class</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Subject</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Term</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Type</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Score</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Grade</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Remarks</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Actions</th>
            </tr>
          </thead>
          <tbody>
            {filteredResults.map((result) => (
              <tr
                key={result.id}
                className={`border-t ${result.is_modified ? 'bg-yellow-50 dark:bg-yellow-900/20' : ''}`}
              >
                <td className="px-4 py-3 text-sm">{result.student_name}</td>
                <td className="px-4 py-3 text-sm">{result.class_name}</td>
                <td className="px-4 py-3 text-sm">{result.subject_name}</td>
                <td className="px-4 py-3 text-sm">{result.term_name}</td>
                <td className="px-4 py-3 text-sm">{result.result_type}</td>
                <td className="px-4 py-3">
                  <input
                    type="number"
                    min="0"
                    max="100"
                    value={result.score || ''}
                    onChange={(e) => updateResult(result.id, 'score', parseFloat(e.target.value) || null)}
                    className={`w-20 px-2 py-1 text-sm border rounded ${
                      result.score !== null && !validateScore(result.score) 
                        ? 'border-red-500' 
                        : 'border-gray-300'
                    }`}
                  />
                </td>
                <td className="px-4 py-3">
                  <input
                    type="text"
                    value={result.grade || ''}
                    onChange={(e) => updateResult(result.id, 'grade', e.target.value)}
                    className="w-16 px-2 py-1 text-sm border border-gray-300 rounded"
                  />
                </td>
                <td className="px-4 py-3">
                  <input
                    type="text"
                    value={result.remarks || ''}
                    onChange={(e) => updateResult(result.id, 'remarks', e.target.value)}
                    className="w-32 px-2 py-1 text-sm border border-gray-300 rounded"
                  />
                </td>
                <td className="px-4 py-3">
                  <button
                    onClick={() => loadAuditLogs(result.id)}
                    className="p-1 text-gray-600 hover:text-blue-600"
                    title="View History"
                  >
                    <History className="w-4 h-4" />
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Audit History Modal */}
      <Transition show={showHistory} as={React.Fragment}>
        <Dialog onClose={() => setShowHistory(false)} className="relative z-50">
          <Transition.Child
            enter="ease-out duration-300"
            enterFrom="opacity-0"
            enterTo="opacity-100"
            leave="ease-in duration-200"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <div className="fixed inset-0 bg-black/25" />
          </Transition.Child>

          <div className="fixed inset-0 overflow-y-auto">
            <div className="flex min-h-full items-center justify-center p-4">
              <Transition.Child
                enter="ease-out duration-300"
                enterFrom="opacity-0 scale-95"
                enterTo="opacity-100 scale-100"
                leave="ease-in duration-200"
                leaveFrom="opacity-100 scale-100"
                leaveTo="opacity-0 scale-95"
              >
                <Dialog.Panel className="w-full max-w-4xl bg-white dark:bg-gray-800 rounded-lg p-6">
                  <div className="flex items-center justify-between mb-4">
                    <Dialog.Title className="text-lg font-medium">
                      Edit History
                    </Dialog.Title>
                    <button
                      onClick={() => setShowHistory(false)}
                      className="text-gray-400 hover:text-gray-600"
                    >
                      <X className="w-5 h-5" />
                    </button>
                  </div>

                  <div className="space-y-4">
                    {auditLogs.map((log) => (
                      <div key={log.id} className="border rounded-lg p-4">
                        <div className="flex justify-between items-start">
                          <div>
                            <p className="font-medium">{log.actor_name}</p>
                            <p className="text-sm text-gray-600">{log.action}</p>
                            <p className="text-xs text-gray-500">
                              {new Date(log.created_at).toLocaleString()}
                            </p>
                          </div>
                          <div className="text-right">
                            <p className="text-xs text-gray-500">IP: {log.ip}</p>
                          </div>
                        </div>
                        {log.changes_json && (
                          <div className="mt-2 text-sm">
                            <pre className="bg-gray-100 dark:bg-gray-700 p-2 rounded text-xs overflow-auto">
                              {JSON.stringify(log.changes_json, null, 2)}
                            </pre>
                          </div>
                        )}
                      </div>
                    ))}
                  </div>
                </Dialog.Panel>
              </Transition.Child>
            </div>
          </div>
        </Dialog>
      </Transition>
    </div>
  );
};

export default EditResultsManager;

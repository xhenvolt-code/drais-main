'use client';

/**
 * Editable Initials Cell Component
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * 
 * Inline editable cell for subject initials in report templates.
 * 
 * Features:
 * - Click to edit
 * - Auto-save on blur/Enter
 * - Class-wide sync (single edit applies to all learners)
 * - Visual feedback during save
 * - Accessible (keyboard support)
 */

import React, { useState, useRef, useEffect } from 'react';
import { Loader2, Check, AlertCircle } from 'lucide-react';

interface EditableInitialsCellProps {
  classId: number;
  subjectId: number;
  currentInitials: string;
  subjectName: string;
  onSave?: (newInitials: string) => void;
  readOnly?: boolean;
  className?: string;
}

export function EditableInitialsCell({
  classId,
  subjectId,
  currentInitials,
  subjectName,
  onSave,
  readOnly = false,
  className = ''
}: EditableInitialsCellProps) {
  const [isEditing, setIsEditing] = useState(false);
  const [value, setValue] = useState(currentInitials);
  const [isSaving, setIsSaving] = useState(false);
  const [saveStatus, setSaveStatus] = useState<'idle' | 'success' | 'error'>('idle');
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const inputRef = useRef<HTMLInputElement>(null);

  // Focus input when entering edit mode
  useEffect(() => {
    if (isEditing && inputRef.current) {
      inputRef.current.focus();
      inputRef.current.select();
    }
  }, [isEditing]);

  const handleSave = async () => {
    if (value === currentInitials) {
      setIsEditing(false);
      return;
    }

    if (!value.trim()) {
      setErrorMessage('Initials cannot be empty');
      setSaveStatus('error');
      return;
    }

    if (value.length > 10) {
      setErrorMessage('Initials must be 10 characters or less');
      setSaveStatus('error');
      return;
    }

    setIsSaving(true);
    setSaveStatus('idle');
    setErrorMessage(null);

    try {
      const response = await fetch('/api/class-initials/update', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          classId,
          subjectId,
          initials: value.trim()
        })
      });

      if (!response.ok) {
        const data = await response.json();
        throw new Error(data.error || 'Failed to save initials');
      }

      setSaveStatus('success');
      onSave?.(value.trim());

      setTimeout(() => {
        setSaveStatus('idle');
        setIsEditing(false);
      }, 1500);
    } catch (error: any) {
      setErrorMessage(error.message);
      setSaveStatus('error');
    } finally {
      setIsSaving(false);
    }
  };

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      handleSave();
    } else if (e.key === 'Escape') {
      setValue(currentInitials);
      setIsEditing(false);
      setSaveStatus('idle');
    }
  };

  if (readOnly) {
    return (
      <div className={`text-center font-semibold ${className}`}
        title={`${subjectName} initials`}>
        {currentInitials}
      </div>
    );
  }

  if (isEditing) {
    return (
      <div className={`relative ${className}`}>
        <input
          ref={inputRef}
          type="text"
          value={value}
          onChange={(e) => setValue(e.target.value.toUpperCase())}
          onBlur={handleSave}
          onKeyDown={handleKeyDown}
          maxLength={10}
          className="w-full px-2 py-1 border border-blue-500 rounded text-center bg-blue-50 focus:outline-none focus:ring-2 focus:ring-blue-400"
          placeholder="Edit initials"
          disabled={isSaving}
        />
        {saveStatus === 'success' && (
          <Check className="absolute right-1 top-1 w-4 h-4 text-green-600" />
        )}
        {saveStatus === 'error' && (
          <AlertCircle className="absolute right-1 top-1 w-4 h-4 text-red-600" />
        )}
      </div>
    );
  }

  return (
    <div
      onClick={() => !isSaving && setIsEditing(true)}
      className={`
        relative text-center font-semibold p-2 rounded
        cursor-pointer transition-colors
        hover:bg-blue-50 hover:text-blue-700
        group
        ${className}
      `}
      title={`Click to edit ${subjectName} initials`}
    >
      {isSaving ? (
        <Loader2 className="inline w-4 h-4 animate-spin" />
      ) : (
        <>
          {currentInitials}
          <span className="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity bg-blue-50 rounded text-xs text-blue-600">
            Edit
          </span>
        </>
      )}

      {/* Error tooltip */}
      {saveStatus === 'error' && errorMessage && (
        <div className="absolute top-full left-0 mt-1 bg-red-100 text-red-800 text-xs p-2 rounded whitespace-nowrap border border-red-300 z-50">
          {errorMessage}
        </div>
      )}
    </div>
  );
}

/**
 * Editable Initials Row Component
 * Renders a full row of subject initials for inline editing
 */
interface EditableInitialsRowProps {
  classId: number;
  initials: Array<{
    subjectId: number;
    subjectName: string;
    displayInitials: string;
  }>;
  onBulkSave?: (updates: Array<{ subjectId: number; initials: string }>) => void;
  readOnly?: boolean;
}

export function EditableInitialsRow({
  classId,
  initials,
  onBulkSave,
  readOnly = false
}: EditableInitialsRowProps) {
  const [localInitials, setLocalInitials] = useState(
    Object.fromEntries(initials.map(i => [i.subjectId, i.displayInitials]))
  );

  const handleCellChange = (subjectId: number, newInitials: string) => {
    setLocalInitials(prev => ({
      ...prev,
      [subjectId]: newInitials
    }));

    // Trigger bulk save if callback provided
    const updates = Object.entries(localInitials).map(([subId, init]) => ({
      subjectId: parseInt(subId),
      initials: subjectId === parseInt(subId) ? newInitials : init as string
    }));

    onBulkSave?.(updates);
  };

  return (
    <div className="flex gap-2 flex-wrap">
      {initials.map(item => (
        <EditableInitialsCell
          key={item.subjectId}
          classId={classId}
          subjectId={item.subjectId}
          currentInitials={localInitials[item.subjectId] || item.displayInitials}
          subjectName={item.subjectName}
          onSave={(newInitials) => handleCellChange(item.subjectId, newInitials)}
          readOnly={readOnly}
          className="px-3 py-2 border rounded min-w-16"
        />
      ))}
    </div>
  );
}

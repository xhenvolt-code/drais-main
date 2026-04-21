'use client';

import React, { useState, useOptimistic, useTransition } from 'react';
import { updateResultScore } from '@/lib/actions/results';
import { toast } from 'react-hot-toast';

interface EditableScoreCellProps {
  resultId: number;
  initialScore: number | null;
  initialGrade?: string | null;
  initialRemarks?: string | null;
  onUpdate?: (newScore: number | null) => void;
}

export default function EditableScoreCell({ 
  resultId, 
  initialScore, 
  initialGrade, 
  initialRemarks,
  onUpdate 
}: EditableScoreCellProps) {
  const [isEditing, setIsEditing] = useState(false);
  const [editValue, setEditValue] = useState(initialScore?.toString() || '');
  const [isPending, startTransition] = useTransition();
  
  // Optimistic UI state
  const [optimisticScore, setOptimisticScore] = useOptimistic(
    initialScore,
    (currentScore, newScore: number | null) => newScore
  );

  const handleSave = async () => {
    const newScore = editValue === '' ? null : parseFloat(editValue);
    
    // Validation
    if (newScore !== null && (isNaN(newScore) || newScore < 0 || newScore > 100)) {
      toast.error('Score must be between 0 and 100');
      return;
    }

    setIsEditing(false);

    // Optimistic update
    startTransition(() => {
      setOptimisticScore(newScore);
    });

    try {
      const result = await updateResultScore(resultId, newScore, initialGrade, initialRemarks);
      
      if (result.success) {
        toast.success('Score updated successfully');
        onUpdate?.(newScore);
      } else {
        // Revert optimistic update on error
        setOptimisticScore(initialScore);
        toast.error(result.error || 'Failed to update score');
        setEditValue(initialScore?.toString() || '');
      }
    } catch (error) {
      // Revert optimistic update on error
      setOptimisticScore(initialScore);
      toast.error('Failed to update score');
      setEditValue(initialScore?.toString() || '');
    }
  };

  const handleCancel = () => {
    setIsEditing(false);
    setEditValue(initialScore?.toString() || '');
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter') {
      handleSave();
    } else if (e.key === 'Escape') {
      handleCancel();
    }
  };

  if (isEditing) {
    return (
      <div className="flex items-center gap-1">
        <input
          type="number"
          value={editValue}
          onChange={(e) => setEditValue(e.target.value)}
          onBlur={handleSave}
          onKeyDown={handleKeyDown}
          className="w-16 px-1 py-0.5 text-sm border rounded focus:outline-none focus:ring-1 focus:ring-blue-500"
          min="0"
          max="100"
          step="0.01"
          autoFocus
          disabled={isPending}
        />
        {isPending && (
          <div className="w-3 h-3 border border-blue-500 border-t-transparent rounded-full animate-spin" />
        )}
      </div>
    );
  }

  return (
    <div 
      className="cursor-pointer hover:bg-gray-100 px-2 py-1 rounded group"
      onClick={() => setIsEditing(true)}
      title="Click to edit score"
    >
      <span className={isPending ? 'opacity-50' : ''}>
        {optimisticScore ?? '-'}
      </span>
      <span className="ml-1 opacity-0 group-hover:opacity-50 text-xs">✏️</span>
    </div>
  );
}

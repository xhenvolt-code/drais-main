'use client';
import React from 'react';

interface ConflictIndicatorProps {
  hasConflict: boolean;
  conflictType?: 'teacher' | 'room' | 'student';
  conflictDetails?: string;
}

const ConflictIndicator: React.FC<ConflictIndicatorProps> = ({ 
  hasConflict, 
  conflictType = 'teacher',
  conflictDetails 
}) => {
  if (!hasConflict) return null;

  const getConflictIcon = () => {
    switch (conflictType) {
      case 'teacher':
        return '👤';
      case 'room':
        return '🏫';
      case 'student':
        return '👥';
      default:
        return '⚠️';
    }
  };

  const getConflictColor = () => {
    return 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200';
  };

  return (
    <span 
      className={`inline-flex items-center px-2 py-0.5 rounded text-xs font-medium ${getConflictColor()}`}
      title={conflictDetails || `${conflictType} conflict detected`}
    >
      <span className="mr-1">{getConflictIcon()}</span>
      Conflict
    </span>
  );
};

export default ConflictIndicator;

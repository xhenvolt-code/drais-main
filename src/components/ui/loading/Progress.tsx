interface ProgressProps {
  value: number;
  size?: 'sm' | 'md' | 'lg';
  showLabel?: boolean;
  description?: string;
  indeterminate?: boolean;
}

export function Progress({ 
  value, 
  size = 'md', 
  showLabel = true,
  description,
  indeterminate = false
}: ProgressProps) {
  const sizeClasses = {
    sm: 'w-32 h-1',
    md: 'w-64 h-2',
    lg: 'w-96 h-3'
  };

  return (
    <div className="flex flex-col gap-1">
      {showLabel && (
        <div className="flex justify-between text-xs text-slate-600 dark:text-slate-400">
          {description && <span>{description}</span>}
          <span>{Math.round(value)}%</span>
        </div>
      )}
      <div 
        role="progressbar" 
        aria-valuenow={indeterminate ? undefined : value}
        aria-valuemin={0}
        aria-valuemax={100}
        className={`${sizeClasses[size]} bg-slate-200 dark:bg-slate-800 rounded-full overflow-hidden`}
      >
        <div 
          className={`h-full bg-gradient-to-r from-indigo-600 via-fuchsia-600 to-pink-600 transition-all duration-300
            ${indeterminate ? 'animate-progress-indeterminate' : ''}`}
          style={!indeterminate ? { width: `${Math.max(0, Math.min(100, value))}%` } : undefined}
        />
      </div>
    </div>
  );
}

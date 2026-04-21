'use client';
import React, { createContext, useContext, useState } from 'react';
import { Skeleton } from './Skeleton';
import { Progress } from './Progress';

type LoadingContextType = {
  showSkeleton: (key: string) => void;
  hideSkeleton: (key: string) => void;
  startProgress: (key: string, total: number) => void;
  updateProgress: (key: string, current: number) => void;
  endProgress: (key: string) => void;
};

const LoadingContext = createContext<LoadingContextType | null>(null);

export function LoadingProvider({ children }: { children: React.ReactNode }) {
  const [skeletons, setSkeletons] = useState<Record<string, boolean>>({});
  const [progress, setProgress] = useState<Record<string, { current: number; total: number }>>({});
  const [longLoadingKeys, setLongLoadingKeys] = useState<Set<string>>(new Set());

  // Add loading management methods
  const contextValue = {
    showSkeleton: (key: string) => {
      setSkeletons(s => ({ ...s, [key]: true }));
      setTimeout(() => {
        setLongLoadingKeys(keys => new Set([...keys, key]));
      }, 5000);
    },
    hideSkeleton: (key: string) => {
      setSkeletons(s => ({ ...s, [key]: false }));
      setLongLoadingKeys(keys => {
        keys.delete(key);
        return new Set(keys);
      });
    },
    startProgress: (key: string, total: number) => {
      setProgress(p => ({ ...p, [key]: { current: 0, total } }));
    },
    updateProgress: (key: string, current: number) => {
      setProgress(p => ({ 
        ...p, 
        [key]: { ...p[key], current: Math.min(current, p[key].total) }
      }));
    },
    endProgress: (key: string) => {
      setProgress(p => {
        const newProgress = { ...p };
        delete newProgress[key];
        return newProgress;
      });
    }
  };

  return (
    <LoadingContext.Provider value={contextValue}>
      {children}
      {/* Skeleton Overlays */}
      {Object.entries(skeletons).map(([key, isLoading]) => 
        isLoading && (
          <div key={key} className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/20 backdrop-blur-sm">
            <Skeleton className="w-full max-w-2xl mx-4" />
            {longLoadingKeys.has(key) && (
              <div className="absolute bottom-4 left-0 right-0 text-center text-sm text-slate-600">
                Still loading... Check your connection or refresh the page.
              </div>
            )}
          </div>
        )
      )}
      {/* Progress Bars */}
      {Object.entries(progress).map(([key, { current, total }]) => (
        <div key={key} className="fixed bottom-4 right-4 z-50">
          <Progress value={(current / total) * 100} />
        </div>
      ))}
    </LoadingContext.Provider>
  );
}

export const useLoading = () => {
  const context = useContext(LoadingContext);
  if (!context) throw new Error('useLoading must be used within LoadingProvider');
  return context;
};

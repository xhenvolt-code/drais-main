"use client";
import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';

export const LoadingBar = () => {
  const [loading, setLoading] = useState(false);
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    let interval: NodeJS.Timeout;
    
    if (loading) {
      setProgress(10);
      interval = setInterval(() => {
        setProgress(prev => {
          if (prev >= 90) return prev;
          return prev + Math.random() * 10;
        });
      }, 200);
    } else {
      setProgress(100);
      setTimeout(() => setProgress(0), 200);
    }

    return () => {
      if (interval) clearInterval(interval);
    };
  }, [loading]);

  // Global loading state management
  useEffect(() => {
    const handleStart = () => setLoading(true);
    const handleComplete = () => setLoading(false);

    // Listen for navigation events
    window.addEventListener('beforeunload', handleStart);
    
    // Listen for custom loading events
    window.addEventListener('startLoading', handleStart);
    window.addEventListener('stopLoading', handleComplete);

    return () => {
      window.removeEventListener('beforeunload', handleStart);
      window.removeEventListener('startLoading', handleStart);
      window.removeEventListener('stopLoading', handleComplete);
    };
  }, []);

  if (progress === 0) return null;

  return (
    <div className="fixed top-0 left-0 right-0 z-[9999] h-1">
      <div 
        className="h-full bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 transition-all duration-200 ease-out"
        style={{ width: `${progress}%` }}
      />
    </div>
  );
};

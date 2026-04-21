'use client';
import React from 'react';

// Lightweight CSS-only shimmer animation
const shimmerClass = "relative overflow-hidden bg-slate-200 dark:bg-slate-700 before:absolute before:inset-0 before:-translate-x-full before:animate-[shimmer_2s_infinite] before:bg-gradient-to-r before:from-transparent before:via-white/60 before:to-transparent dark:before:via-slate-600/60";

export const DashboardKPISkeleton = () => (
  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
    {Array.from({ length: 4 }).map((_, i) => (
      <div key={i} className="bg-white dark:bg-slate-800 rounded-2xl p-6 shadow-lg border border-white/20">
        <div className="flex items-center justify-between">
          <div className="space-y-3 flex-1">
            <div className={`h-4 w-20 rounded ${shimmerClass}`} />
            <div className={`h-8 w-16 rounded ${shimmerClass}`} />
            <div className={`h-3 w-24 rounded ${shimmerClass}`} />
          </div>
          <div className={`w-12 h-12 rounded-xl ${shimmerClass}`} />
        </div>
      </div>
    ))}
  </div>
);

export const CardSkeleton = () => (
  <div className="bg-white dark:bg-slate-800 rounded-2xl p-6 shadow-lg border border-white/20">
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div className={`h-5 w-32 rounded ${shimmerClass}`} />
        <div className={`w-8 h-8 rounded-lg ${shimmerClass}`} />
      </div>
      <div className="space-y-3">
        <div className={`h-4 w-full rounded ${shimmerClass}`} />
        <div className={`h-4 w-3/4 rounded ${shimmerClass}`} />
        <div className={`h-4 w-1/2 rounded ${shimmerClass}`} />
      </div>
    </div>
  </div>
);

export const TableSkeleton = () => (
  <div className="bg-white dark:bg-slate-800 rounded-2xl shadow-lg border border-white/20 overflow-hidden">
    <div className="p-4 border-b border-slate-200 dark:border-slate-700">
      <div className={`h-6 w-48 rounded ${shimmerClass}`} />
    </div>
    <div className="divide-y divide-slate-200 dark:divide-slate-700">
      {Array.from({ length: 5 }).map((_, i) => (
        <div key={i} className="p-4 flex items-center space-x-4">
          <div className={`w-10 h-10 rounded-full ${shimmerClass}`} />
          <div className="flex-1 space-y-2">
            <div className={`h-4 w-full rounded ${shimmerClass}`} />
            <div className={`h-3 w-2/3 rounded ${shimmerClass}`} />
          </div>
          <div className={`h-6 w-16 rounded ${shimmerClass}`} />
        </div>
      ))}
    </div>
  </div>
);

export const PageSkeleton = () => (
  <div className="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-100 dark:from-slate-900 dark:via-slate-800 dark:to-indigo-900">
    <div className="container mx-auto px-4 py-8 space-y-8">
      <div className="flex items-center justify-between">
        <div className={`h-8 w-64 rounded ${shimmerClass}`} />
        <div className={`h-10 w-32 rounded-lg ${shimmerClass}`} />
      </div>
      <div className="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-8">
        {Array.from({ length: 6 }).map((_, i) => (
          <CardSkeleton key={i} />
        ))}
      </div>
    </div>
  </div>
);

export const StudentCardSkeleton = () => (
  <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 shadow-lg border border-white/20 animate-pulse">
    <div className="flex items-start justify-between mb-4">
      <div className="flex items-center space-x-3">
        <div className={`w-12 h-12 rounded-full ${shimmerClass}`} />
        <div className="flex-1 min-w-0 space-y-2">
          <div className={`h-4 w-32 rounded ${shimmerClass}`} />
          <div className={`h-3 w-24 rounded ${shimmerClass}`} />
          <div className={`h-3 w-16 rounded ${shimmerClass}`} />
        </div>
      </div>
      <div className={`w-6 h-6 rounded ${shimmerClass}`} />
    </div>
    
    <div className="space-y-4">
      {/* Progress Stats */}
      <div className="grid grid-cols-2 gap-4">
        <div className="text-center p-3 bg-slate-50 rounded-xl">
          <div className={`h-6 w-8 rounded mx-auto mb-2 ${shimmerClass}`} />
          <div className={`h-3 w-12 rounded mx-auto ${shimmerClass}`} />
        </div>
        <div className="text-center p-3 bg-slate-50 rounded-xl">
          <div className={`h-6 w-8 rounded mx-auto mb-2 ${shimmerClass}`} />
          <div className={`h-3 w-16 rounded mx-auto ${shimmerClass}`} />
        </div>
      </div>

      {/* Progress Bar */}
      <div className="space-y-2">
        <div className="flex items-center justify-between">
          <div className={`h-3 w-16 rounded ${shimmerClass}`} />
          <div className={`h-3 w-12 rounded ${shimmerClass}`} />
        </div>
        <div className={`w-full h-2 rounded-full ${shimmerClass}`} />
      </div>

      {/* Additional Info */}
      <div className="space-y-2">
        <div className="flex items-center justify-between">
          <div className={`h-3 w-12 rounded ${shimmerClass}`} />
          <div className={`h-3 w-20 rounded ${shimmerClass}`} />
        </div>
        <div className="flex items-center justify-between">
          <div className={`h-3 w-16 rounded ${shimmerClass}`} />
          <div className={`h-3 w-8 rounded ${shimmerClass}`} />
        </div>
      </div>

      {/* Status Badge */}
      <div className="flex items-center justify-between pt-2 border-t border-slate-100">
        <div className="flex items-center space-x-2">
          <div className={`w-4 h-4 rounded ${shimmerClass}`} />
          <div className={`h-3 w-24 rounded ${shimmerClass}`} />
        </div>
        <div className={`h-6 w-16 rounded-full ${shimmerClass}`} />
      </div>
    </div>
  </div>
);

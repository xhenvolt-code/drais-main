"use client";
import React from 'react';
import { motion } from 'framer-motion';
import clsx from 'clsx';

interface DashboardCardProps {
  title?: string;
  children: React.ReactNode;
  className?: string;
  headerActions?: React.ReactNode;
}

export default function DashboardCard({ 
  title, 
  children, 
  className,
  headerActions 
}: DashboardCardProps) {
  return (
    <motion.div
      layout
      className={clsx(
        "bg-white/80 dark:bg-slate-900/80 backdrop-blur-xl rounded-2xl border border-white/20 dark:border-gray-700/50 shadow-lg hover:shadow-xl transition-all duration-300",
        className
      )}
      whileHover={{ y: -2 }}
      transition={{ type: "spring", stiffness: 300, damping: 30 }}
    >
      {title && (
        <div className="flex items-center justify-between p-6 pb-4 border-b border-gray-100 dark:border-gray-700/50">
          <h3 className="text-lg font-semibold text-gray-900 dark:text-gray-100">
            {title}
          </h3>
          {headerActions && (
            <div className="flex items-center gap-2">
              {headerActions}
            </div>
          )}
        </div>
      )}
      <div className={clsx("p-6", title && "pt-4")}>
        {children}
      </div>
    </motion.div>
  );
}

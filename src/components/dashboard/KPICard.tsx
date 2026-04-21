"use client";
import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { TrendingUp, TrendingDown, ChevronDown, ChevronUp } from 'lucide-react';
import clsx from 'clsx';

interface KPICardProps {
  title: string;
  value: number;
  subtitle: string;
  trend: number;
  icon: React.ReactNode;
  color: 'blue' | 'green' | 'purple' | 'orange' | 'red';
  format?: 'number' | 'currency' | 'percentage';
  expertMode?: boolean;
  drillDownData?: Record<string, any>;
}

const colorClasses = {
  blue: {
    bg: 'from-blue-50 to-blue-100 dark:from-blue-900/20 dark:to-blue-800/20',
    text: 'text-blue-600 dark:text-blue-400',
    icon: 'text-blue-600',
    trend: 'text-blue-700 dark:text-blue-300'
  },
  green: {
    bg: 'from-green-50 to-green-100 dark:from-green-900/20 dark:to-green-800/20',
    text: 'text-green-600 dark:text-green-400',
    icon: 'text-green-600',
    trend: 'text-green-700 dark:text-green-300'
  },
  purple: {
    bg: 'from-purple-50 to-purple-100 dark:from-purple-900/20 dark:to-purple-800/20',
    text: 'text-purple-600 dark:text-purple-400',
    icon: 'text-purple-600',
    trend: 'text-purple-700 dark:text-purple-300'
  },
  orange: {
    bg: 'from-orange-50 to-orange-100 dark:from-orange-900/20 dark:to-orange-800/20',
    text: 'text-orange-600 dark:text-orange-400',
    icon: 'text-orange-600',
    trend: 'text-orange-700 dark:text-orange-300'
  },
  red: {
    bg: 'from-red-50 to-red-100 dark:from-red-900/20 dark:to-red-800/20',
    text: 'text-red-600 dark:text-red-400',
    icon: 'text-red-600',
    trend: 'text-red-700 dark:text-red-300'
  }
};

export default function KPICard({
  title,
  value,
  subtitle,
  trend,
  icon,
  color,
  format = 'number',
  expertMode = false,
  drillDownData
}: KPICardProps) {
  const [expanded, setExpanded] = useState(false);
  const classes = colorClasses[color];

  const formatValue = (val: number) => {
    if (format === 'currency') {
      return `UGX ${val.toLocaleString()}`;
    } else if (format === 'percentage') {
      return `${val.toFixed(1)}%`;
    }
    return val.toLocaleString();
  };

  const trendIcon = trend >= 0 ? TrendingUp : TrendingDown;
  const TrendIcon = trendIcon;

  return (
    <motion.div
      layout
      className={clsx(
        "relative overflow-hidden rounded-2xl bg-gradient-to-br border border-white/20 dark:border-gray-700/50 backdrop-blur-sm transition-all duration-300 hover:shadow-lg group",
        classes.bg
      )}
      whileHover={{ scale: 1.02, y: -2 }}
      transition={{ type: "spring", stiffness: 300, damping: 30 }}
    >
      <div className="p-6">
        <div className="flex items-start justify-between">
          <div className="flex-1">
            <h3 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
              {title}
            </h3>
            <div className="flex items-baseline gap-2">
              <span className={clsx("text-3xl font-bold", classes.text)}>
                {formatValue(value)}
              </span>
              {trend !== 0 && (
                <div className={clsx(
                  "flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium",
                  trend >= 0 
                    ? "bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400"
                    : "bg-red-100 dark:bg-red-900/30 text-red-700 dark:text-red-400"
                )}>
                  <TrendIcon className="w-3 h-3" />
                  {Math.abs(trend).toFixed(1)}%
                </div>
              )}
            </div>
            <p className="text-sm text-gray-600 dark:text-gray-400 mt-1">
              {subtitle}
            </p>
          </div>
          
          <div className={clsx("p-3 rounded-xl bg-white/50 dark:bg-slate-800/50", classes.icon)}>
            {icon}
          </div>
        </div>

        {/* Expert Mode Drill-down */}
        {expertMode && drillDownData && (
          <motion.div className="mt-4">
            <button
              onClick={() => setExpanded(!expanded)}
              className="flex items-center gap-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-200 transition-colors"
            >
              <span>View Details</span>
              {expanded ? <ChevronUp className="w-4 h-4" /> : <ChevronDown className="w-4 h-4" />}
            </button>

            <AnimatePresence>
              {expanded && (
                <motion.div
                  initial={{ height: 0, opacity: 0 }}
                  animate={{ height: 'auto', opacity: 1 }}
                  exit={{ height: 0, opacity: 0 }}
                  transition={{ duration: 0.2 }}
                  className="mt-3 pt-3 border-t border-white/30 dark:border-gray-600/30 overflow-hidden"
                >
                  <div className="grid grid-cols-2 gap-3">
                    {Object.entries(drillDownData).map(([key, val]) => (
                      <div key={key} className="text-center">
                        <p className="text-xs text-gray-500 dark:text-gray-400 capitalize">
                          {key.replace(/_/g, ' ')}
                        </p>
                        <p className="text-sm font-semibold text-gray-800 dark:text-gray-200 mt-1">
                          {typeof val === 'number' 
                            ? (key.includes('ratio') ? `${(val * 100).toFixed(1)}%` : val.toLocaleString())
                            : val
                          }
                        </p>
                      </div>
                    ))}
                  </div>
                </motion.div>
              )}
            </AnimatePresence>
          </motion.div>
        )}
      </div>

      {/* Hover effect overlay */}
      <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000 ease-out" />
    </motion.div>
  );
}

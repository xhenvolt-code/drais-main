"use client";
import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { 
  Sparkles, 
  X, 
  ChevronRight, 
  Users, 
  UserCheck, 
  CheckSquare, 
  Phone, 
  FileText, 
  Archive,
  Briefcase,
  Building,
  Clipboard
} from 'lucide-react';
import { useFeatureFlags } from '@/hooks/useFeatureFlags';
import Link from 'next/link';

const FeatureUpdateNotification: React.FC = () => {
  const [isVisible, setIsVisible] = useState(true);
  const [isExpanded, setIsExpanded] = useState(false);
  const { getNewFeaturesByCategory } = useFeatureFlags();
  
  const newFeatures = getNewFeaturesByCategory();
  const totalNewFeatures = Object.values(newFeatures).flat().length;

  // Don't show if no new features
  if (totalNewFeatures === 0 || !isVisible) {
    return null;
  }

  const getIconForRoute = (routeName: string) => {
    const iconMap: Record<string, React.ReactNode> = {
      'students-list': <Users className="w-4 h-4" />,
      'students-attendance': <UserCheck className="w-4 h-4" />,
      'students-requirements': <CheckSquare className="w-4 h-4" />,
      'students-contacts': <Phone className="w-4 h-4" />,
      'students-documents': <FileText className="w-4 h-4" />,
      'students-history': <Archive className="w-4 h-4" />,
      'staff-overview': <Briefcase className="w-4 h-4" />,
      'staff-list': <Briefcase className="w-4 h-4" />,
      'staff-add': <Users className="w-4 h-4" />,
      'staff-attendance': <UserCheck className="w-4 h-4" />,
      'departments': <Building className="w-4 h-4" />,
      'workplans': <Clipboard className="w-4 h-4" />,
    };
    return iconMap[routeName] || <Sparkles className="w-4 h-4" />;
  };

  return (
    <AnimatePresence>
      <motion.div
        initial={{ opacity: 0, y: -100, scale: 0.9 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        exit={{ opacity: 0, y: -100, scale: 0.9 }}
        transition={{ type: "spring", stiffness: 300, damping: 25 }}
        className="fixed top-20 right-4 left-4 md:left-auto md:w-96 z-50"
      >
        <div className="bg-white dark:bg-slate-800 rounded-2xl shadow-2xl border border-emerald-200 dark:border-emerald-800 overflow-hidden">
          {/* Header */}
          <div className="bg-gradient-to-r from-emerald-500 to-blue-500 p-4">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3">
                <motion.div
                  animate={{ rotate: [0, 15, -15, 0] }}
                  transition={{ duration: 2, repeat: Infinity, ease: [0.42, 0, 0.58, 1] as [number, number, number, number] }}
                >
                  <Sparkles className="w-6 h-6 text-white" />
                </motion.div>
                <div>
                  <h3 className="text-white font-bold text-lg">
                    New DRAIS Update!
                  </h3>
                  <p className="text-emerald-100 text-sm">
                    {totalNewFeatures} new features available
                  </p>
                </div>
              </div>
              <button
                onClick={() => setIsVisible(false)}
                className="text-white hover:bg-white/20 rounded-lg p-1 transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
            </div>
          </div>

          {/* Content */}
          <div className="p-4">
            <p className="text-gray-600 dark:text-gray-300 mb-4">
              Exciting new modules and features have been added to DRAIS! 
              Look for the <span className="inline-flex items-center gap-1 px-2 py-0.5 bg-emerald-100 text-emerald-800 rounded-full text-xs font-semibold">NEW</span> badges in the sidebar.
            </p>

            {/* Quick Overview */}
            <div className="grid grid-cols-2 gap-3 mb-4">
              {Object.entries(newFeatures).slice(0, 2).map(([category, features]) => (
                <div key={category} className="bg-gray-50 dark:bg-slate-700 rounded-lg p-3">
                  <h4 className="font-medium text-gray-900 dark:text-white capitalize mb-1">
                    {category}
                  </h4>
                  <p className="text-sm text-gray-600 dark:text-gray-300">
                    {features.length} new features
                  </p>
                </div>
              ))}
            </div>

            {/* Expandable Feature List */}
            <button
              onClick={() => setIsExpanded(!isExpanded)}
              className="w-full flex items-center justify-between p-2 rounded-lg hover:bg-gray-50 dark:hover:bg-slate-700 transition-colors"
            >
              <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
                View all features
              </span>
              <motion.div
                animate={{ rotate: isExpanded ? 90 : 0 }}
                transition={{ duration: 0.2 }}
              >
                <ChevronRight className="w-4 h-4" />
              </motion.div>
            </button>

            <AnimatePresence>
              {isExpanded && (
                <motion.div
                  initial={{ height: 0, opacity: 0 }}
                  animate={{ height: 'auto', opacity: 1 }}
                  exit={{ height: 0, opacity: 0 }}
                  transition={{ duration: 0.3 }}
                  className="overflow-hidden"
                >
                  <div className="mt-3 space-y-3 max-h-64 overflow-y-auto">
                    {Object.entries(newFeatures).map(([category, features]) => (
                      <div key={category}>
                        <h5 className="font-medium text-gray-900 dark:text-white capitalize mb-2 text-sm">
                          {category}
                        </h5>
                        <div className="space-y-1 ml-2">
                          {features.map((feature) => (
                            <Link
                              key={feature.id}
                              href={feature.route_path}
                              onClick={() => setIsVisible(false)}
                              className="flex items-center gap-2 p-2 rounded-lg hover:bg-emerald-50 dark:hover:bg-emerald-900/20 transition-colors group"
                            >
                              {getIconForRoute(feature.route_name)}
                              <div className="flex-1 min-w-0">
                                <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
                                  {feature.label}
                                </p>
                                {feature.description && (
                                  <p className="text-xs text-gray-500 dark:text-gray-400 truncate">
                                    {feature.description}
                                  </p>
                                )}
                              </div>
                              <motion.div
                                initial={{ opacity: 0, x: -10 }}
                                whileHover={{ opacity: 1, x: 0 }}
                                className="text-emerald-600"
                              >
                                <ChevronRight className="w-3 h-3" />
                              </motion.div>
                            </Link>
                          ))}
                        </div>
                      </div>
                    ))}
                  </div>
                </motion.div>
              )}
            </AnimatePresence>

            {/* Action Button */}
            <Link
              href="/dashboard"
              onClick={() => setIsVisible(false)}
              className="w-full mt-4 bg-gradient-to-r from-emerald-500 to-blue-500 text-white rounded-lg py-2 px-4 font-medium text-center inline-block hover:shadow-lg transition-all duration-200"
            >
              Explore New Features
            </Link>
          </div>
        </div>
      </motion.div>
    </AnimatePresence>
  );
};

export default FeatureUpdateNotification;

"use client";
import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { 
  BarChart3, 
  DollarSign, 
  Users, 
  Calendar,
  TrendingUp,
  Settings
} from 'lucide-react';
import StudentPerformanceAnalytics from './StudentPerformanceAnalytics';
import FinanceAnalytics from './FinanceAnalytics';
import AttendanceAnalytics from './AttendanceAnalytics';
import EnrollmentAnalytics from './EnrollmentAnalytics';
import DashboardCard from '@/components/dashboard/DashboardCard';

type AnalyticsTab = 'performance' | 'finance' | 'attendance' | 'enrollment';

interface DashboardAnalyticsProps {
  schoolId: string;
  termId?: string;
  classId?: string;
}

export default function DashboardAnalytics({ schoolId, termId, classId }: DashboardAnalyticsProps) {
  const [activeTab, setActiveTab] = useState<AnalyticsTab>('performance');
  const [dateRange, setDateRange] = useState('30');

  const tabs = [
    { id: 'performance' as const, label: 'Student Performance', icon: BarChart3, color: 'blue' },
    { id: 'finance' as const, label: 'Finance', icon: DollarSign, color: 'green' },
    { id: 'attendance' as const, label: 'Attendance', icon: Users, color: 'purple' },
    { id: 'enrollment' as const, label: 'Enrollment', icon: Calendar, color: 'orange' }
  ];

  const renderActiveAnalytics = () => {
    switch (activeTab) {
      case 'performance':
        return <StudentPerformanceAnalytics schoolId={schoolId} termId={termId} classId={classId} />;
      case 'finance':
        return <FinanceAnalytics schoolId={schoolId} termId={termId} />;
      case 'attendance':
        return <AttendanceAnalytics schoolId={schoolId} days={parseInt(dateRange)} />;
      case 'enrollment':
        return <EnrollmentAnalytics schoolId={schoolId} />;
      default:
        return null;
    }
  };

  return (
    <div className="space-y-6">
      {/* Header with Controls */}
      <DashboardCard>
        <div className="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
          <div>
            <h2 className="text-2xl font-bold text-gray-900 dark:text-gray-100 flex items-center gap-2">
              <TrendingUp className="w-6 h-6 text-blue-600" />
              School Analytics Dashboard
            </h2>
            <p className="text-gray-600 dark:text-gray-400 mt-1">
              Comprehensive insights and performance metrics for data-driven decisions
            </p>
          </div>
          
          <div className="flex items-center gap-4">
            {/* Date Range Selector for Attendance */}
            {activeTab === 'attendance' && (
              <select
                value={dateRange}
                onChange={(e) => setDateRange(e.target.value)}
                className="px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-sm"
              >
                <option value="7">Last 7 days</option>
                <option value="30">Last 30 days</option>
                <option value="90">Last 3 months</option>
                <option value="365">Last year</option>
              </select>
            )}
            
            <button className="p-2 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200">
              <Settings className="w-5 h-5" />
            </button>
          </div>
        </div>
      </DashboardCard>

      {/* Navigation Tabs */}
      <div className="bg-white dark:bg-gray-800 rounded-xl p-1 shadow-sm border border-gray-200 dark:border-gray-700">
        <div className="flex flex-wrap gap-1">
          {tabs.map((tab) => {
            const Icon = tab.icon;
            const isActive = activeTab === tab.id;
            
            return (
              <motion.button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`relative flex items-center gap-2 px-4 py-3 rounded-lg text-sm font-medium transition-all duration-200 ${
                  isActive
                    ? `bg-${tab.color}-50 dark:bg-${tab.color}-900/20 text-${tab.color}-600 dark:text-${tab.color}-400 shadow-sm`
                    : 'text-gray-600 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-700/50'
                }`}
                whileTap={{ scale: 0.98 }}
              >
                <Icon className="w-4 h-4" />
                {tab.label}
                {isActive && (
                  <motion.div
                    layoutId="activeTab"
                    className={`absolute inset-0 bg-${tab.color}-50 dark:bg-${tab.color}-900/20 rounded-lg -z-10`}
                    initial={false}
                    transition={{ type: "spring", stiffness: 500, damping: 30 }}
                  />
                )}
              </motion.button>
            );
          })}
        </div>
      </div>

      {/* Analytics Content */}
      <motion.div
        key={activeTab}
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3 }}
        className="min-h-[600px]"
      >
        {renderActiveAnalytics()}
      </motion.div>

      {/* Quick Insights Footer */}
      <DashboardCard>
        <div className="text-center p-6">
          <h3 className="text-lg font-semibold text-gray-900 dark:text-gray-100 mb-2">
            Analytics Insights
          </h3>
          <p className="text-gray-600 dark:text-gray-400 text-sm">
            These analytics provide real-time insights into school performance across multiple dimensions. 
            Use this data to identify trends, address issues early, and make informed decisions for student success.
          </p>
          <div className="flex justify-center mt-4 space-x-4 text-xs text-gray-500">
            <span>• Real-time data updates</span>
            <span>• Predictive insights</span>
            <span>• Drill-down capabilities</span>
            <span>• Export functionality</span>
          </div>
        </div>
      </DashboardCard>
    </div>
  );
}

"use client";
import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Filter, Download, Settings, Grid, BarChart3, Users, BookOpen } from 'lucide-react';

interface AdvancedDashboardProps {
  schoolId: number;
  dateRange: {
    from: string;
    to: string;
  };
}

const AdvancedDashboard: React.FC<AdvancedDashboardProps> = ({ schoolId, dateRange }) => {
  const [activeWidget, setActiveWidget] = useState<string | null>(null);
  const [filters, setFilters] = useState({
    class: '',
    stream: '',
    term: '',
    subject: '',
    teacher: ''
  });

  const widgets = [
    {
      id: 'leaderboard',
      title: 'Student Leaderboard',
      icon: Users,
      component: <div className="p-4 text-center text-gray-500">Leaderboard widget coming soon...</div>
    },
    {
      id: 'subject-mastery',
      title: 'Subject Mastery Tree',
      icon: BookOpen,
      component: <div className="p-4 text-center text-gray-500">Subject mastery widget coming soon...</div>
    },
    {
      id: 'performance-distribution',
      title: 'Performance Distribution',
      icon: BarChart3,
      component: <div className="p-4 text-center text-gray-500">Performance distribution widget coming soon...</div>
    },
    {
      id: 'fees-timeline',
      title: 'Fees Timeline',
      icon: BarChart3,
      component: <div className="p-4 text-center text-gray-500">Fees timeline widget coming soon...</div>
    }
  ];

  return (
    <div className="grid grid-cols-12 gap-6 h-[calc(100vh-200px)]">
      {/* Left Sidebar - Filters */}
      <div className="col-span-3 bg-white dark:bg-slate-800 rounded-2xl p-6 shadow-lg">
        <div className="flex items-center gap-2 mb-6">
          <Filter className="w-5 h-5 text-gray-600 dark:text-gray-400" />
          <h3 className="font-semibold text-gray-900 dark:text-white">Filters</h3>
        </div>

        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Class
            </label>
            <select
              value={filters.class}
              onChange={(e) => setFilters(prev => ({ ...prev, class: e.target.value }))}
              className="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 bg-white dark:bg-slate-700"
            >
              <option value="">All Classes</option>
              <option value="1">P.1</option>
              <option value="2">P.2</option>
              <option value="3">P.3</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Stream
            </label>
            <select
              value={filters.stream}
              onChange={(e) => setFilters(prev => ({ ...prev, stream: e.target.value }))}
              className="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 bg-white dark:bg-slate-700"
            >
              <option value="">All Streams</option>
              <option value="a">A</option>
              <option value="b">B</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Term
            </label>
            <select
              value={filters.term}
              onChange={(e) => setFilters(prev => ({ ...prev, term: e.target.value }))}
              className="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 bg-white dark:bg-slate-700"
            >
              <option value="">Current Term</option>
              <option value="1">Term 1</option>
              <option value="2">Term 2</option>
              <option value="3">Term 3</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Subject
            </label>
            <select
              value={filters.subject}
              onChange={(e) => setFilters(prev => ({ ...prev, subject: e.target.value }))}
              className="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 bg-white dark:bg-slate-700"
            >
              <option value="">All Subjects</option>
              <option value="math">Mathematics</option>
              <option value="english">English</option>
              <option value="science">Science</option>
            </select>
          </div>

          <button className="w-full px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
            Apply Filters
          </button>

          <button
            onClick={() => setFilters({ class: '', stream: '', term: '', subject: '', teacher: '' })}
            className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 rounded-lg hover:bg-gray-50 dark:hover:bg-slate-700 transition-colors"
          >
            Clear All
          </button>
        </div>
      </div>

      {/* Center - Visual Analytics Canvas */}
      <div className="col-span-6 bg-white dark:bg-slate-800 rounded-2xl p-6 shadow-lg">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center gap-2">
            <Grid className="w-5 h-5 text-gray-600 dark:text-gray-400" />
            <h3 className="font-semibold text-gray-900 dark:text-white">Analytics Canvas</h3>
          </div>
          <div className="flex gap-2">
            <button className="p-2 rounded-lg border border-gray-300 dark:border-gray-600 hover:bg-gray-50 dark:hover:bg-slate-700 transition-colors">
              <Settings className="w-4 h-4" />
            </button>
            <button className="p-2 rounded-lg border border-gray-300 dark:border-gray-600 hover:bg-gray-50 dark:hover:bg-slate-700 transition-colors">
              <Download className="w-4 h-4" />
            </button>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-4 h-[500px]">
          {widgets.map((widget, index) => (
            <motion.div
              key={widget.id}
              initial={{ opacity: 0, scale: 0.9 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: index * 0.1 }}
              className={`bg-gray-50 dark:bg-slate-700 rounded-xl border-2 border-dashed border-gray-300 dark:border-gray-600 cursor-pointer hover:border-blue-500 dark:hover:border-blue-400 transition-colors ${
                activeWidget === widget.id ? 'border-blue-500 dark:border-blue-400' : ''
              }`}
              onClick={() => setActiveWidget(widget.id)}
            >
              <div className="h-full flex flex-col">
                <div className="flex items-center gap-2 p-4 border-b border-gray-200 dark:border-gray-600">
                  <widget.icon className="w-4 h-4 text-gray-600 dark:text-gray-400" />
                  <h4 className="font-medium text-gray-900 dark:text-white text-sm">
                    {widget.title}
                  </h4>
                </div>
                <div className="flex-1">
                  {widget.component}
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      </div>

      {/* Right Sidebar - Context Panel */}
      <div className="col-span-3 bg-white dark:bg-slate-800 rounded-2xl p-6 shadow-lg">
        <h3 className="font-semibold text-gray-900 dark:text-white mb-6">Context Panel</h3>
        
        {activeWidget ? (
          <div className="space-y-4">
            <div className="p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg">
              <h4 className="font-medium text-blue-900 dark:text-blue-100 mb-2">
                Widget Details
              </h4>
              <p className="text-sm text-blue-700 dark:text-blue-300">
                Selected: {widgets.find(w => w.id === activeWidget)?.title}
              </p>
            </div>

            <div className="space-y-2">
              <h5 className="font-medium text-gray-900 dark:text-white">Quick Actions</h5>
              <button className="w-full px-3 py-2 text-sm bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
                Export Data
              </button>
              <button className="w-full px-3 py-2 text-sm border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 rounded-lg hover:bg-gray-50 dark:hover:bg-slate-700 transition-colors">
                Configure Widget
              </button>
            </div>
          </div>
        ) : (
          <div className="text-center py-8">
            <Grid className="w-12 h-12 text-gray-300 mx-auto mb-3" />
            <p className="text-gray-500 dark:text-gray-400 text-sm">
              Select a widget to view details and actions
            </p>
          </div>
        )}
      </div>
    </div>
  );
};

export default AdvancedDashboard;

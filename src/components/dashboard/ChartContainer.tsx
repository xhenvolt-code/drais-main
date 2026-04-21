"use client";
import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { 
  BarChart3, 
  LineChart as LineChartIcon, 
  PieChart as PieChartIcon, 
  Download,
  Maximize2,
  Filter,
  RefreshCw,
  TrendingUp,
  Users,
  BookOpen,
  DollarSign
} from 'lucide-react';
import DashboardCard from './DashboardCard';
import clsx from 'clsx';

interface ChartContainerProps {
  title: string;
  expertMode: boolean;
  data: any;
}

export default function ChartContainer({ title, expertMode, data }: ChartContainerProps) {
  const [chartType, setChartType] = useState<'bar' | 'line' | 'pie'>('bar');
  const [timeRange, setTimeRange] = useState('7d');

  // Mock chart data - replace with actual data processing
  const chartData = {
    labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    datasets: [
      {
        label: 'Students',
        data: [1142, 1156, 1138, 1161, 1149, 1167, 1158],
        color: '#3b82f6'
      },
      {
        label: 'Staff',
        data: [41, 42, 40, 43, 41, 42, 41],
        color: '#10b981'
      }
    ]
  };

  const SimpleChart = () => (
    <div className="h-64 flex items-center justify-center bg-gradient-to-br from-blue-50 to-purple-50 dark:from-blue-900/20 dark:to-purple-900/20 rounded-xl">
      <div className="text-center">
        <div className="flex justify-center gap-4 mb-4">
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 bg-blue-500 rounded"></div>
            <span className="text-sm font-medium">Attendance Trend</span>
          </div>
        </div>
        <div className="flex items-end justify-center gap-2 h-32">
          {chartData.labels.map((label, index) => (
            <div key={label} className="flex flex-col items-center gap-1">
              <div 
                className="w-8 bg-gradient-to-t from-blue-500 to-blue-400 rounded-t"
                style={{ 
                  height: `${(chartData.datasets[0].data[index] / Math.max(...chartData.datasets[0].data)) * 100}px` 
                }}
              />
              <span className="text-xs text-gray-500">{label}</span>
            </div>
          ))}
        </div>
        <p className="text-sm text-gray-600 dark:text-gray-400 mt-4">
          Weekly attendance overview
        </p>
      </div>
    </div>
  );

  const ExpertChart = () => (
    <div className="space-y-4">
      {/* Chart Controls */}
      <div className="flex flex-wrap items-center gap-3">
        <div className="flex items-center gap-2 bg-white/50 dark:bg-slate-800/50 rounded-lg p-1">
          {(['bar', 'line', 'pie'] as const).map((type) => {
            const Icon = type === 'bar' ? BarChart3 : type === 'line' ? LineChartIcon : PieChartIcon;
            return (
              <button
                key={type}
                onClick={() => setChartType(type)}
                className={clsx(
                  "p-2 rounded-md transition-all duration-200 capitalize",
                  chartType === type
                    ? "bg-blue-500 text-white shadow-sm"
                    : "hover:bg-white/50 dark:hover:bg-slate-700/50"
                )}
              >
                <Icon className="w-4 h-4" />
              </button>
            );
          })}
        </div>

        <select
          value={timeRange}
          onChange={(e) => setTimeRange(e.target.value)}
          className="px-3 py-2 rounded-lg border border-gray-200 dark:border-gray-700 bg-white/80 dark:bg-slate-800/80 text-sm"
        >
          <option value="7d">Last 7 Days</option>
          <option value="30d">Last 30 Days</option>
          <option value="90d">Last 3 Months</option>
          <option value="1y">Last Year</option>
        </select>

        <div className="flex items-center gap-2 ml-auto">
          <button className="p-2 rounded-lg hover:bg-white/50 dark:hover:bg-slate-700/50 transition-colors">
            <Filter className="w-4 h-4" />
          </button>
          <button className="p-2 rounded-lg hover:bg-white/50 dark:hover:bg-slate-700/50 transition-colors">
            <Download className="w-4 h-4" />
          </button>
          <button className="p-2 rounded-lg hover:bg-white/50 dark:hover:bg-slate-700/50 transition-colors">
            <Maximize2 className="w-4 h-4" />
          </button>
        </div>
      </div>

      {/* Advanced Chart */}
      <div className="h-80 bg-gradient-to-br from-gray-50 to-gray-100 dark:from-slate-800 dark:to-slate-700 rounded-xl p-6">
        <div className="h-full flex items-center justify-center">
          <div className="text-center">
            <div className="grid grid-cols-3 gap-8 mb-8">
              <div className="text-center">
                <Users className="w-8 h-8 text-blue-500 mx-auto mb-2" />
                <p className="text-2xl font-bold text-blue-600">1,247</p>
                <p className="text-sm text-gray-500">Total Students</p>
              </div>
              <div className="text-center">
                <BookOpen className="w-8 h-8 text-green-500 mx-auto mb-2" />
                <p className="text-2xl font-bold text-green-600">24</p>
                <p className="text-sm text-gray-500">Active Subjects</p>
              </div>
              <div className="text-center">
                <TrendingUp className="w-8 h-8 text-purple-500 mx-auto mb-2" />
                <p className="text-2xl font-bold text-purple-600">94.5%</p>
                <p className="text-sm text-gray-500">Avg. Attendance</p>
              </div>
            </div>
            
            {chartType === 'bar' && (
              <div className="flex items-end justify-center gap-3 h-32">
                {chartData.labels.map((label, index) => (
                  <div key={label} className="flex flex-col items-center gap-2">
                    <div className="flex flex-col gap-1">
                      <div 
                        className="w-6 bg-blue-500 rounded-t"
                        style={{ 
                          height: `${(chartData.datasets[0].data[index] / Math.max(...chartData.datasets[0].data)) * 80}px` 
                        }}
                      />
                      <div 
                        className="w-6 bg-green-500 rounded-t"
                        style={{ 
                          height: `${(chartData.datasets[1].data[index] / Math.max(...chartData.datasets[1].data)) * 40}px` 
                        }}
                      />
                    </div>
                    <span className="text-xs text-gray-500">{label}</span>
                  </div>
                ))}
              </div>
            )}
            
            {chartType === 'line' && (
              <div className="relative h-32 flex items-center justify-center">
                <svg className="w-full h-full" viewBox="0 0 300 100">
                  <polyline
                    fill="none"
                    stroke="#3b82f6"
                    strokeWidth="2"
                    points="20,80 60,70 100,75 140,65 180,70 220,60 260,65"
                  />
                  <polyline
                    fill="none"
                    stroke="#10b981"
                    strokeWidth="2"
                    points="20,90 60,85 100,88 140,82 180,85 220,80 260,82"
                  />
                </svg>
              </div>
            )}
            
            {chartType === 'pie' && (
              <div className="flex items-center justify-center h-32">
                <div className="relative w-24 h-24">
                  <svg className="w-full h-full transform -rotate-90" viewBox="0 0 100 100">
                    <circle cx="50" cy="50" r="40" fill="transparent" stroke="#e5e7eb" strokeWidth="10"/>
                    <circle cx="50" cy="50" r="40" fill="transparent" stroke="#3b82f6" strokeWidth="10" strokeDasharray="188" strokeDashoffset="47"/>
                  </svg>
                  <div className="absolute inset-0 flex items-center justify-center">
                    <span className="text-lg font-bold">75%</span>
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Chart Legend & Insights */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-blue-50 dark:bg-blue-900/20 rounded-lg p-4">
          <div className="flex items-center gap-2 mb-2">
            <div className="w-3 h-3 bg-blue-500 rounded-full"></div>
            <span className="text-sm font-medium">Student Attendance</span>
          </div>
          <p className="text-xs text-gray-600 dark:text-gray-400">
            Consistent upward trend with 94.5% average
          </p>
        </div>
        
        <div className="bg-green-50 dark:bg-green-900/20 rounded-lg p-4">
          <div className="flex items-center gap-2 mb-2">
            <div className="w-3 h-3 bg-green-500 rounded-full"></div>
            <span className="text-sm font-medium">Staff Attendance</span>
          </div>
          <p className="text-xs text-gray-600 dark:text-gray-400">
            Stable performance at 91.1% average rate
          </p>
        </div>
        
        <div className="bg-purple-50 dark:bg-purple-900/20 rounded-lg p-4">
          <div className="flex items-center gap-2 mb-2">
            <div className="w-3 h-3 bg-purple-500 rounded-full"></div>
            <span className="text-sm font-medium">Performance</span>
          </div>
          <p className="text-xs text-gray-600 dark:text-gray-400">
            5.2% improvement over last month
          </p>
        </div>
      </div>
    </div>
  );

  return (
    <DashboardCard title={title} className="h-fit">
      {expertMode ? <ExpertChart /> : <SimpleChart />}
    </DashboardCard>
  );
}

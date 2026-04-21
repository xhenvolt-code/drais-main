"use client";
import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { 
  Users, 
  UserCheck, 
  UserX, 
  Clock,
  Calendar,
  TrendingDown,
  AlertTriangle,
  BarChart3,
  TrendingUp,
  Target
} from 'lucide-react';
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, ScatterChart, Scatter } from 'recharts';
import DashboardCard from '@/components/dashboard/DashboardCard';
import LoadingPlaceholder from '@/components/dashboard/LoadingPlaceholder';

interface AttendanceData {
  studentAttendanceTrends: any[];
  chronicAbsentees: any[];
  staffAttendanceSummary: any[];
  dailyOverview: any[];
  attendancePerformanceCorrelation: any[];
  classAttendanceTrends?: any[];
  bestPerformingClass?: string;
  worstPerformingClass?: string;
  monthlyAverage?: number;
  attendanceGoal?: number;
}

export default function AttendanceAnalytics({ schoolId, days = 30 }: { 
  schoolId: string; 
  days?: number; 
}) {
  const [data, setData] = useState<AttendanceData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetchData();
  }, [schoolId, days]);

  const fetchData = async () => {
    try {
      setLoading(true);
      const params = new URLSearchParams({ 
        school_id: schoolId,
        days: days.toString()
      });
      
      const response = await fetch(`/api/analytics/attendance?${params}`);
      const result = await response.json();
      
      if (result.success) {
        setData(result.data);
      } else {
        setError(result.error || 'Failed to fetch data');
      }
    } catch (err) {
      setError('Network error occurred');
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <LoadingPlaceholder />;
  if (error) return <div className="text-red-500 p-4">Error: {error}</div>;
  if (!data) return <div className="p-4">No data available</div>;

  // Process data for charts
  const dailyTrends = data.dailyOverview.reduce((acc: any[], curr: any) => {
    const existingDate = acc.find(item => item.date === curr.date);
    if (existingDate) {
      existingDate[`${curr.type}_present`] = curr.present;
      existingDate[`${curr.type}_absent`] = curr.absent;
      existingDate[`${curr.type}_total`] = curr.total;
    } else {
      acc.push({
        date: new Date(curr.date).toLocaleDateString(),
        [`${curr.type}_present`]: curr.present,
        [`${curr.type}_absent`]: curr.absent,
        [`${curr.type}_total`]: curr.total
      });
    }
    return acc;
  }, []).reverse();

  const classAttendanceData = data.studentAttendanceTrends.reduce((acc: any[], curr: any) => {
    const existing = acc.find(item => item.class === curr.class_name);
    if (existing) {
      existing.attendance_rates.push(curr.attendance_rate);
    } else {
      acc.push({
        class: curr.class_name,
        attendance_rates: [curr.attendance_rate],
        avg_rate: curr.attendance_rate
      });
    }
    return acc;
  }, []).map(item => ({
    ...item,
    avg_rate: item.attendance_rates.reduce((sum: number, rate: number) => sum + rate, 0) / item.attendance_rates.length
  }));

  const correlationData = data.attendancePerformanceCorrelation.map(item => ({
    student: item.student_name,
    attendance: parseFloat(item.attendance_rate || 0),
    performance: parseFloat(item.avg_performance || 0)
  }));

  const avgAttendanceRate = data.chronicAbsentees.length > 0 
    ? data.chronicAbsentees.reduce((sum, student) => sum + parseFloat(student.attendance_rate || 0), 0) / data.chronicAbsentees.length
    : 0;

  const averageAttendance = data.dailyOverview.reduce((acc, day) => acc + day.present / day.total * 100, 0) / data.dailyOverview.length;
  const trend = data.dailyOverview.length > 0 
    ? ((data.dailyOverview[data.dailyOverview.length - 1].present / data.dailyOverview[data.dailyOverview.length - 1].total) - 
       (data.dailyOverview[0].present / data.dailyOverview[0].total)) * 100
    : 0;

  const getGoalProgress = () => {
    return data.monthlyAverage && data.attendanceGoal 
      ? (data.monthlyAverage / data.attendanceGoal) * 100 
      : 0;
  };

  const getPerformanceColor = (rate: number) => {
    if (rate >= 90) return 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400';
    if (rate >= 75) return 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-400';
    return 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-400';
  };

  return (
    <div className="space-y-6">
      {/* Overview Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="card p-6"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600 dark:text-gray-400">
                Average Attendance
              </p>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">
                {avgAttendanceRate.toFixed(1)}%
              </p>
              <div className="mt-2 w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                <div
                  className="bg-blue-600 h-2 rounded-full transition-all duration-300"
                  style={{ width: `${avgAttendanceRate}%` }}
                />
              </div>
            </div>
            <BarChart3 className="w-8 h-8 text-blue-600" />
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="card p-6"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600 dark:text-gray-400">
                Weekly Trend
              </p>
              <p className={`text-2xl font-bold ${trend >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                {trend >= 0 ? '+' : ''}{trend.toFixed(1)}%
              </p>
              <p className="text-xs text-gray-500 mt-1">
                vs last week
              </p>
            </div>
            {trend >= 0 ? (
              <TrendingUp className="w-8 h-8 text-green-600" />
            ) : (
              <TrendingDown className="w-8 h-8 text-red-600" />
            )}
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="card p-6"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600 dark:text-gray-400">
                At-Risk Students
              </p>
              <p className="text-2xl font-bold text-red-600">
                {data.chronicAbsentees.length}
              </p>
              <p className="text-xs text-gray-500 mt-1">
                Below 75% attendance
              </p>
            </div>
            <AlertTriangle className="w-8 h-8 text-red-600" />
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="card p-6"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600 dark:text-gray-400">
                Goal Progress
              </p>
              <p className="text-2xl font-bold text-purple-600">
                {getGoalProgress().toFixed(1)}%
              </p>
              <div className="mt-2 w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                <div
                  className="bg-purple-600 h-2 rounded-full transition-all duration-300"
                  style={{ width: `${getGoalProgress()}%` }}
                />
              </div>
            </div>
            <Target className="w-8 h-8 text-purple-600" />
          </div>
        </motion.div>
      </div>

      {/* Class Performance Breakdown */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.4 }}
        className="card"
      >
        <div className="p-6 border-b border-gray-200 dark:border-gray-600">
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white flex items-center gap-2">
            <BarChart3 className="w-5 h-5" />
            Class Performance
          </h3>
        </div>
        <div className="p-6">
          <div className="space-y-4">
            {(data.classAttendanceTrends || []).map((classData: any, index: number) => (
              <div key={index} className="flex items-center justify-between p-4 rounded-lg bg-gray-50 dark:bg-slate-700/50">
                <div className="flex-1">
                  <div className="flex items-center justify-between mb-2">
                    <span className="font-medium text-gray-900 dark:text-white">
                      {classData.class_name}
                    </span>
                    <div className="flex items-center gap-2">
                      <span className="text-sm text-gray-600 dark:text-gray-400">
                        {classData.present}/{classData.total}
                      </span>
                      <span className={`px-2 py-1 rounded-full text-xs font-medium ${getPerformanceColor(classData.avg_rate)}`}>
                        {classData.avg_rate.toFixed(1)}%
                      </span>
                    </div>
                  </div>
                  <div className="w-full bg-gray-200 dark:bg-gray-600 rounded-full h-3">
                    <div
                      className={`h-3 rounded-full transition-all duration-500 ${
                        classData.avg_rate >= 90 ? 'bg-green-500' :
                        classData.avg_rate >= 75 ? 'bg-yellow-500' : 'bg-red-500'
                      }`}
                      style={{ width: `${classData.avg_rate}%` }}
                    />
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </motion.div>

      {/* Performance Insights */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* Best Performing */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.5 }}
          className="card p-6"
        >
          <div className="flex items-center gap-3 mb-4">
            <div className="w-10 h-10 bg-green-100 dark:bg-green-900/30 rounded-lg flex items-center justify-center">
              <TrendingUp className="w-5 h-5 text-green-600" />
            </div>
            <div>
              <h4 className="font-semibold text-gray-900 dark:text-white">Best Performing</h4>
              <p className="text-sm text-gray-600 dark:text-gray-400">Highest attendance rate</p>
            </div>
          </div>
          <p className="text-xl font-bold text-green-600">{data.bestPerformingClass}</p>
        </motion.div>

        {/* Needs Attention */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.6 }}
          className="card p-6"
        >
          <div className="flex items-center gap-3 mb-4">
            <div className="w-10 h-10 bg-red-100 dark:bg-red-900/30 rounded-lg flex items-center justify-center">
              <AlertTriangle className="w-5 h-5 text-red-600" />
            </div>
            <div>
              <h4 className="font-semibold text-gray-900 dark:text-white">Needs Attention</h4>
              <p className="text-sm text-gray-600 dark:text-gray-400">Lowest attendance rate</p>
            </div>
          </div>
          <p className="text-xl font-bold text-red-600">{data.worstPerformingClass}</p>
        </motion.div>
      </div>

      {/* Low Attendance Students */}
      {data.chronicAbsentees.length > 0 && (
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.7 }}
          className="card"
        >
          <div className="p-6 border-b border-gray-200 dark:border-gray-600">
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white flex items-center gap-2">
              <AlertTriangle className="w-5 h-5 text-red-600" />
              Students Below 75% Attendance
            </h3>
          </div>
          <div className="p-6">
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {data.chronicAbsentees.map((student) => (
                <div key={student.student_id} className="bg-red-50 dark:bg-red-900/20 p-4 rounded-lg">
                  <div className="font-medium text-gray-900 dark:text-white">
                    {student.student_name}
                  </div>
                  <div className="text-sm text-gray-600 dark:text-gray-400">
                    {student.class_name}
                  </div>
                  <div className="text-red-600 font-bold text-lg">
                    {parseFloat(student.attendance_rate).toFixed(1)}%
                  </div>
                  <div className="mt-2 w-full bg-red-200 dark:bg-red-800 rounded-full h-2">
                    <div
                      className="bg-red-500 h-2 rounded-full"
                      style={{ width: `${parseFloat(student.attendance_rate) }%` }}
                    />
                  </div>
                </div>
              ))}
            </div>
          </div>
        </motion.div>
      )}

      {/* Monthly Summary */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.8 }}
        className="card p-6"
      >
        <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4 flex items-center gap-2">
          <Calendar className="w-5 h-5" />
          Monthly Summary
        </h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="text-center">
            <div className="text-2xl font-bold text-blue-600">
              {data.monthlyAverage?.toFixed(1) || '0.0'}%
            </div>
            <div className="text-sm text-gray-600 dark:text-gray-400">Monthly Average</div>
          </div>
          <div className="text-center">
            <div className="text-2xl font-bold text-green-600">
              {data.attendanceGoal || 0}%
            </div>
            <div className="text-sm text-gray-600 dark:text-gray-400">Target Goal</div>
          </div>
          <div className="text-center">
            <div className={`text-2xl font-bold ${(data.monthlyAverage || 0) >= (data.attendanceGoal || 0) ? 'text-green-600' : 'text-red-600'}`}>
              {(data.monthlyAverage || 0) >= (data.attendanceGoal || 0) ? '✓' : '✗'}
            </div>
            <div className="text-sm text-gray-600 dark:text-gray-400">Goal Status</div>
          </div>
        </div>
      </motion.div>

      {/* Low Attendance Students */}
      {data.chronicAbsentees.length > 0 && (
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.8 }}
          className="card"
        >
          <div className="p-6 border-b border-gray-200 dark:border-gray-600">
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white flex items-center gap-2">
              <AlertTriangle className="w-5 h-5 text-red-600" />
              Students Below 75% Attendance
            </h3>
          </div>
          <div className="divide-y divide-gray-200 dark:divide-gray-600">
            {data.chronicAbsentees.map((student: any) => (
              <div key={student.student_id} className="p-6 flex items-center justify-between">
                <span className="font-medium text-gray-900 dark:text-white">
                  {student.student_name}
                </span>
                <span className="text-red-600 font-bold">
                  {parseFloat(student.attendance_rate).toFixed(1)}%
                </span>
              </div>
            ))}
          </div>
        </motion.div>
      )}
    </div>
  );
}

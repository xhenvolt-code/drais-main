"use client";
import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { 
  TrendingUp, 
  TrendingDown, 
  AlertTriangle, 
  Award,
  BarChart3,
  Users,
  Target,
  BookOpen
} from 'lucide-react';
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, PieChart, Pie, Cell } from 'recharts';
import DashboardCard from '@/components/dashboard/DashboardCard';
import LoadingPlaceholder from '@/components/dashboard/LoadingPlaceholder';

interface PerformanceData {
  performanceTrends: any[];
  atRiskStudents: any[];
  topPerformers: any[];
  subjectPerformance: any[];
}

const COLORS = ['#3b82f6', '#ef4444', '#10b981', '#f59e0b', '#8b5cf6', '#06b6d4'];

export default function StudentPerformanceAnalytics({ schoolId, termId, classId }: { 
  schoolId: string; 
  termId?: string; 
  classId?: string; 
}) {
  const [data, setData] = useState<PerformanceData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetchData();
  }, [schoolId, termId, classId]);

  const fetchData = async () => {
    try {
      setLoading(true);
      const params = new URLSearchParams({ school_id: schoolId });
      if (termId) params.append('term_id', termId);
      if (classId) params.append('class_id', classId);
      
      const response = await fetch(`/api/analytics/student-performance?${params}`);
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
  const performanceTrendData = data.performanceTrends.reduce((acc: any[], curr: any) => {
    const existing = acc.find(item => item.subject_name === curr.subject_name);
    if (existing) {
      existing.scores.push({ score: curr.score, date: curr.created_at });
    } else {
      acc.push({
        subject_name: curr.subject_name,
        scores: [{ score: curr.score, date: curr.created_at }]
      });
    }
    return acc;
  }, []);

  const subjectAvgScores = data.subjectPerformance.map(item => ({
    subject: item.subject_name,
    avg_score: parseFloat(item.avg_score),
    excellent_rate: (item.excellent_count / item.student_count) * 100,
    failing_rate: (item.failing_count / item.student_count) * 100
  }));

  const riskDistribution = [
    { name: 'At Risk', value: data.atRiskStudents.length, color: '#ef4444' },
    { name: 'Top Performers', value: data.topPerformers.length, color: '#10b981' },
    { name: 'Average', value: Math.max(0, 100 - data.atRiskStudents.length - data.topPerformers.length), color: '#f59e0b' }
  ];

  return (
    <div className="space-y-6">
      {/* KPI Overview */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-gradient-to-r from-red-500 to-red-600 text-white rounded-xl p-6"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-red-100 text-sm">At Risk Students</p>
              <p className="text-3xl font-bold">{data.atRiskStudents.length}</p>
            </div>
            <AlertTriangle className="w-8 h-8 text-red-200" />
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="bg-gradient-to-r from-green-500 to-green-600 text-white rounded-xl p-6"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-green-100 text-sm">Top Performers</p>
              <p className="text-3xl font-bold">{data.topPerformers.length}</p>
            </div>
            <Award className="w-8 h-8 text-green-200" />
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="bg-gradient-to-r from-blue-500 to-blue-600 text-white rounded-xl p-6"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-blue-100 text-sm">Subjects Analyzed</p>
              <p className="text-3xl font-bold">{data.subjectPerformance.length}</p>
            </div>
            <BookOpen className="w-8 h-8 text-blue-200" />
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="bg-gradient-to-r from-purple-500 to-purple-600 text-white rounded-xl p-6"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-purple-100 text-sm">Avg Performance</p>
              <p className="text-3xl font-bold">
                {data.subjectPerformance.length > 0 
                  ? Math.round(data.subjectPerformance.reduce((sum, item) => sum + parseFloat(item.avg_score), 0) / data.subjectPerformance.length)
                  : 0}%
              </p>
            </div>
            <Target className="w-8 h-8 text-purple-200" />
          </div>
        </motion.div>
      </div>

      {/* Charts Section */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Subject Performance Chart */}
        <DashboardCard title="Subject Performance Overview">
          <div className="h-80">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={subjectAvgScores}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="subject" />
                <YAxis />
                <Tooltip 
                  formatter={(value, name) => [
                    `${parseFloat(value).toFixed(1)}%`, 
                    name.replace('_', ' ').replace(/\b\w/g, l => l.toUpperCase())
                  ]}
                />
                <Bar dataKey="avg_score" fill="#3b82f6" name="Average Score" />
                <Bar dataKey="excellent_rate" fill="#10b981" name="Excellence Rate" />
                <Bar dataKey="failing_rate" fill="#ef4444" name="Failure Rate" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </DashboardCard>

        {/* Performance Distribution */}
        <DashboardCard title="Performance Distribution">
          <div className="h-80">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={riskDistribution}
                  cx="50%"
                  cy="50%"
                  labelLine={false}
                  label={({ name, value }) => `${name}: ${value}`}
                  outerRadius={100}
                  fill="#8884d8"
                  dataKey="value"
                >
                  {riskDistribution.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </DashboardCard>
      </div>

      {/* Detailed Tables */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* At-Risk Students */}
        <DashboardCard title="Students Requiring Attention">
          <div className="space-y-3 max-h-96 overflow-y-auto">
            {data.atRiskStudents.slice(0, 10).map((student, index) => (
              <motion.div
                key={student.student_id}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: index * 0.1 }}
                className="flex items-center justify-between p-3 bg-red-50 dark:bg-red-900/20 rounded-lg border border-red-200 dark:border-red-800"
              >
                <div>
                  <p className="font-medium text-gray-900 dark:text-gray-100">
                    {student.student_name}
                  </p>
                  <p className="text-sm text-gray-600 dark:text-gray-400">
                    {student.class_name} • Avg: {parseFloat(student.avg_score || 0).toFixed(1)}%
                  </p>
                </div>
                <div className="text-right">
                  <p className="text-sm font-medium text-red-600 dark:text-red-400">
                    {student.failing_subjects} failing subjects
                  </p>
                  <p className="text-xs text-gray-500">
                    {parseFloat(student.attendance_count / Math.max(student.total_attendance_records, 1) * 100).toFixed(0)}% attendance
                  </p>
                </div>
              </motion.div>
            ))}
          </div>
        </DashboardCard>

        {/* Top Performers */}
        <DashboardCard title="Top Performing Students">
          <div className="space-y-3 max-h-96 overflow-y-auto">
            {data.topPerformers.slice(0, 10).map((student, index) => (
              <motion.div
                key={student.student_id}
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: index * 0.1 }}
                className="flex items-center justify-between p-3 bg-green-50 dark:bg-green-900/20 rounded-lg border border-green-200 dark:border-green-800"
              >
                <div>
                  <p className="font-medium text-gray-900 dark:text-gray-100">
                    {student.student_name}
                  </p>
                  <p className="text-sm text-gray-600 dark:text-gray-400">
                    {student.class_name} • Avg: {parseFloat(student.avg_score).toFixed(1)}%
                  </p>
                </div>
                <div className="text-right">
                  <p className="text-sm font-medium text-green-600 dark:text-green-400">
                    {student.excellent_subjects} excellent subjects
                  </p>
                  <div className="flex items-center text-xs text-green-600">
                    <Award className="w-3 h-3 mr-1" />
                    Top {index + 1}
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
        </DashboardCard>
      </div>
    </div>
  );
}

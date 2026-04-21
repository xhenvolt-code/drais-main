import React from 'react';
import { ResponsiveContainer, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, PieChart, Pie, Cell, LineChart, Line } from 'recharts';
import { Users, Calendar, BarChart3, TrendingUp, Award, Clock } from 'lucide-react';

const COLORS = ['#3B82F6', '#10B981', '#F59E0B', '#EF4444', '#8B5CF6', '#06B6D4', '#F97316'];

export const renderSummaryTemplate = (reportData: any) => (
  <div className="space-y-6">
    {/* Executive Header */}
    <div className="bg-gradient-to-r from-indigo-600 to-blue-600 text-white p-6 rounded-lg">
      <h1 className="text-2xl font-bold">{reportData?.schoolInfo.name}</h1>
      <p className="text-indigo-100">Executive Summary - {new Date().toLocaleDateString()}</p>
    </div>

    {/* Key Metrics Grid */}
    <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow-lg text-center">
        <Award className="w-12 h-12 text-yellow-500 mx-auto mb-3" />
        <h3 className="text-2xl font-bold text-gray-900 dark:text-white">{reportData?.analytics.overallGrade}</h3>
        <p className="text-gray-600 dark:text-gray-400">Overall Performance</p>
      </div>
      
      <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow-lg text-center">
        <Users className="w-12 h-12 text-blue-500 mx-auto mb-3" />
        <h3 className="text-2xl font-bold text-gray-900 dark:text-white">{reportData?.analytics.totalStudents}</h3>
        <p className="text-gray-600 dark:text-gray-400">Total Students</p>
      </div>
      
      <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow-lg text-center">
        <TrendingUp className="w-12 h-12 text-green-500 mx-auto mb-3" />
        <h3 className="text-2xl font-bold text-gray-900 dark:text-white">+{reportData?.analytics.improvementTrend.toFixed(1)}%</h3>
        <p className="text-gray-600 dark:text-gray-400">Improvement Rate</p>
      </div>
    </div>

    {/* Quick Stats */}
    <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow-lg">
      <h3 className="text-lg font-semibold mb-4">Performance Highlights</h3>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div className="flex justify-between items-center p-3 bg-green-50 dark:bg-green-900/20 rounded">
          <span className="text-gray-700 dark:text-gray-300">Average Attendance</span>
          <span className="font-bold text-green-600">{reportData?.analytics.averageAttendance.toFixed(1)}%</span>
        </div>
        <div className="flex justify-between items-center p-3 bg-blue-50 dark:bg-blue-900/20 rounded">
          <span className="text-gray-700 dark:text-gray-300">Class Performance</span>
          <span className="font-bold text-blue-600">Above Average</span>
        </div>
      </div>
    </div>
  </div>
);

export const renderVisualTemplate = (reportData: any) => (
  <div className="space-y-8">
    {/* Visual Header */}
    <div className="text-center">
      <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">
        {reportData?.schoolInfo.name}
      </h1>
      <p className="text-xl text-gray-600 dark:text-gray-400">Visual Analytics Dashboard</p>
    </div>

    {/* Charts Grid */}
    <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
      {/* Attendance Pie Chart */}
      <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow-lg">
        <h3 className="text-lg font-semibold mb-4">Attendance Distribution</h3>
        <ResponsiveContainer width="100%" height={300}>
          <PieChart>
            <Pie
              data={[
                { name: 'Present', value: reportData?.analytics.averageAttendance || 92 },
                { name: 'Absent', value: 100 - (reportData?.analytics.averageAttendance || 92) }
              ]}
              cx="50%"
              cy="50%"
              outerRadius={80}
              fill="#8884d8"
              dataKey="value"
              label
            >
              {[{}, {}].map((entry, index) => (
                <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
              ))}
            </Pie>
            <Tooltip />
            <Legend />
          </PieChart>
        </ResponsiveContainer>
      </div>

      {/* Performance Bar Chart */}
      <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow-lg">
        <h3 className="text-lg font-semibold mb-4">Subject Performance</h3>
        <ResponsiveContainer width="100%" height={300}>
          <BarChart data={reportData?.grades}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="subject" />
            <YAxis />
            <Tooltip />
            <Bar dataKey="average" fill="#3B82F6" />
          </BarChart>
        </ResponsiveContainer>
      </div>
    </div>

    {/* Infographic Section */}
    <div className="bg-gradient-to-r from-purple-500 to-pink-500 text-white p-8 rounded-lg">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6 text-center">
        <div>
          <div className="text-3xl font-bold">{reportData?.analytics.totalStudents}</div>
          <div className="text-purple-100">Students Enrolled</div>
        </div>
        <div>
          <div className="text-3xl font-bold">{reportData?.analytics.averageAttendance.toFixed(0)}%</div>
          <div className="text-purple-100">Attendance Rate</div>
        </div>
        <div>
          <div className="text-3xl font-bold">{reportData?.analytics.overallGrade}</div>
          <div className="text-purple-100">Average Grade</div>
        </div>
        <div>
          <div className="text-3xl font-bold">+{reportData?.analytics.improvementTrend.toFixed(1)}%</div>
          <div className="text-purple-100">Improvement</div>
        </div>
      </div>
    </div>
  </div>
);

export const renderProgressTemplate = (reportData: any) => (
  <div className="space-y-8">
    {/* Progress Header */}
    <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow-lg border-l-4 border-blue-500">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
            {reportData?.schoolInfo.name}
          </h1>
          <p className="text-gray-600 dark:text-gray-400">Student Progress Report</p>
        </div>
        <div className="text-right">
          <p className="text-sm text-gray-500">Report Period</p>
          <p className="font-semibold">{new Date().toLocaleDateString()}</p>
        </div>
      </div>
    </div>

    {/* Progress Timeline */}
    <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow-lg">
      <h3 className="text-lg font-semibold mb-6">Academic Progress Timeline</h3>
      <div className="space-y-6">
        {reportData?.students.slice(0, 5).map((student: any, index: number) => (
          <div key={student.id} className="flex items-center space-x-4">
            <div className="flex-shrink-0 w-12 h-12 rounded-full bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center">
              <span className="text-white font-medium">{student.name?.charAt(0)}</span>
            </div>
            <div className="flex-grow">
              <div className="flex items-center justify-between mb-2">
                <h4 className="font-medium text-gray-900 dark:text-white">{student.name}</h4>
                <span className="text-sm text-gray-500">{student.class}</span>
              </div>
              <div className="w-full bg-gray-200 rounded-full h-2">
                <div 
                  className="bg-gradient-to-r from-green-500 to-blue-500 h-2 rounded-full transition-all duration-300"
                  style={{ width: `${student.performance}%` }}
                ></div>
              </div>
              <div className="flex justify-between text-xs text-gray-500 mt-1">
                <span>Progress: {student.performance}%</span>
                <span>Grade: {student.grade}</span>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>

    {/* Monthly Progress Chart */}
    <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow-lg">
      <h3 className="text-lg font-semibold mb-4">Monthly Progress Trends</h3>
      <ResponsiveContainer width="100%" height={300}>
        <LineChart data={reportData?.attendance}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="month" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Line type="monotone" dataKey="rate" stroke="#10B981" strokeWidth={3} />
        </LineChart>
      </ResponsiveContainer>
    </div>

    {/* Parent-Friendly Summary */}
    <div className="bg-gradient-to-r from-green-50 to-blue-50 dark:from-green-900/20 dark:to-blue-900/20 p-6 rounded-lg border border-green-200 dark:border-green-700">
      <h3 className="text-lg font-semibold text-green-800 dark:text-green-300 mb-4">
        Parent Summary
      </h3>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <p className="text-sm text-gray-600 dark:text-gray-400 mb-2">Overall Performance</p>
          <p className="text-lg font-semibold text-gray-900 dark:text-white">
            Your child is performing {reportData?.analytics.overallGrade} with consistent improvement
          </p>
        </div>
        <div>
          <p className="text-sm text-gray-600 dark:text-gray-400 mb-2">Areas of Excellence</p>
          <p className="text-lg font-semibold text-gray-900 dark:text-white">
            Strong attendance and academic engagement
          </p>
        </div>
      </div>
    </div>
  </div>
);

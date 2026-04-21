"use client";
import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { 
  UserPlus, 
  UserMinus, 
  Users, 
  TrendingUp,
  MapPin,
  Calendar,
  Target
} from 'lucide-react';
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, PieChart, Pie, Cell } from 'recharts';
import DashboardCard from '@/components/dashboard/DashboardCard';
import LoadingPlaceholder from '@/components/dashboard/LoadingPlaceholder';

interface EnrollmentData {
  enrollmentByClass: any[];
  newAdmissions: any[];
  dropoutAnalysis: any[];
  retentionByYear: any[];
  geographicDistribution: any[];
  ageDistribution: any[];
}

const COLORS = ['#3b82f6', '#ef4444', '#10b981', '#f59e0b', '#8b5cf6', '#06b6d4'];

export default function EnrollmentAnalytics({ schoolId }: { schoolId: string }) {
  const [data, setData] = useState<EnrollmentData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetchData();
  }, [schoolId]);

  const fetchData = async () => {
    try {
      setLoading(true);
      const params = new URLSearchParams({ school_id: schoolId });
      
      const response = await fetch(`/api/analytics/enrollment?${params}`);
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

  // Calculate totals
  const totalActiveStudents = data.enrollmentByClass.reduce((sum, item) => sum + parseInt(item.active_students), 0);
  const totalInactiveStudents = data.enrollmentByClass.reduce((sum, item) => sum + parseInt(item.inactive_students), 0);
  const totalNewAdmissions = data.newAdmissions.reduce((sum, item) => sum + parseInt(item.new_admissions), 0);
  const avgRetentionRate = data.retentionByYear.length > 0 
    ? data.retentionByYear.reduce((sum, item) => sum + parseFloat(item.retention_rate), 0) / data.retentionByYear.length
    : 0;

  // Process data for charts
  const genderDistribution = [
    { 
      name: 'Male', 
      value: data.enrollmentByClass.reduce((sum, item) => sum + parseInt(item.male_students), 0),
      color: '#3b82f6'
    },
    { 
      name: 'Female', 
      value: data.enrollmentByClass.reduce((sum, item) => sum + parseInt(item.female_students), 0),
      color: '#ef4444'
    }
  ];

  const admissionTrends = data.newAdmissions.map(item => ({
    month: item.admission_month,
    total: parseInt(item.new_admissions),
    male: parseInt(item.male_admissions),
    female: parseInt(item.female_admissions)
  })).reverse();

  return (
    <div className="space-y-6">
      {/* Enrollment KPIs */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-gradient-to-r from-blue-500 to-blue-600 text-white rounded-xl p-6"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-blue-100 text-sm">Active Students</p>
              <p className="text-3xl font-bold">{totalActiveStudents.toLocaleString()}</p>
              <p className="text-xs text-blue-200">Currently enrolled</p>
            </div>
            <Users className="w-8 h-8 text-blue-200" />
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
              <p className="text-green-100 text-sm">New Admissions</p>
              <p className="text-3xl font-bold">{totalNewAdmissions}</p>
              <p className="text-xs text-green-200">Last 12 months</p>
            </div>
            <UserPlus className="w-8 h-8 text-green-200" />
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="bg-gradient-to-r from-purple-500 to-purple-600 text-white rounded-xl p-6"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-purple-100 text-sm">Retention Rate</p>
              <p className="text-3xl font-bold">{avgRetentionRate.toFixed(1)}%</p>
              <p className="text-xs text-purple-200">Average across years</p>
            </div>
            <Target className="w-8 h-8 text-purple-200" />
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="bg-gradient-to-r from-orange-500 to-orange-600 text-white rounded-xl p-6"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-orange-100 text-sm">Total Classes</p>
              <p className="text-3xl font-bold">{data.enrollmentByClass.length}</p>
              <p className="text-xs text-orange-200">Active classes</p>
            </div>
            <Calendar className="w-8 h-8 text-orange-200" />
          </div>
        </motion.div>
      </div>

      {/* Charts Section */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Enrollment by Class */}
        <DashboardCard title="Students by Class">
          <div className="h-80">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={data.enrollmentByClass} layout="horizontal">
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis type="number" />
                <YAxis dataKey="class_name" type="category" width={80} />
                <Tooltip />
                <Bar dataKey="active_students" fill="#10b981" name="Active" />
                <Bar dataKey="inactive_students" fill="#ef4444" name="Inactive" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </DashboardCard>

        {/* Gender Distribution */}
        <DashboardCard title="Gender Distribution">
          <div className="h-80">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={genderDistribution}
                  cx="50%"
                  cy="50%"
                  labelLine={false}
                  label={({ name, value, percent }: any) => `${name}: ${value} (${(percent * 100).toFixed(0)}%)`}
                  outerRadius={100}
                  fill="#8884d8"
                  dataKey="value"
                >
                  {genderDistribution.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </DashboardCard>

        {/* Admission Trends */}
        <DashboardCard title="Monthly Admission Trends">
          <div className="h-80">
            <ResponsiveContainer width="100%" height="100%">
              <LineChart data={admissionTrends}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="month" />
                <YAxis />
                <Tooltip />
                <Line type="monotone" dataKey="total" stroke="#3b82f6" name="Total" strokeWidth={2} />
                <Line type="monotone" dataKey="male" stroke="#10b981" name="Male" />
                <Line type="monotone" dataKey="female" stroke="#ef4444" name="Female" />
              </LineChart>
            </ResponsiveContainer>
          </div>
        </DashboardCard>

        {/* Age Distribution */}
        <DashboardCard title="Age Distribution">
          <div className="h-80">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={data.ageDistribution}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="age_group" />
                <YAxis />
                <Tooltip />
                <Bar dataKey="student_count" fill="#8b5cf6" name="Total Students" />
                <Bar dataKey="male_count" fill="#3b82f6" name="Male" />
                <Bar dataKey="female_count" fill="#ef4444" name="Female" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </DashboardCard>
      </div>

      {/* Detailed Tables */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Dropout Analysis */}
        <DashboardCard title="Dropout Analysis by Class">
          <div className="space-y-3 max-h-96 overflow-y-auto">
            {data.dropoutAnalysis.map((classData, index) => (
              <motion.div
                key={classData.class_name}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: index * 0.1 }}
                className={`p-3 rounded-lg border ${
                  parseFloat(classData.dropout_rate) > 15 ? 
                    'bg-red-50 border-red-200 dark:bg-red-900/20 dark:border-red-800' :
                  parseFloat(classData.dropout_rate) > 10 ? 
                    'bg-yellow-50 border-yellow-200 dark:bg-yellow-900/20 dark:border-yellow-800' :
                    'bg-green-50 border-green-200 dark:bg-green-900/20 dark:border-green-800'
                }`}
              >
                <div className="flex items-center justify-between">
                  <div>
                    <p className="font-medium text-gray-900 dark:text-gray-100">
                      {classData.class_name}
                    </p>
                    <p className="text-sm text-gray-600 dark:text-gray-400">
                      {classData.dropouts} of {classData.total_ever_enrolled} students
                    </p>
                  </div>
                  <div className="text-right">
                    <p className={`text-lg font-bold ${
                      parseFloat(classData.dropout_rate) > 15 ? 'text-red-600' :
                      parseFloat(classData.dropout_rate) > 10 ? 'text-yellow-600' : 'text-green-600'
                    }`}>
                      {parseFloat(classData.dropout_rate).toFixed(1)}%
                    </p>
                    <p className="text-xs text-gray-500">
                      Avg {parseInt(classData.avg_days_before_dropout || 0)} days enrolled
                    </p>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
        </DashboardCard>

        {/* Geographic Distribution */}
        <DashboardCard title="Geographic Distribution">
          <div className="space-y-3 max-h-96 overflow-y-auto">
            {data.geographicDistribution.slice(0, 10).map((location, index) => (
              <motion.div
                key={`${location.district_name}-${location.county_name}`}
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: index * 0.1 }}
                className="flex items-center justify-between p-3 bg-gray-50 dark:bg-gray-800 rounded-lg"
              >
                <div>
                  <p className="font-medium text-gray-900 dark:text-gray-100">
                    {location.district_name}
                  </p>
                  <p className="text-sm text-gray-600 dark:text-gray-400">
                    {location.county_name} County
                  </p>
                </div>
                <div className="text-right">
                  <p className="text-lg font-bold text-gray-900 dark:text-gray-100">
                    {location.student_count}
                  </p>
                  <p className="text-xs text-gray-500">
                    {location.male_count}M / {location.female_count}F
                  </p>
                </div>
              </motion.div>
            ))}
          </div>
        </DashboardCard>
      </div>

      {/* Retention by Academic Year */}
      <DashboardCard title="Retention Rates by Academic Year">
        <div className="h-64">
          <ResponsiveContainer width="100%" height="100%">
            <BarChart data={data.retentionByYear}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="academic_year" />
              <YAxis domain={[0, 100]} />
              <Tooltip 
                formatter={(value: any) => [`${parseFloat(value).toFixed(1)}%`, 'Retention Rate']}
              />
              <Bar dataKey="retention_rate" fill="#10b981" />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </DashboardCard>
    </div>
  );
}

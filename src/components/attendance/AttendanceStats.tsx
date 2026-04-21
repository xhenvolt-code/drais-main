"use client";
import React from 'react';
import { Users, UserCheck, UserX, Clock, Smartphone, Hand } from 'lucide-react';
import { motion } from 'framer-motion';

interface AttendanceStatsProps {
  stats: {
    present?: number;
    absent?: number;
    late?: number;
    not_marked?: number;
    total?: number;
    percentage?: number;
    biometric_count?: number;
    manual_count?: number;
  };
}

const AttendanceStats: React.FC<AttendanceStatsProps> = ({ stats }) => {
  const statCards = [
    {
      title: 'Total Students',
      value: stats.total || 0,
      icon: Users,
      color: 'bg-blue-500',
      gradient: 'from-blue-500 to-blue-600'
    },
    {
      title: 'Present',
      value: stats.present || 0,
      icon: UserCheck,
      color: 'bg-green-500',
      gradient: 'from-green-500 to-green-600'
    },
    {
      title: 'Absent',
      value: stats.absent || 0,
      icon: UserX,
      color: 'bg-red-500',
      gradient: 'from-red-500 to-red-600'
    },
    {
      title: 'Late',
      value: stats.late || 0,
      icon: Clock,
      color: 'bg-yellow-500',
      gradient: 'from-yellow-500 to-yellow-600'
    },
    {
      title: 'Biometric',
      value: stats.biometric_count || 0,
      icon: Smartphone,
      color: 'bg-purple-500',
      gradient: 'from-purple-500 to-purple-600'
    },
    {
      title: 'Manual',
      value: stats.manual_count || 0,
      icon: Hand,
      color: 'bg-indigo-500',
      gradient: 'from-indigo-500 to-indigo-600'
    }
  ];

  return (
    <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4 mb-8">
      {statCards.map((stat, index) => (
        <motion.div
          key={stat.title}
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: index * 0.1 }}
          className="relative overflow-hidden bg-white dark:bg-slate-800 rounded-2xl p-6 shadow-lg hover:shadow-xl transition-all duration-300 group"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600 dark:text-gray-400 mb-1">
                {stat.title}
              </p>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">
                {stat.value}
              </p>
            </div>
            <div className={`p-3 rounded-full bg-gradient-to-br ${stat.gradient} group-hover:scale-110 transition-transform duration-300`}>
              <stat.icon className="w-6 h-6 text-white" />
            </div>
          </div>
          
          {/* Percentage bar for attendance */}
          {stat.title === 'Present' && stats.total && stats.total > 0 && (
            <div className="mt-3">
              <div className="flex justify-between text-xs text-gray-600 dark:text-gray-400 mb-1">
                <span>Attendance Rate</span>
                <span>{stats.percentage}%</span>
              </div>
              <div className="w-full bg-gray-200 dark:bg-slate-700 rounded-full h-2">
                <motion.div
                  initial={{ width: 0 }}
                  animate={{ width: `${stats.percentage}%` }}
                  transition={{ delay: 0.5, duration: 0.8 }}
                  className={`h-2 rounded-full bg-gradient-to-r ${stat.gradient}`}
                />
              </div>
            </div>
          )}
          
          {/* Hover gradient */}
          <div className="absolute inset-0 bg-gradient-to-br from-white/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none" />
        </motion.div>
      ))}
    </div>
  );
};

export default AttendanceStats;

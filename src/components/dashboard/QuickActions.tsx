"use client";
import React from 'react';
import { motion } from 'framer-motion';
import { 
  UserPlus, 
  Plus, 
  ClipboardList, 
  DollarSign, 
  FileText,
  Calendar,
  Users,
  BookOpen,
  Award,
  Settings
} from 'lucide-react';
import DashboardCard from './DashboardCard';
import clsx from 'clsx';

interface QuickActionsProps {
  expertMode: boolean;
}

export default function QuickActions({ expertMode }: QuickActionsProps) {
  const basicActions = [
    { icon: UserPlus, label: 'Add Student', href: '/students/add', color: 'blue' },
    { icon: ClipboardList, label: 'Take Attendance', href: '/attendance', color: 'green' },
    { icon: DollarSign, label: 'Record Payment', href: '/finance/payments', color: 'purple' },
    { icon: FileText, label: 'View Reports', href: '/reports', color: 'orange' }
  ];

  const expertActions = [
    ...basicActions,
    { icon: Plus, label: 'Add Staff', href: '/staff/add', color: 'indigo' },
    { icon: Calendar, label: 'Schedule Exam', href: '/exams/schedule', color: 'pink' },
    { icon: BookOpen, label: 'Manage Classes', href: '/classes', color: 'teal' },
    { icon: Award, label: 'Enter Results', href: '/results/enter', color: 'yellow' },
    { icon: Settings, label: 'System Settings', href: '/settings', color: 'gray' }
  ];

  const actions = expertMode ? expertActions : basicActions;

  const colorClasses = {
    blue: 'from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700',
    green: 'from-green-500 to-green-600 hover:from-green-600 hover:to-green-700',
    purple: 'from-purple-500 to-purple-600 hover:from-purple-600 hover:to-purple-700',
    orange: 'from-orange-500 to-orange-600 hover:from-orange-600 hover:to-orange-700',
    indigo: 'from-indigo-500 to-indigo-600 hover:from-indigo-600 hover:to-indigo-700',
    pink: 'from-pink-500 to-pink-600 hover:from-pink-600 hover:to-pink-700',
    teal: 'from-teal-500 to-teal-600 hover:from-teal-600 hover:to-teal-700',
    yellow: 'from-yellow-500 to-yellow-600 hover:from-yellow-600 hover:to-yellow-700',
    gray: 'from-gray-500 to-gray-600 hover:from-gray-600 hover:to-gray-700'
  };

  return (
    <DashboardCard title="Quick Actions">
      <div className={clsx(
        "grid gap-3",
        expertMode ? "grid-cols-2" : "grid-cols-1"
      )}>
        {actions.map((action, index) => (
          <motion.a
            key={action.label}
            href={action.href}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: index * 0.1 }}
            className={clsx(
              "flex items-center gap-3 p-4 rounded-xl bg-gradient-to-r text-white font-medium transition-all duration-300 hover:shadow-lg transform hover:scale-105 active:scale-95 group",
              colorClasses[action.color as keyof typeof colorClasses]
            )}
          >
            <action.icon className="w-5 h-5 group-hover:scale-110 transition-transform" />
            <span className="text-sm">{action.label}</span>
          </motion.a>
        ))}
      </div>
    </DashboardCard>
  );
}

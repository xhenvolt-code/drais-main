'use client';

import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { 
  ChevronDown, 
  ChevronUp, 
  TrendingUp, 
  AlertTriangle, 
  XCircle,
  Award,
  Users,
  CheckCircle2,
  Download,
  Printer
} from 'lucide-react';

interface Student {
  student_id: number;
  student_name: string;
  admission_no: string;
  class_name: string;
  total_marks: number;
  average_marks: number;
  division: number;
  divisionName: string;
  promotionStatus: string;
  recommendation: string;
  distinctions: number;
  credits: number;
  passes: number;
  failures: number;
}

interface PromotionSummaryProps {
  data: {
    isThirdTerm: boolean;
    termName: string;
    summary: {
      total: number;
      promoted: number;
      expectedToImprove: number;
      advisedToRepeat: number;
      promotionRate: string;
    };
    students: {
      promoted: Student[];
      expectedToImprove: Student[];
      advisedToRepeat: Student[];
      notApplicable: Student[];
    };
  };
  onPromoteStudents?: (studentIds: number[], newClassId: number) => void;
}

const PromotionSummaryNotification: React.FC<PromotionSummaryProps> = ({ data, onPromoteStudents }) => {
  const [expandedSection, setExpandedSection] = useState<string | null>(null);
  const [selectedStudents, setSelectedStudents] = useState<Set<number>>(new Set());

  if (!data.isThirdTerm) {
    return (
      <div className="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-xl p-4">
        <div className="flex items-center gap-3">
          <AlertTriangle className="w-6 h-6 text-blue-600" />
          <div>
            <h4 className="font-semibold text-blue-900 dark:text-blue-100">
              Promotion Status
            </h4>
            <p className="text-sm text-blue-700 dark:text-blue-300">
              Promotions are calculated at the end of 3rd term. Current term: {data.termName}
            </p>
          </div>
        </div>
      </div>
    );
  }

  const toggleSection = (section: string) => {
    setExpandedSection(expandedSection === section ? null : section);
  };

  const toggleStudentSelection = (studentId: number) => {
    const newSelection = new Set(selectedStudents);
    if (newSelection.has(studentId)) {
      newSelection.delete(studentId);
    } else {
      newSelection.add(studentId);
    }
    setSelectedStudents(newSelection);
  };

  const handleBulkPromotion = () => {
    if (selectedStudents.size === 0) {
      alert('Please select students to promote');
      return;
    }
    
    // In real implementation, get next class ID from user selection
    const nextClassId = 2; // Placeholder
    if (onPromoteStudents) {
      onPromoteStudents(Array.from(selectedStudents), nextClassId);
    }
  };

  const exportReport = () => {
    const reportData = {
      term: data.termName,
      summary: data.summary,
      students: data.students,
    };
    
    const blob = new Blob([JSON.stringify(reportData, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `promotion-report-${data.termName}.json`;
    a.click();
  };

  return (
    <div className="space-y-4">
      {/* Summary Header */}
      <motion.div
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        className="bg-gradient-to-br from-emerald-500 to-teal-600 text-white rounded-2xl p-6 shadow-xl"
      >
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center gap-3">
            <div className="p-3 bg-white/20 rounded-full">
              <Award className="w-8 h-8" />
            </div>
            <div>
              <h2 className="text-2xl font-bold">Promotion Summary - {data.termName}</h2>
              <p className="text-emerald-100">End of Year Academic Performance Review</p>
            </div>
          </div>
          <div className="flex gap-2">
            <button
              onClick={exportReport}
              className="p-2 bg-white/20 hover:bg-white/30 rounded-lg transition-colors"
              title="Export Report"
            >
              <Download className="w-5 h-5" />
            </button>
            <button
              onClick={() => window.print()}
              className="p-2 bg-white/20 hover:bg-white/30 rounded-lg transition-colors"
              title="Print"
            >
              <Printer className="w-5 h-5" />
            </button>
          </div>
        </div>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <div className="bg-white/10 rounded-lg p-4">
            <div className="text-3xl font-bold">{data.summary.total}</div>
            <div className="text-sm text-emerald-100">Total Students</div>
          </div>
          <div className="bg-white/10 rounded-lg p-4">
            <div className="text-3xl font-bold text-green-200">{data.summary.promoted}</div>
            <div className="text-sm text-emerald-100">Promoted</div>
          </div>
          <div className="bg-white/10 rounded-lg p-4">
            <div className="text-3xl font-bold text-yellow-200">{data.summary.expectedToImprove}</div>
            <div className="text-sm text-emerald-100">Need Support</div>
          </div>
          <div className="bg-white/10 rounded-lg p-4">
            <div className="text-3xl font-bold text-red-200">{data.summary.advisedToRepeat}</div>
            <div className="text-sm text-emerald-100">Advised Repeat</div>
          </div>
        </div>

        <div className="mt-4 pt-4 border-t border-white/20">
          <div className="text-sm text-emerald-100">Overall Promotion Rate</div>
          <div className="flex items-center gap-3 mt-1">
            <div className="flex-1 bg-white/20 rounded-full h-3">
              <div
                className="bg-white rounded-full h-3 transition-all duration-500"
                style={{ width: `${data.summary.promotionRate}%` }}
              />
            </div>
            <span className="text-2xl font-bold">{data.summary.promotionRate}%</span>
          </div>
        </div>
      </motion.div>

      {/* Promoted Students */}
      <ExpandableSection
        title="✅ Promoted Learners"
        subtitle={`Division I, II, or III - Ready for next level`}
        count={data.students.promoted.length}
        icon={CheckCircle2}
        color="green"
        isExpanded={expandedSection === 'promoted'}
        onToggle={() => toggleSection('promoted')}
      >
        <StudentList
          students={data.students.promoted}
          selectedStudents={selectedStudents}
          onToggleSelection={toggleStudentSelection}
          showSelection={true}
        />
        {selectedStudents.size > 0 && (
          <div className="mt-4 p-4 bg-green-50 dark:bg-green-900/20 rounded-lg flex items-center justify-between">
            <span className="text-sm font-medium text-green-800 dark:text-green-200">
              {selectedStudents.size} student(s) selected
            </span>
            <button
              onClick={handleBulkPromotion}
              className="px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg transition-colors flex items-center gap-2"
            >
              <TrendingUp className="w-4 h-4" />
              Execute Promotion
            </button>
          </div>
        )}
      </ExpandableSection>

      {/* Expected to Improve */}
      <ExpandableSection
        title="⚠️ Expected to Improve"
        subtitle="Division IV - Promoted with conditions"
        count={data.students.expectedToImprove.length}
        icon={AlertTriangle}
        color="yellow"
        isExpanded={expandedSection === 'improve'}
        onToggle={() => toggleSection('improve')}
      >
        <StudentList
          students={data.students.expectedToImprove}
          selectedStudents={selectedStudents}
          onToggleSelection={toggleStudentSelection}
        />
      </ExpandableSection>

      {/* Advised to Repeat */}
      <ExpandableSection
        title="❌ Advised to Repeat"
        subtitle="Below passing standard - Requires class repetition"
        count={data.students.advisedToRepeat.length}
        icon={XCircle}
        color="red"
        isExpanded={expandedSection === 'repeat'}
        onToggle={() => toggleSection('repeat')}
      >
        <StudentList
          students={data.students.advisedToRepeat}
          selectedStudents={selectedStudents}
          onToggleSelection={toggleStudentSelection}
        />
      </ExpandableSection>
    </div>
  );
};

// Expandable Section Component
const ExpandableSection: React.FC<{
  title: string;
  subtitle: string;
  count: number;
  icon: React.ComponentType<any>;
  color: 'green' | 'yellow' | 'red';
  isExpanded: boolean;
  onToggle: () => void;
  children: React.ReactNode;
}> = ({ title, subtitle, count, icon: Icon, color, isExpanded, onToggle, children }) => {
  const colorClasses = {
    green: {
      bg: 'bg-green-50 dark:bg-green-900/20',
      border: 'border-green-200 dark:border-green-800',
      text: 'text-green-900 dark:text-green-100',
      icon: 'text-green-600 dark:text-green-400',
    },
    yellow: {
      bg: 'bg-yellow-50 dark:bg-yellow-900/20',
      border: 'border-yellow-200 dark:border-yellow-800',
      text: 'text-yellow-900 dark:text-yellow-100',
      icon: 'text-yellow-600 dark:text-yellow-400',
    },
    red: {
      bg: 'bg-red-50 dark:bg-red-900/20',
      border: 'border-red-200 dark:border-red-800',
      text: 'text-red-900 dark:text-red-100',
      icon: 'text-red-600 dark:text-red-400',
    },
  };

  const colors = colorClasses[color];

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className={`${colors.bg} border ${colors.border} rounded-xl overflow-hidden shadow-lg`}
    >
      <button
        onClick={onToggle}
        className="w-full p-6 flex items-center justify-between hover:opacity-80 transition-opacity"
      >
        <div className="flex items-center gap-4">
          <div className={`p-3 rounded-full bg-white dark:bg-slate-800 ${colors.icon}`}>
            <Icon className="w-6 h-6" />
          </div>
          <div className="text-left">
            <h3 className={`text-lg font-bold ${colors.text}`}>{title}</h3>
            <p className={`text-sm ${colors.text} opacity-75`}>{subtitle}</p>
          </div>
        </div>
        <div className="flex items-center gap-4">
          <div className={`px-4 py-2 rounded-full bg-white dark:bg-slate-800 ${colors.text} font-bold`}>
            {count} {count === 1 ? 'Student' : 'Students'}
          </div>
          {isExpanded ? (
            <ChevronUp className={`w-6 h-6 ${colors.icon}`} />
          ) : (
            <ChevronDown className={`w-6 h-6 ${colors.icon}`} />
          )}
        </div>
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
            <div className="p-6 pt-0">{children}</div>
          </motion.div>
        )}
      </AnimatePresence>
    </motion.div>
  );
};

// Student List Component
const StudentList: React.FC<{
  students: Student[];
  selectedStudents: Set<number>;
  onToggleSelection: (id: number) => void;
  showSelection?: boolean;
}> = ({ students, selectedStudents, onToggleSelection, showSelection = false }) => {
  if (students.length === 0) {
    return (
      <div className="text-center py-8 text-gray-500">
        No students in this category
      </div>
    );
  }

  return (
    <div className="space-y-2">
      {students.map((student) => (
        <div
          key={student.student_id}
          className="bg-white dark:bg-slate-800 rounded-lg p-4 shadow-sm hover:shadow-md transition-shadow"
        >
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3 flex-1">
              {showSelection && (
                <input
                  type="checkbox"
                  checked={selectedStudents.has(student.student_id)}
                  onChange={() => onToggleSelection(student.student_id)}
                  className="w-5 h-5 rounded border-gray-300 text-green-600 focus:ring-green-500"
                />
              )}
              <div className="flex-1">
                <div className="font-semibold text-gray-900 dark:text-white">
                  {student.student_name}
                  <span className="ml-2 text-sm text-gray-500">({student.admission_no})</span>
                </div>
                <div className="text-sm text-gray-600 dark:text-gray-400">
                  {student.class_name} • {student.divisionName}
                </div>
              </div>
            </div>
            <div className="text-right">
              <div className="text-lg font-bold text-gray-900 dark:text-white">
                {student.average_marks.toFixed(1)}%
              </div>
              <div className="text-xs text-gray-500">
                {student.distinctions}D • {student.credits}C • {student.failures}F
              </div>
            </div>
          </div>
          <div className="mt-2 text-sm text-gray-600 dark:text-gray-400 italic">
            {student.recommendation}
          </div>
        </div>
      ))}
    </div>
  );
};

export default PromotionSummaryNotification;

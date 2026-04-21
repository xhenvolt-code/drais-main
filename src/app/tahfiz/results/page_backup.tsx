'use client';

import React, { useState, useEffect, useCallback, useMemo } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import {
  Plus,
  Search,
  Filter,
  Edit3,
  Trash2,
  Info,
  BookOpen,
  Users,
  Target,
  TrendingUp,
  Award,
  Calendar,
  User,
  UserCheck,
  Copy,
  ChevronDown,
  ChevronUp,
  RotateCcw,
  Save,
  X
} from 'lucide-react';
import { Button } from '@/components/ui/Button';
import { Input } from '@/components/ui/Input';
import { Select } from '@/components/ui/Select';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { Modal } from '@/components/ui/Modal';
import { toast } from 'react-hot-toast';

interface TahfizResult {
  id: number;
  studentName: string;
  studentId: string;
  retentionScore: number;
  tajweedScore: number;
  voiceScore: number;
  disciplineScore: number;
  portionsCompleted: number;
  attendanceRate: number;
  overallPerformance: number;
  grade: string;
  remarks: string;
  teacher: string;
  group: string;
  dateRecorded: string;
}

interface TahfizLearner {
  id: number;
  studentId: string;
  firstName: string;
  lastName: string;
  fullName: string;
  groupId?: number;
  groupName?: string;
  currentLevel?: string;
  avatar?: string;
}

interface StudentFormData {
  studentId: string;
  retentionScore: string;
  tajweedScore: string;
  voiceScore: string;
  disciplineScore: string;
  portionsCompleted: string;
  attendanceRate: string;
  remarks: string;
}

type ModalMode = 'single' | 'multi';

const TahfizResultsPage = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [modalMode, setModalMode] = useState<ModalMode>('single');
  const [selectedResult, setSelectedResult] = useState<TahfizResult | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [filterResultType, setFilterResultType] = useState('all');
  const [isSubmitting, setIsSubmitting] = useState(false);

  // Student search and selection
  const [studentSearchTerm, setStudentSearchTerm] = useState('');
  const [selectedStudent, setSelectedStudent] = useState<TahfizLearner | null>(null);
  const [searchResults, setSearchResults] = useState<TahfizLearner[]>([]);
  const [isSearching, setIsSearching] = useState(false);

  // Multi-student mode
  const [tahfizLearners, setTahfizLearners] = useState<TahfizLearner[]>([]);
  const [multiStudentData, setMultiStudentData] = useState<Record<number, StudentFormData>>({});
  const [bulkScores, setBulkScores] = useState({
    retentionScore: '',
    tajweedScore: '',
    voiceScore: '',
    disciplineScore: '',
    portionsCompleted: '',
    attendanceRate: ''
  });
  const [expandedStudents, setExpandedStudents] = useState<Set<number>>(new Set());

  // Single student mode
  const [singleFormData, setSingleFormData] = useState<StudentFormData>({
    studentId: '',
    retentionScore: '',
    tajweedScore: '',
    voiceScore: '',
    disciplineScore: '',
    portionsCompleted: '',
    attendanceRate: '',
    remarks: ''
  });

  // Sample data
  const [results, setResults] = useState<TahfizResult[]>([
    {
      id: 1,
      studentName: 'Ahmed Hassan',
      studentId: 'STD001',
      retentionScore: 85,
      tajweedScore: 90,
      voiceScore: 88,
      disciplineScore: 92,
      portionsCompleted: 15,
      attendanceRate: 95,
      overallPerformance: 88.5,
      grade: 'A',
      remarks: 'Excellent progress in memorization',
      teacher: 'Ustadh Ibrahim',
      group: 'Advanced Group A',
      dateRecorded: '2024-01-15'
    }
  ]);

  // Mock tahfiz learners data
  const mockTahfizLearners: TahfizLearner[] = [
    { id: 1, studentId: 'TLR001', firstName: 'Muhammad', lastName: 'Ali', fullName: 'Muhammad Ali', groupName: 'Advanced Group A', currentLevel: 'Juz 5' },
    { id: 2, studentId: 'TLR002', firstName: 'Fatima', lastName: 'Ahmed', fullName: 'Fatima Ahmed', groupName: 'Intermediate Group B', currentLevel: 'Juz 3' },
    { id: 3, studentId: 'TLR003', firstName: 'Omar', lastName: 'Hassan', fullName: 'Omar Hassan', groupName: 'Advanced Group A', currentLevel: 'Juz 7' },
    { id: 4, studentId: 'TLR004', firstName: 'Aisha', lastName: 'Mohamed', fullName: 'Aisha Mohamed', groupName: 'Beginner Group C', currentLevel: 'Juz 1' },
    { id: 5, studentId: 'TLR005', firstName: 'Ibrahim', lastName: 'Abdullah', fullName: 'Ibrahim Abdullah', groupName: 'Intermediate Group B', currentLevel: 'Juz 4' },
  ];

  // Load tahfiz learners on component mount
  useEffect(() => {
    setTahfizLearners(mockTahfizLearners);
    
    // Initialize multi-student data
    const initialData: Record<number, StudentFormData> = {};
    mockTahfizLearners.forEach(learner => {
      initialData[learner.id] = {
        studentId: learner.studentId,
        retentionScore: '',
        tajweedScore: '',
        voiceScore: '',
        disciplineScore: '',
        portionsCompleted: '',
        attendanceRate: '',
        remarks: ''
      };
    });
    setMultiStudentData(initialData);
  }, []);

  // Search students with debouncing
  useEffect(() => {
    if (studentSearchTerm.length < 2) {
      setSearchResults([]);
      return;
    }

    const timeoutId = setTimeout(() => {
      setIsSearching(true);
      // Simulate API search
      const filtered = mockTahfizLearners.filter(learner =>
        learner.fullName.toLowerCase().includes(studentSearchTerm.toLowerCase()) ||
        learner.studentId.toLowerCase().includes(studentSearchTerm.toLowerCase())
      );
      setSearchResults(filtered);
      setIsSearching(false);
    }, 300);

    return () => clearTimeout(timeoutId);
  }, [studentSearchTerm]);

  // Calculate grade based on scores
  const calculateGrade = useCallback((scores: Partial<StudentFormData>) => {
    const average = (
      parseFloat(scores.retentionScore || '0') +
      parseFloat(scores.tajweedScore || '0') +
      parseFloat(scores.voiceScore || '0') +
      parseFloat(scores.disciplineScore || '0')
    ) / 4;

    if (average >= 90) return 'A+';
    if (average >= 80) return 'A';
    if (average >= 70) return 'B';
    if (average >= 60) return 'C';
    return 'D';
  }, []);

  // Generate remarks based on performance
  const generateRemarks = useCallback((scores: Partial<StudentFormData>) => {
    const average = (
      parseFloat(scores.retentionScore || '0') +
      parseFloat(scores.tajweedScore || '0') +
      parseFloat(scores.voiceScore || '0') +
      parseFloat(scores.disciplineScore || '0')
    ) / 4;

    if (average >= 90) return 'Outstanding performance in all areas';
    if (average >= 80) return 'Excellent progress with minor improvements needed';
    if (average >= 70) return 'Good performance, continue practicing';
    if (average >= 60) return 'Satisfactory, needs more focus on weak areas';
    return 'Needs significant improvement and additional support';
  }, []);

  // Handle modal opening
  const handleOpenModal = (mode: ModalMode) => {
    setModalMode(mode);
    setIsModalOpen(true);
    
    if (mode === 'multi') {
      // Expand first 3 students by default
      setExpandedStudents(new Set(tahfizLearners.slice(0, 3).map(l => l.id)));
    }
  };

  // Handle student selection in single mode
  const handleStudentSelect = (learner: TahfizLearner) => {
    setSelectedStudent(learner);
    setStudentSearchTerm(learner.fullName);
    setSingleFormData(prev => ({
      ...prev,
      studentId: learner.studentId
    }));
    setSearchResults([]);
  };

  // Handle bulk score application
  const applyBulkScores = () => {
    const updatedData = { ...multiStudentData };
    
    Object.keys(updatedData).forEach(studentIdStr => {
      const studentId = parseInt(studentIdStr);
      Object.entries(bulkScores).forEach(([field, value]) => {
        if (value && field !== 'remarks') {
          updatedData[studentId] = {
            ...updatedData[studentId],
            [field]: value
          };
        }
      });
    });
    
    setMultiStudentData(updatedData);
    toast.success('Bulk scores applied to all students');
  };

  // Handle individual student data update
  const updateStudentData = (studentId: number, field: keyof StudentFormData, value: string) => {
    setMultiStudentData(prev => ({
      ...prev,
      [studentId]: {
        ...prev[studentId],
        [field]: value
      }
    }));
  };

  // Toggle student expansion
  const toggleStudentExpansion = (studentId: number) => {
    setExpandedStudents(prev => {
      const newSet = new Set(prev);
      if (newSet.has(studentId)) {
        newSet.delete(studentId);
      } else {
        newSet.add(studentId);
      }
      return newSet;
    });
  };

  // Handle form submission
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);

    try {
      if (modalMode === 'single') {
        // Single student submission
        if (!selectedStudent) {
          toast.error('Please select a student');
          return;
        }

        const newResult: TahfizResult = {
          id: selectedResult ? selectedResult.id : Date.now(),
          studentName: selectedStudent.fullName,
          studentId: singleFormData.studentId,
          retentionScore: parseFloat(singleFormData.retentionScore),
          tajweedScore: parseFloat(singleFormData.tajweedScore),
          voiceScore: parseFloat(singleFormData.voiceScore),
          disciplineScore: parseFloat(singleFormData.disciplineScore),
          portionsCompleted: parseInt(singleFormData.portionsCompleted),
          attendanceRate: parseFloat(singleFormData.attendanceRate),
          overallPerformance: (
            parseFloat(singleFormData.retentionScore) +
            parseFloat(singleFormData.tajweedScore) +
            parseFloat(singleFormData.voiceScore) +
            parseFloat(singleFormData.disciplineScore)
          ) / 4,
          grade: calculateGrade(singleFormData),
          remarks: singleFormData.remarks || generateRemarks(singleFormData),
          teacher: 'Current Teacher',
          group: selectedStudent.groupName || 'Default Group',
          dateRecorded: new Date().toISOString().split('T')[0]
        };

        if (selectedResult) {
          setResults(results.map(r => r.id === selectedResult.id ? newResult : r));
          toast.success('Result updated successfully');
        } else {
          setResults([...results, newResult]);
          toast.success('Result added successfully');
        }
      } else {
        // Multi-student submission
        const newResults: TahfizResult[] = [];
        
        tahfizLearners.forEach(learner => {
          const studentData = multiStudentData[learner.id];
          
          // Skip if no scores entered
          if (!studentData.retentionScore && !studentData.tajweedScore && 
              !studentData.voiceScore && !studentData.disciplineScore) {
            return;
          }

          const newResult: TahfizResult = {
            id: Date.now() + learner.id,
            studentName: learner.fullName,
            studentId: learner.studentId,
            retentionScore: parseFloat(studentData.retentionScore || '0'),
            tajweedScore: parseFloat(studentData.tajweedScore || '0'),
            voiceScore: parseFloat(studentData.voiceScore || '0'),
            disciplineScore: parseFloat(studentData.disciplineScore || '0'),
            portionsCompleted: parseInt(studentData.portionsCompleted || '0'),
            attendanceRate: parseFloat(studentData.attendanceRate || '0'),
            overallPerformance: (
              parseFloat(studentData.retentionScore || '0') +
              parseFloat(studentData.tajweedScore || '0') +
              parseFloat(studentData.voiceScore || '0') +
              parseFloat(studentData.disciplineScore || '0')
            ) / 4,
            grade: calculateGrade(studentData),
            remarks: studentData.remarks || generateRemarks(studentData),
            teacher: 'Current Teacher',
            group: learner.groupName || 'Default Group',
            dateRecorded: new Date().toISOString().split('T')[0]
          };

          newResults.push(newResult);
        });

        setResults([...results, ...newResults]);
        toast.success(`${newResults.length} results added successfully`);
      }

      setIsModalOpen(false);
      resetForm();
    } catch (error) {
      toast.error('Failed to save results. Please try again.');
    } finally {
      setIsSubmitting(false);
    }
  };

  // Reset form data
  const resetForm = () => {
    setSingleFormData({
      studentId: '',
      retentionScore: '',
      tajweedScore: '',
      voiceScore: '',
      disciplineScore: '',
      portionsCompleted: '',
      attendanceRate: '',
      remarks: ''
    });
    setSelectedStudent(null);
    setStudentSearchTerm('');
    setSearchResults([]);
    setSelectedResult(null);
    
    // Reset multi-student data
    const initialData: Record<number, StudentFormData> = {};
    tahfizLearners.forEach(learner => {
      initialData[learner.id] = {
        studentId: learner.studentId,
        retentionScore: '',
        tajweedScore: '',
        voiceScore: '',
        disciplineScore: '',
        portionsCompleted: '',
        attendanceRate: '',
        remarks: ''
      };
    });
    setMultiStudentData(initialData);
    setBulkScores({
      retentionScore: '',
      tajweedScore: '',
      voiceScore: '',
      disciplineScore: '',
      portionsCompleted: '',
      attendanceRate: ''
    });
    setExpandedStudents(new Set());
  };

  const handleEdit = (result: TahfizResult) => {
    setSelectedResult(result);
    setSingleFormData({
      studentId: result.studentId,
      retentionScore: result.retentionScore.toString(),
      tajweedScore: result.tajweedScore.toString(),
      voiceScore: result.voiceScore.toString(),
      disciplineScore: result.disciplineScore.toString(),
      portionsCompleted: result.portionsCompleted.toString(),
      attendanceRate: result.attendanceRate.toString(),
      remarks: result.remarks
    });
    setModalMode('single');
    setIsModalOpen(true);
  };

  const handleDelete = (id: number) => {
    setResults(results.filter(r => r.id !== id));
    toast.success('Result deleted successfully');
  };

  const filteredResults = results.filter(result =>
    result.studentName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    result.studentId.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // Render single student form
  const renderSingleStudentForm = () => (
    <div className="space-y-6">
      {/* Student Search */}
      <div className="space-y-2">
        <label className="block text-sm font-medium text-slate-900 dark:text-white">
          Search Student
        </label>
        <div className="relative">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-slate-400" />
          <Input
            value={studentSearchTerm}
            onChange={(e) => setStudentSearchTerm(e.target.value)}
            placeholder="Type student name or ID..."
            className="pl-10"
          />
          {isSearching && (
            <div className="absolute right-3 top-1/2 transform -translate-y-1/2">
              <div className="w-4 h-4 border-2 border-blue-500 border-t-transparent rounded-full animate-spin"></div>
            </div>
          )}
        </div>

        {/* Search Results */}
        <AnimatePresence>
          {searchResults.length > 0 && (
            <motion.div
              initial={{ opacity: 0, y: -10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              className="absolute z-10 w-full bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-lg shadow-lg max-h-40 overflow-y-auto"
            >
              {searchResults.map((learner) => (
                <button
                  key={learner.id}
                  onClick={() => handleStudentSelect(learner)}
                  className="w-full px-4 py-2 text-left hover:bg-slate-50 dark:hover:bg-slate-700 flex items-center justify-between"
                >
                  <div>
                    <p className="font-medium text-slate-900 dark:text-white">
                      {learner.fullName}
                    </p>
                    <p className="text-sm text-slate-500">
                      {learner.studentId} • {learner.groupName}
                    </p>
                  </div>
                  <Badge variant="outline">{learner.currentLevel}</Badge>
                </button>
              ))}
            </motion.div>
          )}
        </AnimatePresence>
      </div>

      {/* Selected Student Info */}
      {selectedStudent && (
        <motion.div
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          className="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg"
        >
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 bg-blue-600 text-white rounded-full flex items-center justify-center font-semibold">
              {selectedStudent.firstName.charAt(0)}{selectedStudent.lastName.charAt(0)}
            </div>
            <div>
              <h3 className="font-semibold text-slate-900 dark:text-white">
                {selectedStudent.fullName}
              </h3>
              <p className="text-sm text-slate-600 dark:text-slate-400">
                {selectedStudent.studentId} • {selectedStudent.groupName} • {selectedStudent.currentLevel}
              </p>
            </div>
          </div>
        </motion.div>
      )}

      {/* Score Input Fields */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <label className="block text-sm font-medium mb-2">Retention Score (%)</label>
          <Input
            type="number"
            min="0"
            max="100"
            value={singleFormData.retentionScore}
            onChange={(e) => setSingleFormData({ ...singleFormData, retentionScore: e.target.value })}
            placeholder="0-100"
            required
          />
        </div>

        <div>
          <label className="block text-sm font-medium mb-2">Tajweed Score (%)</label>
          <Input
            type="number"
            min="0"
            max="100"
            value={singleFormData.tajweedScore}
            onChange={(e) => setSingleFormData({ ...singleFormData, tajweedScore: e.target.value })}
            placeholder="0-100"
            required
          />
        </div>

        <div>
          <label className="block text-sm font-medium mb-2">Voice & Pronunciation (%)</label>
          <Input
            type="number"
            min="0"
            max="100"
            value={singleFormData.voiceScore}
            onChange={(e) => setSingleFormData({ ...singleFormData, voiceScore: e.target.value })}
            placeholder="0-100"
            required
          />
        </div>

        <div>
          <label className="block text-sm font-medium mb-2">Discipline & Conduct (%)</label>
          <Input
            type="number"
            min="0"
            max="100"
            value={singleFormData.disciplineScore}
            onChange={(e) => setSingleFormData({ ...singleFormData, disciplineScore: e.target.value })}
            placeholder="0-100"
            required
          />
        </div>

        <div>
          <label className="block text-sm font-medium mb-2">Portions Completed</label>
          <Input
            type="number"
            min="0"
            value={singleFormData.portionsCompleted}
            onChange={(e) => setSingleFormData({ ...singleFormData, portionsCompleted: e.target.value })}
            placeholder="Number of portions"
            required
          />
        </div>

        <div>
          <label className="block text-sm font-medium mb-2">Attendance Rate (%)</label>
          <Input
            type="number"
            min="0"
            max="100"
            value={singleFormData.attendanceRate}
            onChange={(e) => setSingleFormData({ ...singleFormData, attendanceRate: e.target.value })}
            placeholder="0-100"
            required
          />
        </div>
      </div>

      {/* Remarks */}
      <div>
        <label className="block text-sm font-medium mb-2">Remarks (Optional)</label>
        <textarea
          className="w-full p-3 border border-slate-300 dark:border-slate-600 rounded-lg bg-white dark:bg-slate-800 text-slate-900 dark:text-white placeholder:text-slate-500 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          rows={3}
          value={singleFormData.remarks}
          onChange={(e) => setSingleFormData({ ...singleFormData, remarks: e.target.value })}
          placeholder="Additional comments about the student's performance"
        />
      </div>

      {/* Auto-calculated preview */}
      {(singleFormData.retentionScore || singleFormData.tajweedScore || singleFormData.voiceScore || singleFormData.disciplineScore) && (
        <div className="bg-slate-50 dark:bg-slate-800 p-4 rounded-lg">
          <h4 className="font-medium mb-2">Auto-calculated Results:</h4>
          <div className="grid grid-cols-2 gap-4 text-sm">
            <div>
              <span className="text-slate-600 dark:text-slate-400">Overall Performance:</span>
              <span className="ml-2 font-medium">
                {(
                  (parseFloat(singleFormData.retentionScore || '0') +
                   parseFloat(singleFormData.tajweedScore || '0') +
                   parseFloat(singleFormData.voiceScore || '0') +
                   parseFloat(singleFormData.disciplineScore || '0')) / 4
                ).toFixed(1)}%
              </span>
            </div>
            <div>
              <span className="text-slate-600 dark:text-slate-400">Grade:</span>
              <span className="ml-2 font-medium">{calculateGrade(singleFormData)}</span>
            </div>
          </div>
        </div>
      )}
    </div>
  );

  // Render multi-student form
  const renderMultiStudentForm = () => (
    <div className="space-y-6">
      {/* Bulk Score Input */}
      <Card className="p-4">
        <div className="flex items-center justify-between mb-4">
          <h3 className="font-semibold text-slate-900 dark:text-white">
            Bulk Score Entry
          </h3>
          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={applyBulkScores}
            className="flex items-center gap-2"
          >
            <Copy className="h-4 w-4" />
            Apply to All
          </Button>
        </div>
        
        <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
          <div>
            <label className="block text-xs font-medium mb-1">Retention (%)</label>
            <Input
              type="number"
              min="0"
              max="100"
              value={bulkScores.retentionScore}
              onChange={(e) => setBulkScores({ ...bulkScores, retentionScore: e.target.value })}
              placeholder="0-100"
              size="sm"
            />
          </div>
          
          <div>
            <label className="block text-xs font-medium mb-1">Tajweed (%)</label>
            <Input
              type="number"
              min="0"
              max="100"
              value={bulkScores.tajweedScore}
              onChange={(e) => setBulkScores({ ...bulkScores, tajweedScore: e.target.value })}
              placeholder="0-100"
              size="sm"
            />
          </div>

          <div>
            <label className="block text-xs font-medium mb-1">Voice (%)</label>
            <Input
              type="number"
              min="0"
              max="100"
              value={bulkScores.voiceScore}
              onChange={(e) => setBulkScores({ ...bulkScores, voiceScore: e.target.value })}
              placeholder="0-100"
              size="sm"
            />
          </div>

          <div>
            <label className="block text-xs font-medium mb-1">Discipline (%)</label>
            <Input
              type="number"
              min="0"
              max="100"
              value={bulkScores.disciplineScore}
              onChange={(e) => setBulkScores({ ...bulkScores, disciplineScore: e.target.value })}
              placeholder="0-100"
              size="sm"
            />
          </div>

          <div>
            <label className="block text-xs font-medium mb-1">Portions</label>
            <Input
              type="number"
              min="0"
              value={bulkScores.portionsCompleted}
              onChange={(e) => setBulkScores({ ...bulkScores, portionsCompleted: e.target.value })}
              placeholder="Portions"
              size="sm"
            />
          </div>

          <div>
            <label className="block text-xs font-medium mb-1">Attendance (%)</label>
            <Input
              type="number"
              min="0"
              max="100"
              value={bulkScores.attendanceRate}
              onChange={(e) => setBulkScores({ ...bulkScores, attendanceRate: e.target.value })}
              placeholder="0-100"
              size="sm"
            />
          </div>
        </div>
      </Card>

      {/* Students List */}
      <div className="space-y-3 max-h-96 overflow-y-auto">
        {tahfizLearners.map((learner) => {
          const isExpanded = expandedStudents.has(learner.id);
          const studentData = multiStudentData[learner.id];
          const hasScores = studentData?.retentionScore || studentData?.tajweedScore || 
                           studentData?.voiceScore || studentData?.disciplineScore;

          return (
            <motion.div
              key={learner.id}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              className="border border-slate-200 dark:border-slate-700 rounded-lg overflow-hidden"
            >
              {/* Student Header */}
              <div 
                className="p-4 bg-slate-50 dark:bg-slate-800 cursor-pointer flex items-center justify-between"
                onClick={() => toggleStudentExpansion(learner.id)}
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 bg-amber-600 text-white rounded-full flex items-center justify-center font-semibold text-sm">
                    {learner.firstName.charAt(0)}{learner.lastName.charAt(0)}
                  </div>
                  <div>
                    <h4 className="font-medium text-slate-900 dark:text-white">
                      {learner.fullName}
                    </h4>
                    <p className="text-sm text-slate-600 dark:text-slate-400">
                      {learner.studentId} • {learner.groupName}
                    </p>
                  </div>
                </div>
                
                <div className="flex items-center gap-2">
                  {hasScores && (
                    <Badge variant="success" size="sm">
                      Scored
                    </Badge>
                  )}
                  {isExpanded ? (
                    <ChevronUp className="h-4 w-4 text-slate-400" />
                  ) : (
                    <ChevronDown className="h-4 w-4 text-slate-400" />
                  )}
                </div>
              </div>

              {/* Student Form Fields */}
              <AnimatePresence>
                {isExpanded && (
                  <motion.div
                    initial={{ height: 0 }}
                    animate={{ height: 'auto' }}
                    exit={{ height: 0 }}
                    className="overflow-hidden"
                  >
                    <div className="p-4 space-y-4">
                      {/* Score Grid */}
                      <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
                        <div>
                          <label className="block text-xs font-medium mb-1">Retention (%)</label>
                          <Input
                            type="number"
                            min="0"
                            max="100"
                            value={studentData?.retentionScore || ''}
                            onChange={(e) => updateStudentData(learner.id, 'retentionScore', e.target.value)}
                            placeholder="0-100"
                            size="sm"
                          />
                        </div>

                        <div>
                          <label className="block text-xs font-medium mb-1">Tajweed (%)</label>
                          <Input
                            type="number"
                            min="0"
                            max="100"
                            value={studentData?.tajweedScore || ''}
                            onChange={(e) => updateStudentData(learner.id, 'tajweedScore', e.target.value)}
                            placeholder="0-100"
                            size="sm"
                          />
                        </div>

                        <div>
                          <label className="block text-xs font-medium mb-1">Voice (%)</label>
                          <Input
                            type="number"
                            min="0"
                            max="100"
                            value={studentData?.voiceScore || ''}
                            onChange={(e) => updateStudentData(learner.id, 'voiceScore', e.target.value)}
                            placeholder="0-100"
                            size="sm"
                          />
                        </div>

                        <div>
                          <label className="block text-xs font-medium mb-1">Discipline (%)</label>
                          <Input
                            type="number"
                            min="0"
                            max="100"
                            value={studentData?.disciplineScore || ''}
                            onChange={(e) => updateStudentData(learner.id, 'disciplineScore', e.target.value)}
                            placeholder="0-100"
                            size="sm"
                          />
                        </div>

                        <div>
                          <label className="block text-xs font-medium mb-1">Portions</label>
                          <Input
                            type="number"
                            min="0"
                            value={studentData?.portionsCompleted || ''}
                            onChange={(e) => updateStudentData(learner.id, 'portionsCompleted', e.target.value)}
                            placeholder="Portions"
                            size="sm"
                          />
                        </div>

                        <div>
                          <label className="block text-xs font-medium mb-1">Attendance (%)</label>
                          <Input
                            type="number"
                            min="0"
                            max="100"
                            value={studentData?.attendanceRate || ''}
                            onChange={(e) => updateStudentData(learner.id, 'attendanceRate', e.target.value)}
                            placeholder="0-100"
                            size="sm"
                          />
                        </div>
                      </div>

                      {/* Remarks */}
                      <div>
                        <label className="block text-xs font-medium mb-1">Remarks</label>
                        <textarea
                          className="w-full p-2 text-sm border border-slate-300 dark:border-slate-600 rounded-lg bg-white dark:bg-slate-800 text-slate-900 dark:text-white placeholder:text-slate-500 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                          rows={2}
                          value={studentData?.remarks || ''}
                          onChange={(e) => updateStudentData(learner.id, 'remarks', e.target.value)}
                          placeholder="Additional comments..."
                        />
                      </div>

                      {/* Preview */}
                      {hasScores && (
                        <div className="bg-amber-50 dark:bg-amber-900/20 p-3 rounded text-sm">
                          <div className="flex items-center justify-between">
                            <span className="text-slate-600 dark:text-slate-400">Average:</span>
                            <span className="font-medium">
                              {(
                                (parseFloat(studentData?.retentionScore || '0') +
                                 parseFloat(studentData?.tajweedScore || '0') +
                                 parseFloat(studentData?.voiceScore || '0') +
                                 parseFloat(studentData?.disciplineScore || '0')) / 4
                              ).toFixed(1)}%
                            </span>
                            <Badge variant="outline" size="sm">
                              {calculateGrade(studentData)}
                            </Badge>
                          </div>
                        </div>
                      )}
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>
            </motion.div>
          );
        })}
      </div>
    </div>
  );

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-slate-900 dark:text-white">
            Tahfiz Results Entry
          </h1>
          <p className="text-slate-600 dark:text-slate-300">
            Record and manage Tahfiz learner assessments and performance
          </p>
        </div>
        <div className="flex gap-3">
          <Button
            onClick={() => handleOpenModal('single')}
            variant="outline"
            className="flex items-center gap-2"
          >
            <User className="h-4 w-4" />
            Add Single Result
          </Button>
          <Button
            onClick={() => handleOpenModal('multi')}
            className="flex items-center gap-2"
          >
            <Users className="h-4 w-4" />
            Add Multiple Results
          </Button>
        </div>
      </div>

      {/* Additional Info Section */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card className="p-4">
          <div className="flex items-center gap-3">
            <BookOpen className="h-8 w-8 text-blue-600" />
            <div>
              <p className="text-sm text-slate-600 dark:text-slate-300">Books Studied</p>
              <p className="font-semibold">Quran</p>
            </div>
          </div>
        </Card>
        
        <Card className="p-4">
          <div className="flex items-center gap-3">
            <Target className="h-8 w-8 text-green-600" />
            <div>
              <p className="text-sm text-slate-600 dark:text-slate-300">Portions Completed</p>
              <p className="font-semibold">0</p>
            </div>
          </div>
        </Card>

        <Card className="p-4">
          <div className="flex items-center gap-3">
            <TrendingUp className="h-8 w-8 text-purple-600" />
            <div>
              <p className="text-sm text-slate-600 dark:text-slate-300">In Progress</p>
              <p className="font-semibold">0</p>
            </div>
          </div>
        </Card>

        <Card className="p-4">
          <div className="flex items-center gap-3">
            <Award className="h-8 w-8 text-orange-600" />
            <div>
              <p className="text-sm text-slate-600 dark:text-slate-300">Class Rank</p>
              <p className="font-semibold">1 out of 91</p>
            </div>
          </div>
        </Card>
      </div>

      {/* Filters */}
      <Card className="p-4">
        <div className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-slate-400" />
              <Input
                placeholder="Search by student name or ID..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="pl-10"
              />
            </div>
          </div>
          <Select
            value={filterResultType}
            onValueChange={setFilterResultType}
            options={[
              { value: 'all', label: 'All Results' },
              { value: 'monthly', label: 'Monthly' },
              { value: 'termly', label: 'Termly' },
              { value: 'annual', label: 'Annual' }
            ]}
          />
        </div>
      </Card>

      {/* Results Table */}
      <Card>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr className="border-b border-slate-200 dark:border-slate-700">
                <th className="text-left p-4 font-medium text-slate-900 dark:text-white">Student</th>
                <th className="text-left p-4 font-medium text-slate-900 dark:text-white">Retention</th>
                <th className="text-left p-4 font-medium text-slate-900 dark:text-white">Tajweed</th>
                <th className="text-left p-4 font-medium text-slate-900 dark:text-white">Voice</th>
                <th className="text-left p-4 font-medium text-slate-900 dark:text-white">Discipline</th>
                <th className="text-left p-4 font-medium text-slate-900 dark:text-white">Overall</th>
                <th className="text-left p-4 font-medium text-slate-900 dark:text-white">Grade</th>
                <th className="text-left p-4 font-medium text-slate-900 dark:text-white">Actions</th>
              </tr>
            </thead>
            <tbody>
              <AnimatePresence>
                {filteredResults.map((result) => (
                  <motion.tr
                    key={result.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={{ opacity: 0, y: -20 }}
                    className="border-b border-slate-100 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800/50"
                  >
                    <td className="p-4">
                      <div>
                        <p className="font-medium text-slate-900 dark:text-white">
                          {result.studentName}
                        </p>
                        <p className="text-sm text-slate-600 dark:text-slate-400">
                          {result.studentId}
                        </p>
                      </div>
                    </td>
                    <td className="p-4">
                      <Badge variant={result.retentionScore >= 80 ? 'success' : 'warning'}>
                        {result.retentionScore}%
                      </Badge>
                    </td>
                    <td className="p-4">
                      <Badge variant={result.tajweedScore >= 80 ? 'success' : 'warning'}>
                        {result.tajweedScore}%
                      </Badge>
                    </td>
                    <td className="p-4">
                      <Badge variant={result.voiceScore >= 80 ? 'success' : 'warning'}>
                        {result.voiceScore}%
                      </Badge>
                    </td>
                    <td className="p-4">
                      <Badge variant={result.disciplineScore >= 80 ? 'success' : 'warning'}>
                        {result.disciplineScore}%
                      </Badge>
                    </td>
                    <td className="p-4">
                      <span className="font-medium text-slate-900 dark:text-white">
                        {result.overallPerformance.toFixed(1)}%
                      </span>
                    </td>
                    <td className="p-4">
                      <Badge 
                        variant={
                          result.grade.includes('A') ? 'success' : 
                          result.grade === 'B' ? 'warning' : 'error'
                        }
                      >
                        {result.grade}
                      </Badge>
                    </td>
                    <td className="p-4">
                      <div className="flex items-center gap-2">
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleEdit(result)}
                        >
                          <Edit3 className="h-4 w-4" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleDelete(result.id)}
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                        <Button variant="ghost" size="sm">
                          <Info className="h-4 w-4" />
                        </Button>
                      </div>
                    </td>
                  </motion.tr>
                ))}
              </AnimatePresence>
            </tbody>
          </table>
        </div>
      </Card>

      {/* Enhanced Modal */}
      <Modal
        isOpen={isModalOpen}
        onClose={() => {
          setIsModalOpen(false);
          resetForm();
        }}
        title={
          modalMode === 'single' 
            ? (selectedResult ? 'Edit Result' : 'Add Single Result')
            : 'Add Multiple Results'
        }
        size={modalMode === 'multi' ? 'xl' : 'lg'}
      >
        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Mode Toggle */}
          <div className="flex items-center gap-4 p-3 bg-slate-50 dark:bg-slate-800 rounded-lg">
            <span className="text-sm font-medium text-slate-700 dark:text-slate-300">Mode:</span>
            <div className="flex gap-2">
              <Button
                type="button"
                variant={modalMode === 'single' ? 'default' : 'outline'}
                size="sm"
                onClick={() => setModalMode('single')}
                className="flex items-center gap-2"
              >
                <User className="h-4 w-4" />
                Single Student
              </Button>
              <Button
                type="button"
                variant={modalMode === 'multi' ? 'default' : 'outline'}
                size="sm"
                onClick={() => setModalMode('multi')}
                className="flex items-center gap-2"
              >
                <Users className="h-4 w-4" />
                Multiple Students
              </Button>
            </div>
          </div>

          {/* Form Content */}
          {modalMode === 'single' ? renderSingleStudentForm() : renderMultiStudentForm()}

          {/* Action Buttons */}
          <div className="flex gap-3 pt-4 border-t">
            <Button 
              type="submit" 
              className="flex-1"
              disabled={isSubmitting}
            >
              {isSubmitting ? (
                <div className="flex items-center gap-2">
                  <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                  Saving...
                </div>
              ) : (
                modalMode === 'single' 
                  ? (selectedResult ? 'Update Result' : 'Add Result')
                  : 'Add All Results'
              )}
            </Button>
            <Button
              type="button"
              variant="outline"
              onClick={() => {
                setIsModalOpen(false);
                resetForm();
              }}
              className="flex-1"
              disabled={isSubmitting}
            >
              Cancel
            </Button>
          </div>
        </form>
      </Modal>
    </div>
  );
};

export default TahfizResultsPage;

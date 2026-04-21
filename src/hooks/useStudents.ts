'use client';
import { useState, useEffect, useCallback } from 'react';

export interface Student {
  id: number;
  person_id: number;
  first_name: string;
  last_name: string;
  name: string;
  avatar: string | null;
  phone: string | null;
  email: string | null;
  admission_no: string | null;
  group_id: number | null;
  group_name: string | null;
  completed_verses: number;
  total_verses: number;
  last_session: string | null;
  status: 'active' | 'inactive' | 'completed' | 'deleted';
  admission_date: string | null;
  notes: string | null;
}

export interface StudentFormData {
  first_name: string;
  last_name: string;
  phone: string;
  email: string;
  admission_no: string;
  group_id: string;
  status: string;
  notes: string;
}

interface UseStudentsOptions {
  schoolId: number;
  autoRefresh?: boolean;
  refreshInterval?: number;
}

export function useStudents({ schoolId, autoRefresh = false, refreshInterval = 30000 }: UseStudentsOptions) {
  const [students, setStudents] = useState<Student[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [lastRefresh, setLastRefresh] = useState<Date | null>(null);

  const fetchStudents = useCallback(async () => {
    setLoading(true);
    setError(null);
    
    try {
      const res = await fetch(`/api/tahfiz/students?school_id=${schoolId}`);
      const data = await res.json();
      
      if (!res.ok) {
        throw new Error(data.message || 'Failed to fetch students');
      }
      
      setStudents(data.data || []);
      setLastRefresh(new Date());
    } catch (err: any) {
      console.error('Error fetching students:', err);
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }, [schoolId]);

  const createStudent = useCallback(async (formData: StudentFormData): Promise<boolean> => {
    try {
      const res = await fetch('/api/tahfiz/students', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          school_id: schoolId,
          ...formData,
          group_id: formData.group_id || null
        }),
      });

      const data = await res.json();
      
      if (!res.ok) {
        throw new Error(data.message || 'Failed to create student');
      }
      
      // Refresh the students list
      await fetchStudents();
      return true;
    } catch (error) {
      console.error('Error creating student:', error);
      throw error;
    }
  }, [schoolId, fetchStudents]);

  const updateStudent = useCallback(async (studentId: number, formData: StudentFormData): Promise<boolean> => {
    try {
      const res = await fetch(`/api/tahfiz/students/${studentId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          ...formData,
          group_id: formData.group_id || null
        }),
      });

      const data = await res.json();
      
      if (!res.ok) {
        throw new Error(data.message || 'Failed to update student');
      }
      
      // Refresh the students list
      await fetchStudents();
      return true;
    } catch (error) {
      console.error('Error updating student:', error);
      throw error;
    }
  }, [fetchStudents]);

  const deleteStudent = useCallback(async (studentId: number): Promise<boolean> => {
    try {
      const res = await fetch(`/api/tahfiz/students/${studentId}`, {
        method: 'DELETE',
      });

      const data = await res.json();
      
      if (!res.ok) {
        throw new Error(data.message || 'Failed to delete student');
      }
      
      // Refresh the students list
      await fetchStudents();
      return true;
    } catch (error) {
      console.error('Error deleting student:', error);
      throw error;
    }
  }, [fetchStudents]);

  const getStudent = useCallback(async (studentId: number): Promise<Student> => {
    try {
      const res = await fetch(`/api/tahfiz/students/${studentId}`);
      const data = await res.json();
      
      if (!res.ok) {
        throw new Error(data.message || 'Failed to fetch student');
      }
      
      return data.data;
    } catch (error) {
      console.error('Error fetching student:', error);
      throw error;
    }
  }, []);

  // Auto refresh functionality
  useEffect(() => {
    if (autoRefresh && !loading) {
      const interval = setInterval(fetchStudents, refreshInterval);
      return () => clearInterval(interval);
    }
  }, [autoRefresh, refreshInterval, loading, fetchStudents]);

  // Initial fetch
  useEffect(() => {
    fetchStudents();
  }, [fetchStudents]);

  // Statistics
  const stats = {
    total: students.length,
    active: students.filter(s => s.status === 'active').length,
    inactive: students.filter(s => s.status === 'inactive').length,
    completed: students.filter(s => s.status === 'completed').length,
    deleted: students.filter(s => s.status === 'deleted').length,
    withGroups: students.filter(s => s.group_id).length,
    withoutGroups: students.filter(s => !s.group_id).length,
    averageProgress: students.length > 0 
      ? students.reduce((acc, s) => acc + (s.total_verses > 0 ? (s.completed_verses / s.total_verses) * 100 : 0), 0) / students.length 
      : 0
  };

  return {
    students,
    loading,
    error,
    lastRefresh,
    stats,
    actions: {
      fetchStudents,
      createStudent,
      updateStudent,
      deleteStudent,
      getStudent
    }
  };
}
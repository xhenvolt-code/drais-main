'use client';

import React, { useState, useEffect } from 'react';
import { Plus, Edit, Trash } from 'lucide-react';
import { motion } from 'framer-motion';
import axios from 'axios';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

const API_BASE = '/api/class-subjects';

const ClassSubjectsPage = () => {
  const [assignments, setAssignments] = useState([]);
  const [classes, setClasses] = useState([]);
  const [subjects, setSubjects] = useState([]);
  const [teachers, setTeachers] = useState([]);
  const [streams, setStreams] = useState([]);
  const [terms, setTerms] = useState([]);
  const [filters, setFilters] = useState({ class_id: '', stream_id: '', term_id: '' });
  const [modalOpen, setModalOpen] = useState(false);
  const [formData, setFormData] = useState({ class_id: '', subject_id: '', teacher_id: '', stream_id: '', term_id: '' });
  const [loading, setLoading] = useState(false);

  const fetchAssignments = async () => {
    try {
      const { data } = await axios.get(API_BASE, { params: filters });
      setAssignments(data);
    } catch (error) {
      toast.error('Failed to fetch assignments.');
    }
  };

  const fetchOptions = async () => {
    try {
      const [classRes, subjectRes, teacherRes, streamRes, termRes] = await Promise.all([
        axios.get('/api/classes'),
        axios.get('/api/subjects'),
        axios.get('/api/staff'),
        axios.get('/api/streams'),
        axios.get('/api/terms'),
      ]);
      setClasses(classRes.data);
      setSubjects(subjectRes.data);
      setTeachers(teacherRes.data);
      setStreams(streamRes.data);
      setTerms(termRes.data);
    } catch (error) {
      toast.error('Failed to fetch options.');
    }
  };

  const handleSave = async () => {
    try {
      setLoading(true);
      if (formData.id) {
        await axios.put(API_BASE, formData);
        toast.success('Assignment updated successfully.');
      } else {
        await axios.post(API_BASE, formData);
        toast.success('Assignment created successfully.');
      }
      setModalOpen(false);
      fetchAssignments();
    } catch (error) {
      toast.error(error.response?.data?.message || 'Failed to save assignment.');
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    try {
      await axios.delete(`${API_BASE}?id=${id}`);
      toast.success('Assignment deleted successfully.');
      fetchAssignments();
    } catch (error) {
      toast.error('Failed to delete assignment.');
    }
  };

  useEffect(() => {
    fetchAssignments();
    fetchOptions();
  }, [filters]);

  return (
    <div className="space-y-6">
      <header className="flex justify-between items-center">
        <h1 className="text-2xl font-bold">Class Subject Assignments</h1>
        <button className="btn btn-primary" onClick={() => setModalOpen(true)}>
          <Plus className="w-4 h-4" /> Add Assignment
        </button>
      </header>

      <motion.div className="card">
        <div className="flex gap-4 mb-4">
          <select
            className="form-select"
            value={filters.class_id}
            onChange={(e) => setFilters((prev) => ({ ...prev, class_id: e.target.value }))}
          >
            <option value="">Filter by Class</option>
            {classes.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
              </option>
            ))}
          </select>
          <select
            className="form-select"
            value={filters.stream_id}
            onChange={(e) => setFilters((prev) => ({ ...prev, stream_id: e.target.value }))}
          >
            <option value="">Filter by Stream</option>
            {streams.map((s) => (
              <option key={s.id} value={s.id}>
                {s.name}
              </option>
            ))}
          </select>
          <select
            className="form-select"
            value={filters.term_id}
            onChange={(e) => setFilters((prev) => ({ ...prev, term_id: e.target.value }))}
          >
            <option value="">Filter by Term</option>
            {terms.map((t) => (
              <option key={t.id} value={t.id}>
                {t.name}
              </option>
            ))}
          </select>
        </div>

        <table className="table-auto w-full">
          <thead>
            <tr>
              <th>Class</th>
              <th>Subject</th>
              <th>Teacher</th>
              <th>Stream</th>
              <th>Term</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {assignments.map((assignment) => (
              <tr key={assignment.id}>
                <td>{assignment.class_name}</td>
                <td>{assignment.subject_name}</td>
                <td>{assignment.teacher_name} ({assignment.teacher_initials})</td>
                <td>{assignment.stream || 'N/A'}</td>
                <td>{assignment.term || 'N/A'}</td>
                <td>
                  <div className="flex gap-2">
                    <button
                      className="btn btn-secondary"
                      onClick={() => {
                        setFormData(assignment);
                        setModalOpen(true);
                      }}
                    >
                      <Edit className="w-4 h-4" />
                    </button>
                    <button className="btn btn-danger" onClick={() => handleDelete(assignment.id)}>
                      <Trash className="w-4 h-4" />
                    </button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </motion.div>

      {modalOpen && (
        <motion.div className="modal">
          <div className="modal-content">
            <h2 className="text-xl font-bold">{formData.id ? 'Edit Assignment' : 'Add Assignment'}</h2>
            <select
              className="form-select"
              value={formData.class_id}
              onChange={(e) => setFormData((prev) => ({ ...prev, class_id: e.target.value }))}
            >
              <option value="">Select Class</option>
              {classes.map((c) => (
                <option key={c.id} value={c.id}>
                  {c.name}
                </option>
              ))}
            </select>
            <select
              className="form-select"
              value={formData.subject_id}
              onChange={(e) => setFormData((prev) => ({ ...prev, subject_id: e.target.value }))}
            >
              <option value="">Select Subject</option>
              {subjects.map((s) => (
                <option key={s.id} value={s.id}>
                  {s.name}
                </option>
              ))}
            </select>
            <select
              className="form-select"
              value={formData.teacher_id}
              onChange={(e) => setFormData((prev) => ({ ...prev, teacher_id: e.target.value }))}
            >
              <option value="">Select Teacher</option>
              {teachers.map((t) => (
                <option key={t.id} value={t.id}>
                  {t.first_name} {t.last_name} ({t.initials})
                </option>
              ))}
            </select>
            <select
              className="form-select"
              value={formData.stream_id}
              onChange={(e) => setFormData((prev) => ({ ...prev, stream_id: e.target.value }))}
            >
              <option value="">Select Stream</option>
              {streams.map((s) => (
                <option key={s.id} value={s.id}>
                  {s.name}
                </option>
              ))}
            </select>
            <select
              className="form-select"
              value={formData.term_id}
              onChange={(e) => setFormData((prev) => ({ ...prev, term_id: e.target.value }))}
            >
              <option value="">Select Term</option>
              {terms.map((t) => (
                <option key={t.id} value={t.id}>
                  {t.name}
                </option>
              ))}
            </select>
            <div className="flex justify-end gap-2">
              <button className="btn btn-secondary" onClick={() => setModalOpen(false)}>
                Cancel
              </button>
              <button className="btn btn-primary" onClick={handleSave} disabled={loading}>
                Save
              </button>
            </div>
          </div>
        </motion.div>
      )}
    </div>
  );
};

export default ClassSubjectsPage;

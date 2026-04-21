"use client";
import React, { useState } from 'react';

const StaffAttendance = () => {
  const [formData, setFormData] = useState({ staff_id: '', date: '', status: '', notes: '' });

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch('/api/staff/attendance', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData),
      });
      const data = await response.json();
      if (data.success) {
        alert('Attendance recorded successfully!');
        setFormData({ staff_id: '', date: '', status: '', notes: '' });
      } else {
        alert('Failed to record attendance.');
      }
    } catch (error) {
      console.error('Failed to record attendance:', error);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  return (
    <div className="p-8">
      <h1 className="text-2xl font-bold mb-4">Staff Attendance</h1>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block mb-2">Staff ID</label>
          <input
            type="text"
            name="staff_id"
            value={formData.staff_id}
            onChange={handleChange}
            className="border border-gray-300 px-4 py-2 w-full"
            required
          />
        </div>
        <div>
          <label className="block mb-2">Date</label>
          <input
            type="date"
            name="date"
            value={formData.date}
            onChange={handleChange}
            className="border border-gray-300 px-4 py-2 w-full"
            required
          />
        </div>
        <div>
          <label className="block mb-2">Status</label>
          <select
            name="status"
            value={formData.status}
            onChange={handleChange}
            className="border border-gray-300 px-4 py-2 w-full"
            required
          >
            <option value="">Select Status</option>
            <option value="present">Present</option>
            <option value="absent">Absent</option>
          </select>
        </div>
        <div>
          <label className="block mb-2">Notes</label>
          <textarea
            name="notes"
            value={formData.notes}
            onChange={handleChange}
            className="border border-gray-300 px-4 py-2 w-full"
          ></textarea>
        </div>
        <button type="submit" className="bg-blue-500 text-white px-4 py-2">Submit</button>
      </form>
    </div>
  );
};

export default StaffAttendance;
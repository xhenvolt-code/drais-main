'use client';

import React, { useState, useEffect } from 'react';
import { useParams } from 'next/navigation';
import { motion } from 'framer-motion';
import { Printer } from 'lucide-react';

interface LearnerReport {
  name: string;
  completedJuz: number;
  tajweedProficiency: string;
  retentionLevel: string;
  voiceQuality: string;
  consistency: string;
  discipline: string;
  remarks: string;
}

export default function LearnerReport() {
  const { id } = useParams();
  const [report, setReport] = useState<LearnerReport | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Simulate API call
    setTimeout(() => {
      setReport({
        name: 'Ahmad Al-Hassan',
        completedJuz: 15,
        tajweedProficiency: 'Excellent',
        retentionLevel: 'High',
        voiceQuality: 'Good',
        consistency: 'Consistent',
        discipline: 'Excellent',
        remarks: 'Ahmad has shown remarkable improvement in retention and tajweed proficiency.',
      });
      setLoading(false);
    }, 1000);
  }, [id]);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-slate-600">Loading...</div>
      </div>
    );
  }

  if (!report) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-slate-600">Report not found</div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50/30 p-6">
      <div className="max-w-4xl mx-auto space-y-8">
        {/* Header */}
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-3xl font-bold text-slate-800">{report.name}&apos;s Report</h1>
            <p className="text-slate-600 mt-1">Detailed performance metrics</p>
          </div>
          <button className="px-4 py-2 bg-gradient-to-r from-emerald-500 to-emerald-600 text-white rounded-lg shadow hover:shadow-md flex items-center gap-2">
            <Printer className="w-5 h-5" />
            <span>Export</span>
          </button>
        </div>

        {/* Report Details */}
        <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 shadow-lg border border-white/20">
          <div className="space-y-4">
            <p className="text-lg text-slate-800">
              <strong>Juz Completed:</strong> {report.completedJuz}
            </p>
            <p className="text-lg text-slate-800">
              <strong>Tajweed Proficiency:</strong> {report.tajweedProficiency}
            </p>
            <p className="text-lg text-slate-800">
              <strong>Retention Level:</strong> {report.retentionLevel}
            </p>
            <p className="text-lg text-slate-800">
              <strong>Voice Quality:</strong> {report.voiceQuality}
            </p>
            <p className="text-lg text-slate-800">
              <strong>Consistency:</strong> {report.consistency}
            </p>
            <p className="text-lg text-slate-800">
              <strong>Discipline:</strong> {report.discipline}
            </p>
            <p className="text-lg text-slate-800">
              <strong>Remarks:</strong> {report.remarks}
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}

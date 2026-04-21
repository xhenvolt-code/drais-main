'use client';

import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { 
  Brain, 
  TrendingUp, 
  TrendingDown, 
  Target,
  AlertCircle,
  CheckCircle,
  BookOpen,
  Users,
  Award,
  Activity,
  Zap
} from 'lucide-react';
import useSWR from 'swr';
import { fetcher } from '@/utils/fetcher';

interface PredictiveAnalyticsProps {
  schoolId: number;
  scope?: 'school' | 'class' | 'student';
  scopeId?: number;
}

const PredictiveAnalyticsDashboard: React.FC<PredictiveAnalyticsProps> = ({ 
  schoolId, 
  scope = 'school',
  scopeId 
}) => {
  const [analysisType, setAnalysisType] = useState<'comprehensive' | 'subjects' | 'projections'>('comprehensive');
  const [selectedDepartment, setSelectedDepartment] = useState<'all' | 'theology' | 'secular'>('all');

  const queryParams = new URLSearchParams({
    school_id: schoolId.toString(),
    scope,
    analysis_type: analysisType,
    ...(scopeId && { scope_id: scopeId.toString() }),
  });

  const { data, isLoading, error } = useSWR(
    `/api/analytics/predictive?${queryParams}`,
    fetcher,
    {
      refreshInterval: 60000, // Refresh every minute
      revalidateOnFocus: true,
    }
  );

  if (isLoading) {
    return (
      <div className="flex items-center justify-center py-12">
        <div className="text-center">
          <Brain className="w-12 h-12 text-purple-500 animate-pulse mx-auto mb-4" />
          <p className="text-gray-600 dark:text-gray-400">Analyzing academic data...</p>
        </div>
      </div>
    );
  }

  if (error || !(data as any)?.success) {
    return (
      <div className="bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-xl p-6">
        <AlertCircle className="w-6 h-6 text-red-600 mb-2" />
        <p className="text-red-800 dark:text-red-200">Failed to load predictive analytics</p>
      </div>
    );
  }

  const analytics = (data as any).data;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="p-3 bg-gradient-to-br from-purple-500 to-indigo-600 rounded-full">
            <Brain className="w-8 h-8 text-white" />
          </div>
          <div>
            <h2 className="text-2xl font-bold text-gray-900 dark:text-white">
              AI-Powered Predictive Analytics
            </h2>
            <p className="text-sm text-gray-600 dark:text-gray-400">
              Academic insights, trends, and 5-year projections
            </p>
          </div>
        </div>

        {/* Analysis Type Selector */}
        <div className="flex gap-2 bg-gray-100 dark:bg-slate-700 rounded-lg p-1">
          <button
            onClick={() => setAnalysisType('comprehensive')}
            className={`px-4 py-2 rounded-md text-sm font-medium transition-all ${
              analysisType === 'comprehensive'
                ? 'bg-white dark:bg-slate-800 shadow-sm text-purple-600'
                : 'text-gray-600 dark:text-gray-400'
            }`}
          >
            Overview
          </button>
          <button
            onClick={() => setAnalysisType('subjects')}
            className={`px-4 py-2 rounded-md text-sm font-medium transition-all ${
              analysisType === 'subjects'
                ? 'bg-white dark:bg-slate-800 shadow-sm text-purple-600'
                : 'text-gray-600 dark:text-gray-400'
            }`}
          >
            Subjects
          </button>
          <button
            onClick={() => setAnalysisType('projections')}
            className={`px-4 py-2 rounded-md text-sm font-medium transition-all ${
              analysisType === 'projections'
                ? 'bg-white dark:bg-slate-800 shadow-sm text-purple-600'
                : 'text-gray-600 dark:text-gray-400'
            }`}
          >
            Projections
          </button>
        </div>
      </div>

      {/* Key Insights */}
      {analytics.insights && analytics.insights.length > 0 && (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {analytics.insights.map((insight: any, index: number) => (
            <InsightCard key={index} insight={insight} />
          ))}
        </div>
      )}

      {/* Subject Analysis */}
      {analytics.subjectAnalysis && (
        <div className="space-y-4">
          {/* Department Filter */}
          <div className="flex gap-2">
            <button
              onClick={() => setSelectedDepartment('all')}
              className={`px-4 py-2 rounded-lg text-sm font-medium transition-all ${
                selectedDepartment === 'all'
                  ? 'bg-blue-600 text-white'
                  : 'bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-300'
              }`}
            >
              All Subjects
            </button>
            <button
              onClick={() => setSelectedDepartment('theology')}
              className={`px-4 py-2 rounded-lg text-sm font-medium transition-all ${
                selectedDepartment === 'theology'
                  ? 'bg-green-600 text-white'
                  : 'bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-300'
              }`}
            >
              Theology/Tahfiz
            </button>
            <button
              onClick={() => setSelectedDepartment('secular')}
              className={`px-4 py-2 rounded-lg text-sm font-medium transition-all ${
                selectedDepartment === 'secular'
                  ? 'bg-purple-600 text-white'
                  : 'bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-300'
              }`}
            >
              Secular Academics
            </button>
          </div>

          {/* Summary Stats */}
          <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
            <StatCard
              icon={BookOpen}
              label="Total Subjects"
              value={analytics.subjectAnalysis.summary.totalSubjects}
              color="blue"
            />
            <StatCard
              icon={TrendingUp}
              label="Improving"
              value={analytics.subjectAnalysis.summary.improving}
              color="green"
            />
            <StatCard
              icon={TrendingDown}
              label="Declining"
              value={analytics.subjectAnalysis.summary.declining}
              color="red"
            />
            <StatCard
              icon={Activity}
              label="Stable"
              value={analytics.subjectAnalysis.summary.stable}
              color="yellow"
            />
            <StatCard
              icon={Award}
              label="Avg Score"
              value={`${analytics.subjectAnalysis.summary.avgSchoolScore}%`}
              color="purple"
            />
          </div>

          {/* Best Subjects */}
          <div className="bg-white dark:bg-slate-800 rounded-xl p-6 shadow-lg">
            <h3 className="text-lg font-bold text-gray-900 dark:text-white mb-4 flex items-center gap-2">
              <Award className="w-5 h-5 text-green-500" />
              Top Performing Subjects
            </h3>
            <SubjectTable subjects={analytics.subjectAnalysis.bestSubjects} type="best" />
          </div>

          {/* Worst Subjects */}
          <div className="bg-white dark:bg-slate-800 rounded-xl p-6 shadow-lg">
            <h3 className="text-lg font-bold text-gray-900 dark:text-white mb-4 flex items-center gap-2">
              <AlertCircle className="w-5 h-5 text-red-500" />
              Subjects Needing Attention
            </h3>
            <SubjectTable subjects={analytics.subjectAnalysis.worstSubjects} type="worst" />
          </div>
        </div>
      )}

      {/* Projections */}
      {analytics.projections && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* 1-Year Projection */}
          <ProjectionCard
            title="1-Year Academic Projection"
            projection={analytics.projections.oneYear}
            timeframe="Next 3 Terms"
            color="blue"
          />

          {/* 5-Year Projection */}
          <ProjectionCard
            title="5-Year Academic Roadmap"
            projection={analytics.projections.fiveYear}
            timeframe="Next 15 Terms"
            color="purple"
          />

          {/* Theology Projection */}
          <ProjectionCard
            title="Theology/Tahfiz Development"
            projection={analytics.projections.theology?.fiveYear}
            timeframe="5-Year Plan"
            color="green"
          />

          {/* Secular Projection */}
          <ProjectionCard
            title="Secular Academics Development"
            projection={analytics.projections.secular?.fiveYear}
            timeframe="5-Year Plan"
            color="indigo"
          />
        </div>
      )}
    </div>
  );
};

// Insight Card Component
const InsightCard: React.FC<{ insight: any }> = ({ insight }) => {
  const severityColors = {
    high: 'border-red-500 bg-red-50 dark:bg-red-900/20',
    medium: 'border-yellow-500 bg-yellow-50 dark:bg-yellow-900/20',
    positive: 'border-green-500 bg-green-50 dark:bg-green-900/20',
  };

  const iconColors = {
    high: 'text-red-600',
    medium: 'text-yellow-600',
    positive: 'text-green-600',
  };

  return (
    <motion.div
      initial={{ opacity: 0, scale: 0.95 }}
      animate={{ opacity: 1, scale: 1 }}
      className={`border-l-4 ${severityColors[insight.severity as keyof typeof severityColors]} rounded-lg p-4 shadow-md`}
    >
      <div className="flex items-start gap-3">
        <AlertCircle className={`w-5 h-5 ${iconColors[insight.severity as keyof typeof iconColors]} flex-shrink-0 mt-1`} />
        <div className="flex-1">
          <h4 className="font-semibold text-gray-900 dark:text-white text-sm mb-1">
            {insight.title}
          </h4>
          <p className="text-xs text-gray-600 dark:text-gray-400 mb-2">
            {insight.description}
          </p>
          {insight.recommendation && (
            <p className="text-xs text-blue-700 dark:text-blue-300 font-medium">
              💡 {insight.recommendation}
            </p>
          )}
          <div className="mt-2 text-xs text-gray-500">
            Confidence: {Math.round(insight.confidenceScore * 100)}%
          </div>
        </div>
      </div>
    </motion.div>
  );
};

// Stat Card Component
const StatCard: React.FC<{ icon: any; label: string; value: string | number; color: string }> = ({
  icon: Icon,
  label,
  value,
  color,
}) => {
  const colorClasses = {
    blue: 'bg-blue-50 dark:bg-blue-900/20 text-blue-600',
    green: 'bg-green-50 dark:bg-green-900/20 text-green-600',
    red: 'bg-red-50 dark:bg-red-900/20 text-red-600',
    yellow: 'bg-yellow-50 dark:bg-yellow-900/20 text-yellow-600',
    purple: 'bg-purple-50 dark:bg-purple-900/20 text-purple-600',
  };

  return (
    <div className={`${colorClasses[color as keyof typeof colorClasses]} rounded-lg p-4`}>
      <Icon className="w-6 h-6 mb-2" />
      <div className="text-2xl font-bold">{value}</div>
      <div className="text-sm opacity-75">{label}</div>
    </div>
  );
};

// Subject Table Component
const SubjectTable: React.FC<{ subjects: any[]; type: 'best' | 'worst' }> = ({ subjects, type }) => {
  if (!subjects || subjects.length === 0) {
    return <div className="text-center py-4 text-gray-500">No data available</div>;
  }

  return (
    <div className="overflow-x-auto">
      <table className="w-full">
        <thead>
          <tr className="border-b border-gray-200 dark:border-gray-700">
            <th className="text-left py-2 px-3 text-sm font-semibold text-gray-700 dark:text-gray-300">Subject</th>
            <th className="text-center py-2 px-3 text-sm font-semibold text-gray-700 dark:text-gray-300">Avg Score</th>
            <th className="text-center py-2 px-3 text-sm font-semibold text-gray-700 dark:text-gray-300">Pass Rate</th>
            <th className="text-center py-2 px-3 text-sm font-semibold text-gray-700 dark:text-gray-300">Trend</th>
          </tr>
        </thead>
        <tbody>
          {subjects.map((subject, index) => (
            <tr key={index} className="border-b border-gray-100 dark:border-gray-800">
              <td className="py-3 px-3">
                <div className="font-medium text-gray-900 dark:text-white">{subject.subject_name}</div>
                <div className="text-xs text-gray-500">{subject.teacher_name || 'N/A'}</div>
              </td>
              <td className="text-center py-3 px-3">
                <span className={`font-bold ${
                  type === 'best' ? 'text-green-600' : 'text-red-600'
                }`}>
                  {subject.avg_score?.toFixed(1)}%
                </span>
              </td>
              <td className="text-center py-3 px-3 text-sm text-gray-600 dark:text-gray-400">
                {subject.passRate}%
              </td>
              <td className="text-center py-3 px-3">
                {subject.trend === 'improving' && <TrendingUp className="w-5 h-5 text-green-500 mx-auto" />}
                {subject.trend === 'declining' && <TrendingDown className="w-5 h-5 text-red-500 mx-auto" />}
                {subject.trend === 'stable' && <Activity className="w-5 h-5 text-gray-400 mx-auto" />}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

// Projection Card Component
const ProjectionCard: React.FC<{
  title: string;
  projection: any;
  timeframe: string;
  color: string;
}> = ({ title, projection, timeframe, color }) => {
  if (!projection) return null;

  const colorClasses = {
    blue: 'from-blue-500 to-blue-600',
    purple: 'from-purple-500 to-purple-600',
    green: 'from-green-500 to-green-600',
    indigo: 'from-indigo-500 to-indigo-600',
  };

  return (
    <div className="bg-white dark:bg-slate-800 rounded-xl p-6 shadow-lg">
      <div className={`bg-gradient-to-r ${colorClasses[color as keyof typeof colorClasses]} text-white rounded-lg p-4 mb-4`}>
        <h3 className="text-lg font-bold mb-1">{title}</h3>
        <p className="text-sm opacity-90">{timeframe}</p>
      </div>

      <div className="space-y-2">
        {projection.projectedScores?.slice(0, 5).map((score: any, index: number) => (
          <div key={index} className="flex items-center justify-between">
            <span className="text-sm text-gray-600 dark:text-gray-400">
              Term {score.term}
            </span>
            <div className="flex items-center gap-3">
              <div className="w-32 bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                <div
                  className={`bg-gradient-to-r ${colorClasses[color as keyof typeof colorClasses]} rounded-full h-2 transition-all duration-500`}
                  style={{ width: `${score.projectedScore}%` }}
                />
              </div>
              <span className="text-sm font-bold text-gray-900 dark:text-white w-12 text-right">
                {score.projectedScore}%
              </span>
            </div>
          </div>
        ))}
      </div>

      <div className="mt-4 pt-4 border-t border-gray-200 dark:border-gray-700">
        <div className="flex items-center justify-between">
          <span className="text-sm text-gray-600 dark:text-gray-400">Final Projection</span>
          <span className="text-2xl font-bold text-gray-900 dark:text-white">
            {projection.finalScore}%
          </span>
        </div>
      </div>
    </div>
  );
};

export default PredictiveAnalyticsDashboard;

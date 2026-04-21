"use client";
import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Brain, AlertCircle, TrendingUp, TrendingDown, Info, Eye } from 'lucide-react';

interface AIInsightData {
  id: number;
  title: string;
  description: string;
  confidenceScore: number;
  recommendation?: string;
  insightType: string;
  dataPoints?: any;
}

interface AIInsightCardProps {
  data?: AIInsightData;
}

const AIInsightCard: React.FC<AIInsightCardProps> = ({ data }) => {
  const [showDetails, setShowDetails] = useState(false);

  if (!data) {
    return (
      <div className="bg-white dark:bg-slate-800 rounded-2xl p-6 shadow-lg">
        <div className="flex items-center gap-3 mb-4">
          <div className="p-3 rounded-full bg-gradient-to-br from-purple-500 to-indigo-600">
            <Brain className="w-6 h-6 text-white" />
          </div>
          <div>
            <h3 className="font-semibold text-gray-900 dark:text-white">AI Insights</h3>
            <p className="text-sm text-gray-600 dark:text-gray-400">Powered by Analytics</p>
          </div>
        </div>
        
        <div className="text-center py-8">
          <Brain className="w-12 h-12 text-gray-300 mx-auto mb-3" />
          <p className="text-gray-500 dark:text-gray-400 text-sm">
            Analyzing school data to generate insights...
          </p>
        </div>
      </div>
    );
  }

  const getInsightIcon = (type: string) => {
    switch (type) {
      case 'performance_risk':
        return TrendingDown;
      case 'improvement':
        return TrendingUp;
      case 'alert':
        return AlertCircle;
      default:
        return Info;
    }
  };

  const getConfidenceColor = (score: number) => {
    if (score >= 0.8) return 'text-green-600';
    if (score >= 0.6) return 'text-yellow-600';
    return 'text-red-600';
  };

  const InsightIcon = getInsightIcon(data.insightType);

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      className="bg-white dark:bg-slate-800 rounded-2xl p-6 shadow-lg hover:shadow-xl transition-all duration-300 group"
    >
      <div className="flex items-center gap-3 mb-4">
        <div className="p-3 rounded-full bg-gradient-to-br from-purple-500 to-indigo-600 group-hover:scale-110 transition-transform duration-300">
          <Brain className="w-6 h-6 text-white" />
        </div>
        <div className="flex-1">
          <h3 className="font-semibold text-gray-900 dark:text-white">AI Insight</h3>
          <div className="flex items-center gap-2">
            <span className={`text-sm font-medium ${getConfidenceColor(data.confidenceScore)}`}>
              {Math.round(data.confidenceScore * 100)}% confidence
            </span>
            <InsightIcon className="w-4 h-4 text-gray-500" />
          </div>
        </div>
      </div>

      <div className="space-y-3">
        <h4 className="font-medium text-gray-900 dark:text-white">
          {data.title}
        </h4>
        
        <p className="text-sm text-gray-600 dark:text-gray-400 leading-relaxed">
          {data.description}
        </p>

        {data.recommendation && (
          <div className="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-3">
            <p className="text-sm text-blue-800 dark:text-blue-300">
              <strong>Recommendation:</strong> {data.recommendation}
            </p>
          </div>
        )}

        <div className="flex items-center justify-between pt-3 border-t border-gray-200 dark:border-gray-600">
          <div className="flex items-center gap-2">
            <div className="w-full bg-gray-200 dark:bg-slate-700 rounded-full h-2 flex-1 max-w-20">
              <motion.div
                initial={{ width: 0 }}
                animate={{ width: `${data.confidenceScore * 100}%` }}
                transition={{ delay: 0.5, duration: 0.8 }}
                className={`h-2 rounded-full ${
                  data.confidenceScore >= 0.8 ? 'bg-green-500' :
                  data.confidenceScore >= 0.6 ? 'bg-yellow-500' : 'bg-red-500'
                }`}
              />
            </div>
          </div>
          
          <button
            onClick={() => setShowDetails(!showDetails)}
            className="flex items-center gap-1 text-sm text-blue-600 hover:text-blue-700 transition-colors"
          >
            <Eye className="w-4 h-4" />
            {showDetails ? 'Hide' : 'Explain'}
          </button>
        </div>

        {showDetails && data.dataPoints && (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: 'auto' }}
            exit={{ opacity: 0, height: 0 }}
            className="mt-4 p-4 bg-gray-50 dark:bg-slate-700 rounded-lg"
          >
            <h5 className="font-medium text-gray-900 dark:text-white mb-2">
              Analysis Details:
            </h5>
            <ul className="text-sm text-gray-600 dark:text-gray-400 space-y-1">
              {Object.entries(data.dataPoints).map(([key, value]) => (
                <li key={key} className="flex justify-between">
                  <span className="capitalize">{key.replace('_', ' ')}:</span>
                  <span className="font-medium">{String(value)}</span>
                </li>
              ))}
            </ul>
          </motion.div>
        )}
      </div>
    </motion.div>
  );
};

export default AIInsightCard;

"use client";
import React from 'react';
import { motion } from 'framer-motion';
import { DollarSign, AlertCircle, Send, TrendingUp } from 'lucide-react';

interface FeesData {
  totalExpected: number;
  totalCollected: number;
  collectionPercentage: number;
  defaultersCount: number;
}

interface FeesSnapshotProps {
  data?: FeesData;
}

const FeesSnapshot: React.FC<FeesSnapshotProps> = ({ data }) => {
  const handleSendReminder = () => {
    console.log('Sending fee reminders...');
  };

  const collectionPercentage = data?.collectionPercentage || 0;
  const isGoodCollection = collectionPercentage >= 80;

  return (
    <div className="bg-white dark:bg-slate-800 rounded-2xl p-6 shadow-lg hover:shadow-xl transition-all duration-300">
      <div className="flex items-center gap-3 mb-6">
        <div className="p-3 rounded-full bg-gradient-to-br from-yellow-500 to-orange-600">
          <DollarSign className="w-6 h-6 text-white" />
        </div>
        <div>
          <h3 className="font-semibold text-gray-900 dark:text-white">Fee Collection</h3>
          <p className="text-sm text-gray-600 dark:text-gray-400">Current term snapshot</p>
        </div>
      </div>

      {data ? (
        <div className="space-y-4">
          {/* Collection Gauge */}
          <div className="text-center">
            <div className="relative w-32 h-32 mx-auto mb-4">
              <svg className="w-32 h-32 transform -rotate-90" viewBox="0 0 36 36">
                <path
                  className="text-gray-200 dark:text-slate-700"
                  stroke="currentColor"
                  strokeWidth="2"
                  fill="none"
                  d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
                />
                <motion.path
                  className={isGoodCollection ? "text-green-500" : "text-yellow-500"}
                  stroke="currentColor"
                  strokeWidth="2"
                  fill="none"
                  strokeLinecap="round"
                  d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
                  initial={{ strokeDasharray: "0 100" }}
                  animate={{ strokeDasharray: `${collectionPercentage} 100` }}
                  transition={{ duration: 1.5, ease: [0.0, 0.0, 0.2, 1] as [number, number, number, number] }}
                />
              </svg>
              <div className="absolute inset-0 flex items-center justify-center">
                <div className="text-center">
                  <p className="text-2xl font-bold text-gray-900 dark:text-white">
                    {Math.round(collectionPercentage)}%
                  </p>
                  <p className="text-xs text-gray-600 dark:text-gray-400">Collected</p>
                </div>
              </div>
            </div>
          </div>

          {/* Financial Details */}
          <div className="grid grid-cols-2 gap-4">
            <div className="text-center p-3 bg-green-50 dark:bg-green-900/20 rounded-lg">
              <p className="text-lg font-bold text-green-700 dark:text-green-300">
                UGX {data.totalCollected.toLocaleString()}
              </p>
              <p className="text-xs text-green-600 dark:text-green-400">Collected</p>
            </div>
            <div className="text-center p-3 bg-gray-50 dark:bg-slate-700 rounded-lg">
              <p className="text-lg font-bold text-gray-700 dark:text-gray-300">
                UGX {data.totalExpected.toLocaleString()}
              </p>
              <p className="text-xs text-gray-600 dark:text-gray-400">Expected</p>
            </div>
          </div>

          {/* Defaulters Alert */}
          {data.defaultersCount > 0 && (
            <div className="flex items-center gap-3 p-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-lg">
              <AlertCircle className="w-5 h-5 text-red-500" />
              <div className="flex-1">
                <p className="text-sm font-medium text-red-700 dark:text-red-300">
                  {data.defaultersCount} students have overdue fees
                </p>
              </div>
            </div>
          )}

          {/* Quick Actions */}
          <div className="space-y-2">
            <button
              onClick={handleSendReminder}
              className="w-full flex items-center justify-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
            >
              <Send className="w-4 h-4" />
              Send Reminders
            </button>
            <button className="w-full text-sm text-blue-600 hover:text-blue-700 transition-colors">
              View Fee Details →
            </button>
          </div>
        </div>
      ) : (
        <div className="text-center py-8">
          <DollarSign className="w-12 h-12 text-gray-300 mx-auto mb-3" />
          <p className="text-gray-500 dark:text-gray-400 text-sm">
            No fee data available
          </p>
        </div>
      )}
    </div>
  );
};

export default FeesSnapshot;

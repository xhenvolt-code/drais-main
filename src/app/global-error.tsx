'use client';

import React, { useEffect } from 'react';
import { motion } from 'framer-motion';
import { AlertTriangle, RefreshCw, Home, Bug } from 'lucide-react';
import Link from 'next/link';

export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    // Log the error to an error reporting service
    console.error('Global error:', error);
  }, [error]);

  const containerVariants = {
    hidden: { opacity: 0, y: 20 },
    visible: {
      opacity: 1,
      y: 0,
      transition: {
        duration: 0.6,
        staggerChildren: 0.1
      }
    }
  };

  const itemVariants = {
    hidden: { opacity: 0, y: 20 },
    visible: { opacity: 1, y: 0 }
  };

  const pulseVariants = {
    animate: {
      scale: [1, 1.05, 1],
      transition: {
        duration: 2,
        repeat: Infinity,
        ease: [0.42, 0, 0.58, 1] as [number, number, number, number]
      }
    }
  };

  return (
    <html>
      <body>
        <div className="min-h-screen bg-gradient-to-br from-red-50 via-orange-50/30 to-yellow-50/20 flex items-center justify-center p-6">
          <motion.div
            variants={containerVariants}
            initial="hidden"
            animate="visible"
            className="max-w-2xl mx-auto text-center"
          >
            {/* Animated Error Icon */}
            <motion.div
              variants={pulseVariants}
              animate="animate"
              className="mb-8"
            >
              <div className="w-32 h-32 mx-auto relative">
                <div className="absolute inset-0 bg-gradient-to-br from-red-100 to-orange-100 rounded-full opacity-20"></div>
                <div className="absolute inset-0 flex items-center justify-center">
                  <div className="w-20 h-20 bg-gradient-to-br from-red-500 to-orange-600 rounded-2xl flex items-center justify-center shadow-xl">
                    <AlertTriangle className="w-10 h-10 text-white" />
                  </div>
                </div>
              </div>
            </motion.div>

            {/* Error Message */}
            <motion.div variants={itemVariants} className="mb-8">
              <h1 className="text-4xl md:text-5xl font-bold text-slate-800 mb-4">
                Something went wrong!
              </h1>
              <p className="text-lg text-slate-600 max-w-xl mx-auto leading-relaxed mb-4">
                We encountered an unexpected error. Don&apos;t worry - our team has been notified and is working on a fix.
              </p>
              {error.digest && (
                <p className="text-sm text-slate-500 font-mono bg-slate-100 rounded-lg px-4 py-2 inline-block">
                  Error ID: {error.digest}
                </p>
              )}
            </motion.div>

            {/* Action Buttons */}
            <motion.div variants={itemVariants} className="flex flex-col sm:flex-row gap-4 justify-center items-center mb-8">
              <motion.button
                onClick={reset}
                whileHover={{ scale: 1.05, y: -2 }}
                whileTap={{ scale: 0.95 }}
                className="flex items-center gap-3 px-8 py-4 bg-gradient-to-r from-red-600 to-orange-600 text-white rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 font-semibold"
              >
                <RefreshCw className="w-5 h-5" />
                Try Again
              </motion.button>

              <Link href="/dashboard">
                <motion.button
                  whileHover={{ scale: 1.05, y: -2 }}
                  whileTap={{ scale: 0.95 }}
                  className="flex items-center gap-3 px-8 py-4 bg-white/80 backdrop-blur-sm text-slate-700 rounded-2xl shadow-lg hover:shadow-xl border border-white/20 transition-all duration-300 font-semibold hover:bg-white/90"
                >
                  <Home className="w-5 h-5" />
                  Go to Dashboard
                </motion.button>
              </Link>
            </motion.div>

            {/* Error Details (Development) */}
            {process.env.NODE_ENV === 'development' && (
              <motion.div variants={itemVariants} className="bg-white/60 backdrop-blur-sm rounded-2xl p-6 border border-white/20 shadow-xl text-left">
                <div className="flex items-center gap-2 mb-4">
                  <Bug className="w-5 h-5 text-red-600" />
                  <h3 className="text-lg font-semibold text-slate-800">
                    Development Error Details
                  </h3>
                </div>
                <pre className="text-sm text-red-600 bg-red-50 rounded-lg p-4 overflow-x-auto">
                  {error.message}
                </pre>
                {error.stack && (
                  <pre className="text-xs text-slate-600 bg-slate-50 rounded-lg p-4 mt-4 overflow-x-auto">
                    {error.stack}
                  </pre>
                )}
              </motion.div>
            )}

            {/* Footer */}
            <motion.div variants={itemVariants} className="mt-8">
              <p className="text-sm text-slate-500">
                If this problem persists, please contact support with the error ID above.
              </p>
            </motion.div>
          </motion.div>
        </div>
      </body>
    </html>
  );
}

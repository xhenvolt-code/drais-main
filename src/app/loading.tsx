'use client';

import React from 'react';
import { motion } from 'framer-motion';
import { BookOpen, Users, GraduationCap } from 'lucide-react';

export default function Loading() {
  const containerVariants = {
    animate: {
      transition: {
        staggerChildren: 0.1
      }
    }
  };

  const itemVariants = {
    animate: {
      y: [0, -10, 0],
      transition: {
        duration: 1.5,
        repeat: Infinity,
        ease: [0.42, 0, 0.58, 1] as [number, number, number, number]
      }
    }
  };

  const spinVariants = {
    animate: {
      rotate: 360,
      transition: {
        duration: 2,
        repeat: Infinity,
        ease: [0, 0, 1, 1] as [number, number, number, number]
      }
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50/30 flex items-center justify-center p-6">
      <motion.div
        variants={containerVariants}
        animate="animate"
        className="text-center"
      >
        {/* Loading Animation */}
        <div className="mb-8 relative">
          <motion.div
            variants={spinVariants}
            animate="animate"
            className="w-20 h-20 mx-auto border-4 border-blue-200 border-t-blue-600 rounded-full"
          ></motion.div>
          
          {/* Floating Icons */}
          <div className="absolute inset-0 flex items-center justify-center">
            <motion.div
              variants={itemVariants}
              animate="animate"
              className="absolute -top-8 -left-8"
            >
              <div className="w-8 h-8 bg-emerald-100 rounded-lg flex items-center justify-center">
                <BookOpen className="w-4 h-4 text-emerald-600" />
              </div>
            </motion.div>
            
            <motion.div
              variants={itemVariants}
              animate="animate"
              style={{ animationDelay: '0.3s' }}
              className="absolute -top-8 -right-8"
            >
              <div className="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                <Users className="w-4 h-4 text-blue-600" />
              </div>
            </motion.div>
            
            <motion.div
              variants={itemVariants}
              animate="animate"
              style={{ animationDelay: '0.6s' }}
              className="absolute -bottom-8 left-1/2 transform -translate-x-1/2"
            >
              <div className="w-8 h-8 bg-purple-100 rounded-lg flex items-center justify-center">
                <GraduationCap className="w-4 h-4 text-purple-600" />
              </div>
            </motion.div>
          </div>
        </div>

        {/* Loading Text */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2 }}
        >
          <h2 className="text-2xl font-semibold text-slate-800 mb-2">
            Loading DRAIS
          </h2>
          <p className="text-slate-600">
            Preparing your school management experience...
          </p>
        </motion.div>

        {/* Progress Dots */}
        <motion.div
          variants={containerVariants}
          animate="animate"
          className="flex justify-center space-x-2 mt-6"
        >
          {[0, 1, 2].map((index) => (
            <motion.div
              key={index}
              variants={itemVariants}
              animate="animate"
              style={{ animationDelay: `${index * 0.2}s` }}
              className="w-2 h-2 bg-blue-600 rounded-full"
            ></motion.div>
          ))}
        </motion.div>
      </motion.div>
    </div>
  );
}

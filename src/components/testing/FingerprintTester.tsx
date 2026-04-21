"use client";
import React, { useState } from 'react';
import { useFingerprint } from '@/hooks/useFingerprint';
import { fingerprintCapture } from '@/utils/fingerprintCapture';
import { Fingerprint, TestTube, CheckCircle, XCircle, AlertCircle, Loader2, Smartphone, Monitor, Play, RefreshCw } from 'lucide-react';
import { toast } from 'react-hot-toast';

interface TestResult {
  test: string;
  status: 'pass' | 'fail' | 'pending';
  message: string;
  timestamp: Date;
  duration?: number;
  details?: any;
}

export const FingerprintTester: React.FC = () => {
  const { 
    isWebAuthnSupported, 
    addFingerprint, 
    verifyFingerprint, 
    removeFingerprint,
    captureFingerprint 
  } = useFingerprint();
  
  const [testResults, setTestResults] = useState<TestResult[]>([]);
  const [testing, setTesting] = useState(false);
  const [testStudentId] = useState(999); // Test student ID
  const [currentTest, setCurrentTest] = useState<string>('');

  const addTestResult = (test: string, status: 'pass' | 'fail' | 'pending', message: string, duration?: number, details?: any) => {
    setTestResults(prev => [...prev, {
      test,
      status,
      message,
      timestamp: new Date(),
      duration,
      details
    }]);
  };

  const updateLastTestResult = (status: 'pass' | 'fail', message: string, duration?: number, details?: any) => {
    setTestResults(prev => {
      const updated = [...prev];
      const lastTest = updated[updated.length - 1];
      if (lastTest) {
        lastTest.status = status;
        lastTest.message = message;
        if (duration) lastTest.duration = duration;
        if (details) lastTest.details = details;
      }
      return updated;
    });
  };

  const runTests = async () => {
    setTesting(true);
    setTestResults([]);

    // Test 1: WebAuthn Support
    setCurrentTest('Checking WebAuthn Support');
    addTestResult('WebAuthn Support', 'pending', 'Checking browser compatibility...');
    
    await new Promise(resolve => setTimeout(resolve, 500));
    
    const isSupported = isWebAuthnSupported();
    updateLastTestResult(
      isSupported ? 'pass' : 'fail',
      isSupported ? 'WebAuthn is supported' : 'WebAuthn is not supported',
      500
    );

    // Test 2: Fingerprint Capture Utility
    setCurrentTest('Testing Fingerprint Capture Utility');
    addTestResult('Fingerprint Capture Utility', 'pending', 'Initializing capture system...');
    
    await new Promise(resolve => setTimeout(resolve, 800));
    
    try {
      const captureSupported = await fingerprintCapture.isSupported();
      updateLastTestResult(
        captureSupported ? 'pass' : 'fail',
        captureSupported ? 'Fingerprint capture system ready' : 'Fingerprint capture not available',
        800,
        { supported: captureSupported }
      );

      if (captureSupported) {
        // Test 3: Simulated Capture
        setCurrentTest('Testing Simulated Capture');
        addTestResult('Simulated Capture', 'pending', 'Testing simulated fingerprint capture...');
        
        const startTime = Date.now();
        const simulatedResult = await fingerprintCapture.simulateFingerprintCapture('phone');
        const duration = Date.now() - startTime;
        
        updateLastTestResult(
          simulatedResult.success ? 'pass' : 'fail',
          simulatedResult.success ? 'Simulated capture successful' : `Simulated capture failed: ${simulatedResult.error}`,
          duration,
          simulatedResult
        );

        if (simulatedResult.success) {
          // Test 4: Backend Storage
          setCurrentTest('Testing Backend Storage');
          addTestResult('Backend Storage', 'pending', 'Testing fingerprint storage...');
          
          try {
            const storageStartTime = Date.now();
            const response = await fetch(`/api/students/${testStudentId}/fingerprint/capture`, {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({
                fingerprintData: simulatedResult.data,
                deviceInfo: simulatedResult.deviceInfo,
                method: 'test'
              })
            });
            
            const storageResult = await response.json();
            const storageDuration = Date.now() - storageStartTime;
            
            updateLastTestResult(
              storageResult.success ? 'pass' : 'fail',
              storageResult.success ? 'Fingerprint stored successfully' : `Storage failed: ${storageResult.error}`,
              storageDuration,
              storageResult
            );

            // Test 5: Full Integration Test
            if (storageResult.success) {
              setCurrentTest('Testing Full Integration');
              addTestResult('Full Integration', 'pending', 'Testing complete workflow...');
              
              try {
                const integrationStartTime = Date.now();
                const integrationSuccess = await captureFingerprint(testStudentId, 'phone');
                const integrationDuration = Date.now() - integrationStartTime;
                
                updateLastTestResult(
                  integrationSuccess ? 'pass' : 'fail',
                  integrationSuccess ? 'Full integration test passed' : 'Integration test failed',
                  integrationDuration,
                  { workflowComplete: integrationSuccess }
                );
              } catch (error: any) {
                updateLastTestResult('fail', `Integration test error: ${error.message}`, undefined, { error: error.message });
              }
            }

          } catch (error: any) {
            updateLastTestResult('fail', `Storage test error: ${error.message}`, undefined, { error: error.message });
          }
        }
      }
    } catch (error: any) {
      updateLastTestResult('fail', `Capture utility error: ${error.message}`, undefined, { error: error.message });
    }

    setCurrentTest('');
    setTesting(false);
    
    toast.success('Fingerprint testing completed!', { duration: 3000 });
  };

  const clearResults = () => {
    setTestResults([]);
  };

  const getStatusIcon = (status: 'pass' | 'fail' | 'pending') => {
    switch (status) {
      case 'pass':
        return <CheckCircle className="w-5 h-5 text-green-500" />;
      case 'fail':
        return <XCircle className="w-5 h-5 text-red-500" />;
      case 'pending':
        return <Loader2 className="w-5 h-5 text-yellow-500 animate-spin" />;
    }
  };

  const getTestProgress = () => {
    const total = testResults.length;
    const completed = testResults.filter(r => r.status !== 'pending').length;
    return { completed, total, percentage: total > 0 ? Math.round((completed / total) * 100) : 0 };
  };

  const progress = getTestProgress();

  return (
    <div className="max-w-4xl mx-auto p-6 bg-white dark:bg-slate-800 rounded-2xl shadow-xl">
      <div className="flex items-center space-x-3 mb-6">
        <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center">
          <TestTube className="w-6 h-6 text-white" />
        </div>
        <div>
          <h2 className="text-2xl font-bold text-gray-900 dark:text-gray-100">
            Real Fingerprint System Tester
          </h2>
          <p className="text-sm text-gray-600 dark:text-gray-400">
            Test complete fingerprint capture and storage workflow
          </p>
        </div>
      </div>

      {/* Test Controls */}
      <div className="flex items-center justify-between mb-6">
        <div className="flex space-x-3">
          <button
            onClick={runTests}
            disabled={testing}
            className="flex items-center space-x-2 px-6 py-3 bg-gradient-to-r from-blue-500 to-purple-600 text-white rounded-xl hover:from-blue-600 hover:to-purple-700 disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-200 shadow-lg hover:shadow-xl"
          >
            <Play className="w-5 h-5" />
            <span>{testing ? 'Running Tests...' : 'Run Complete Test Suite'}</span>
          </button>
          
          <button
            onClick={clearResults}
            disabled={testing}
            className="flex items-center space-x-2 px-4 py-3 bg-gray-200 dark:bg-slate-600 text-gray-700 dark:text-gray-200 rounded-xl hover:bg-gray-300 dark:hover:bg-slate-500 disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-200"
          >
            <RefreshCw className="w-5 h-5" />
            <span>Clear Results</span>
          </button>
        </div>

        {/* Progress Indicator */}
        {testResults.length > 0 && (
          <div className="flex items-center space-x-3">
            <div className="text-sm text-gray-600 dark:text-gray-400">
              Progress: {progress.completed}/{progress.total} ({progress.percentage}%)
            </div>
            <div className="w-32 bg-gray-200 rounded-full h-2">
              <div 
                className="bg-gradient-to-r from-blue-500 to-purple-600 h-2 rounded-full transition-all duration-300"
                style={{ width: `${progress.percentage}%` }}
              />
            </div>
          </div>
        )}
      </div>

      {/* Current Test Status */}
      {currentTest && (
        <div className="mb-6 p-4 bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg">
          <div className="flex items-center space-x-2">
            <Loader2 className="w-4 h-4 animate-spin text-blue-600" />
            <span className="text-sm text-blue-800 dark:text-blue-200">
              Currently running: {currentTest}
            </span>
          </div>
        </div>
      )}

      {/* Test Results */}
      {testResults.length > 0 && (
        <div className="space-y-3">
          <h3 className="text-lg font-semibold text-gray-900 dark:text-gray-100 mb-4">
            Test Results
          </h3>
          
          {testResults.map((result, index) => (
            <div
              key={index}
              className="flex items-start space-x-3 p-4 bg-gray-50 dark:bg-slate-700 rounded-lg"
            >
              {getStatusIcon(result.status)}
              <div className="flex-1">
                <div className="flex items-center justify-between">
                  <span className="font-medium text-gray-900 dark:text-gray-100">
                    {result.test}
                  </span>
                  <div className="flex items-center space-x-2 text-xs text-gray-500 dark:text-gray-400">
                    {result.duration && (
                      <span>{result.duration}ms</span>
                    )}
                    <span>{result.timestamp.toLocaleTimeString()}</span>
                  </div>
                </div>
                <p className="text-sm text-gray-600 dark:text-gray-400 mt-1">
                  {result.message}
                </p>
                {result.details && (
                  <details className="mt-2">
                    <summary className="text-xs text-gray-500 cursor-pointer hover:text-gray-700">
                      Show Details
                    </summary>
                    <pre className="text-xs bg-gray-100 dark:bg-slate-800 p-2 rounded mt-1 overflow-auto max-h-32">
                      {JSON.stringify(result.details, null, 2)}
                    </pre>
                  </details>
                )}
              </div>
            </div>
          ))}
        </div>
      )}

      {/* System Information */}
      <div className="mt-8 grid grid-cols-1 md:grid-cols-2 gap-4">
        {/* Browser Compatibility */}
        <div className="p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg">
          <h4 className="font-medium text-blue-900 dark:text-blue-100 mb-2 flex items-center space-x-2">
            <Smartphone className="w-4 h-4" />
            <span>Browser Compatibility</span>
          </h4>
          <div className="text-sm text-blue-800 dark:text-blue-200 space-y-1">
            <div>✅ Chrome 67+ (Desktop & Mobile)</div>
            <div>✅ Safari 14+ (Desktop & Mobile)</div>
            <div>✅ Edge 18+</div>
            <div>⚠️ Firefox 60+ (requires configuration)</div>
            <div>🔒 Requires HTTPS in production</div>
          </div>
        </div>

        {/* Device Support */}
        <div className="p-4 bg-green-50 dark:bg-green-900/20 rounded-lg">
          <h4 className="font-medium text-green-900 dark:text-green-100 mb-2 flex items-center space-x-2">
            <Monitor className="w-4 h-4" />
            <span>Device Support</span>
          </h4>
          <div className="text-sm text-green-800 dark:text-green-200 space-y-1">
            <div>📱 Phone biometric sensors</div>
            <div>💻 Laptop fingerprint readers</div>
            <div>🖱️ External USB scanners</div>
            <div>🔐 Windows Hello / Touch ID</div>
            <div>⚡ Real-time capture & storage</div>
          </div>
        </div>
      </div>

      {/* Demo Information */}
      <div className="mt-6 p-4 bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 rounded-lg">
        <div className="flex items-start space-x-2">
          <AlertCircle className="w-5 h-5 text-yellow-600 flex-shrink-0 mt-0.5" />
          <div className="text-sm text-yellow-800 dark:text-yellow-200">
            <p className="font-medium mb-1">Demo Mode Information</p>
            <p>
              This tester validates the complete fingerprint capture workflow including real WebAuthn/biometric 
              integration where available. In demo environments, simulated data is used while maintaining 
              identical API interfaces for production deployment.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

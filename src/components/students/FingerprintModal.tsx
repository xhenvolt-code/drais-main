"use client";
import React, { Fragment, useEffect, useState } from 'react';
import { Dialog, Transition } from '@headlessui/react';
import { X, Fingerprint, Smartphone, Monitor, CheckCircle, XCircle, AlertCircle, Loader2, Shield, Eye } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { useFingerprint } from '@/hooks/useFingerprint';
import { toast } from 'react-hot-toast';

interface Student {
  id: number;
  first_name: string;
  last_name: string;
  admission_no?: string;
  photo_url?: string;
}

interface FingerprintModalProps {
  open: boolean;
  onClose: () => void;
  student: Student | null;
}

type OperationType = 'add' | 'update' | 'verify' | 'remove' | null;
type MethodType = 'phone' | 'biometric' | null;

export const FingerprintModal: React.FC<FingerprintModalProps> = ({
  open,
  onClose,
  student
}) => {
  const {
    loading,
    status,
    demoMode,
    capturing,
    isWebAuthnSupported,
    getFingerprintStatus,
    addFingerprint,
    updateFingerprint,
    verifyFingerprint,
    removeFingerprint,
    captureFingerprint
  } = useFingerprint();

  const [currentOperation, setCurrentOperation] = useState<OperationType>(null);
  const [selectedMethod, setSelectedMethod] = useState<MethodType>(null);
  const [showConfirmation, setShowConfirmation] = useState(false);
  const [dataLoaded, setDataLoaded] = useState(false);

  // Load fingerprint status when modal opens
  useEffect(() => {
    if (open && student) {
      getFingerprintStatus(student.id).then(() => {
        setDataLoaded(true);
      });
    }
  }, [open, student, getFingerprintStatus]);

  // Reset state when modal closes
  useEffect(() => {
    if (!open) {
      setCurrentOperation(null);
      setSelectedMethod(null);
      setShowConfirmation(false);
      setDataLoaded(false);
    }
  }, [open]);

  const handleClose = () => {
    if (loading) return;
    onClose();
  };

  const handleOperation = async (operation: OperationType, method: MethodType) => {
    if (!student || !method) return;

    setCurrentOperation(operation);
    setSelectedMethod(method);

    if (operation === 'remove') {
      setShowConfirmation(true);
      return;
    }

    try {
      let success = false;
      
      switch (operation) {
        case 'add':
          // Use real fingerprint capture
          success = await captureFingerprint(student.id, method);
          break;
        case 'update':
          success = await updateFingerprint(student.id, method);
          break;
        case 'verify':
          success = await verifyFingerprint(student.id, method);
          break;
      }

      if (success) {
        // Add visual feedback for successful operation
        setTimeout(() => {
          setCurrentOperation(null);
          setSelectedMethod(null);
        }, 1000);
      }
    } catch (error) {
      console.error('Operation failed:', error);
    } finally {
      setCurrentOperation(null);
      setSelectedMethod(null);
    }
  };

  const handleConfirmRemoval = async () => {
    if (!student || !selectedMethod) return;

    const success = await removeFingerprint(student.id, selectedMethod);
    setShowConfirmation(false);
    setCurrentOperation(null);
    setSelectedMethod(null);
  };

  const getStatusIcon = (method: 'phone' | 'biometric') => {
    const isRegistered = method === 'phone' ? status?.hasPhone : status?.hasBiometric;
    
    if (isRegistered) {
      return <CheckCircle className="w-5 h-5 text-green-500" />;
    }
    return <XCircle className="w-5 h-5 text-gray-400" />;
  };

  const getStatusText = (method: 'phone' | 'biometric') => {
    const isRegistered = method === 'phone' ? status?.hasPhone : status?.hasBiometric;
    
    if (isRegistered) {
      const fingerprintData = status?.fingerprints.find(fp => fp.method === method);
      return (
        <div>
          <span className="text-green-600 font-medium">Registered</span>
          {fingerprintData && (
            <div className="text-xs text-gray-500 mt-1">
              Added: {new Date(fingerprintData.createdAt).toLocaleDateString()}
            </div>
          )}
        </div>
      );
    }
    return <span className="text-gray-500">Not Registered</span>;
  };

  const renderMethodCard = (method: 'phone' | 'biometric', icon: React.ReactNode, title: string, description: string) => {
    const isRegistered = method === 'phone' ? status?.hasPhone : status?.hasBiometric;
    const isCurrentOperation = currentOperation && selectedMethod === method;
    const isCapturing = capturing && selectedMethod === method;
    
    return (
      <motion.div
        layout
        className="bg-gradient-to-br from-white/80 to-gray-50/60 dark:from-slate-800/80 dark:to-slate-700/60 rounded-2xl p-6 border border-gray-200/50 dark:border-gray-600/50 shadow-lg hover:shadow-xl transition-all duration-300"
      >
        <div className="flex items-start space-x-4">
          <div className="flex-shrink-0">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center shadow-lg">
              {icon}
            </div>
          </div>
          
          <div className="flex-1 min-w-0">
            <div className="flex items-center justify-between mb-2">
              <h3 className="text-lg font-semibold text-gray-900 dark:text-gray-100">
                {title}
              </h3>
              {getStatusIcon(method)}
            </div>
            
            <p className="text-sm text-gray-600 dark:text-gray-400 mb-3">
              {description}
            </p>
            
            <div className="mb-4">
              {getStatusText(method)}
            </div>
            
            {/* Capture Progress */}
            {isCapturing && (
              <div className="mb-4 p-3 bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg">
                <div className="flex items-center space-x-2">
                  <Loader2 className="w-4 h-4 animate-spin text-blue-600" />
                  <span className="text-sm text-blue-800 dark:text-blue-200">
                    Capturing fingerprint... Please keep your finger on the scanner.
                  </span>
                </div>
              </div>
            )}
            
            {/* Action Buttons */}
            <div className="flex flex-wrap gap-2">
              {!isRegistered ? (
                <button
                  onClick={() => handleOperation('add', method)}
                  disabled={loading || capturing || (!isWebAuthnSupported() && !demoMode)}
                  className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-green-500 to-emerald-600 text-white rounded-lg hover:from-green-600 hover:to-emerald-700 disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-200 shadow-md hover:shadow-lg"
                >
                  {isCurrentOperation || isCapturing ? (
                    <Loader2 className="w-4 h-4 animate-spin" />
                  ) : (
                    <Fingerprint className="w-4 h-4" />
                  )}
                  {isCapturing ? 'Capturing...' : 'Capture Fingerprint'}
                </button>
              ) : (
                <>
                  <button
                    onClick={() => handleOperation('verify', method)}
                    disabled={loading}
                    className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-blue-500 to-indigo-600 text-white rounded-lg hover:from-blue-600 hover:to-indigo-700 disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-200 shadow-md hover:shadow-lg"
                  >
                    {isCurrentOperation && currentOperation === 'verify' ? (
                      <Loader2 className="w-4 h-4 animate-spin" />
                    ) : (
                      <Eye className="w-4 h-4" />
                    )}
                    Verify
                  </button>
                  
                  <button
                    onClick={() => handleOperation('update', method)}
                    disabled={loading}
                    className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-orange-500 to-amber-600 text-white rounded-lg hover:from-orange-600 hover:to-amber-700 disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-200 shadow-md hover:shadow-lg"
                  >
                    {isCurrentOperation && currentOperation === 'update' ? (
                      <Loader2 className="w-4 h-4 animate-spin" />
                    ) : (
                      <Fingerprint className="w-4 h-4" />
                    )}
                    Update
                  </button>
                  
                  <button
                    onClick={() => handleOperation('remove', method)}
                    disabled={loading}
                    className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-red-500 to-rose-600 text-white rounded-lg hover:from-red-600 hover:to-rose-700 disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-200 shadow-md hover:shadow-lg"
                  >
                    <X className="w-4 h-4" />
                    Remove
                  </button>
                </>
              )}
            </div>
          </div>
        </div>
      </motion.div>
    );
  };

  if (!student) return null;

  return (
    <>
      <Transition show={open} as={Fragment}>
        <Dialog as="div" className="relative z-50" onClose={handleClose}>
          <Transition.Child
            as={Fragment}
            enter="ease-out duration-300"
            enterFrom="opacity-0"
            enterTo="opacity-100"
            leave="ease-in duration-200"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <div className="fixed inset-0 bg-gradient-to-br from-slate-900/80 via-fuchsia-900/60 to-indigo-900/80 backdrop-blur" />
          </Transition.Child>

          <div className="fixed inset-0 overflow-y-auto">
            <div className="flex min-h-full items-center justify-center p-4 text-center">
              <Transition.Child
                as={Fragment}
                enter="ease-out duration-300"
                enterFrom="opacity-0 scale-95"
                enterTo="opacity-100 scale-100"
                leave="ease-in duration-200"
                leaveFrom="opacity-100 scale-100"
                leaveTo="opacity-0 scale-95"
              >
                <Dialog.Panel className="w-full max-w-4xl transform overflow-hidden rounded-3xl border border-white/15 dark:border-white/10 bg-gradient-to-br from-white/90 via-white/70 to-white/50 dark:from-slate-900/90 dark:via-slate-900/70 dark:to-slate-800/60 backdrop-blur-2xl shadow-2xl transition-all p-6">
                  <div className="absolute inset-0 pointer-events-none">
                    <div className="absolute -top-16 -right-10 w-72 h-72 bg-fuchsia-400/20 blur-3xl rounded-full" />
                    <div className="absolute -bottom-24 -left-20 w-96 h-96 bg-indigo-500/20 blur-3xl rounded-full" />
                  </div>

                  <div className="relative">
                    {/* Header */}
                    <div className="flex items-center justify-between mb-6">
                      <div className="flex items-center space-x-4">
                        <div className="w-16 h-16 rounded-xl bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center shadow-lg">
                          <Shield className="w-8 h-8 text-white" />
                        </div>
                        <div className="text-left">
                          <Dialog.Title className="text-2xl font-bold text-gray-900 dark:text-gray-100">
                            Fingerprint Management
                          </Dialog.Title>
                          <p className="text-sm text-gray-600 dark:text-gray-400 mt-1">
                            {student.first_name} {student.last_name}
                            {student.admission_no && (
                              <span className="ml-2 text-gray-500">({student.admission_no})</span>
                            )}
                          </p>
                        </div>
                      </div>
                      
                      <button
                        onClick={handleClose}
                        className="p-2 rounded-lg hover:bg-black/10 dark:hover:bg-white/10 transition-colors"
                      >
                        <X className="w-6 h-6 text-gray-500" />
                      </button>
                    </div>

                    {/* Demo Mode Notice */}
                    {demoMode && (
                      <div className="mb-6 p-4 bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg">
                        <div className="flex items-center space-x-2">
                          <AlertCircle className="w-5 h-5 text-blue-600" />
                          <p className="text-sm text-blue-800 dark:text-blue-200">
                            <strong>Demo Mode Active:</strong> Fingerprint operations are simulated for demonstration. 
                            No real biometric data is stored.
                          </p>
                        </div>
                      </div>
                    )}

                    {/* WebAuthn Support Check */}
                    {!isWebAuthnSupported() && !demoMode && (
                      <div className="mb-6 p-4 bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 rounded-lg">
                        <div className="flex items-center space-x-2">
                          <AlertCircle className="w-5 h-5 text-yellow-600" />
                          <p className="text-sm text-yellow-800 dark:text-yellow-200">
                            Fingerprint authentication is not supported on this device or browser. 
                            Demo mode is available for testing.
                          </p>
                        </div>
                      </div>
                    )}

                    {/* Loading State */}
                    {loading && !dataLoaded && (
                      <div className="flex items-center justify-center py-12">
                        <Loader2 className="w-8 h-8 animate-spin text-blue-500" />
                        <span className="ml-3 text-gray-600 dark:text-gray-400">
                          Loading fingerprint status...
                        </span>
                      </div>
                    )}

                    {/* Main Content - Always show if data is loaded or in demo mode */}
                    {(dataLoaded || demoMode) && (
                      <div className="space-y-6">
                        {/* Phone Method */}
                        {renderMethodCard(
                          'phone',
                          <Smartphone className="w-6 h-6 text-white" />,
                          'Phone Authentication',
                          'Use your phone\'s built-in biometric sensors for authentication'
                        )}

                        {/* Biometric Method */}
                        {renderMethodCard(
                          'biometric',
                          <Monitor className="w-6 h-6 text-white" />,
                          'External Biometric Device',
                          'Use an external fingerprint scanner connected to this computer'
                        )}
                      </div>
                    )}

                    {/* Security Notice */}
                    <div className="mt-6 p-4 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg">
                      <div className="flex items-start space-x-2">
                        <Shield className="w-5 h-5 text-green-600 flex-shrink-0 mt-0.5" />
                        <div className="text-sm text-green-800 dark:text-green-200">
                          <p className="font-medium mb-1">Security Information</p>
                          <p>
                            {demoMode 
                              ? "This demonstration uses simulated fingerprint data. In production, all fingerprint data will be encrypted and stored securely with enterprise-grade security."
                              : "All fingerprint data is encrypted and stored securely. Only authorized personnel can access fingerprint management features."
                            }
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                </Dialog.Panel>
              </Transition.Child>
            </div>
          </div>
        </Dialog>
      </Transition>

      {/* Confirmation Modal for Removal */}
      <Transition show={showConfirmation} as={Fragment}>
        <Dialog as="div" className="relative z-[60]" onClose={() => setShowConfirmation(false)}>
          <Transition.Child
            as={Fragment}
            enter="ease-out duration-300"
            enterFrom="opacity-0"
            enterTo="opacity-100"
            leave="ease-in duration-200"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <div className="fixed inset-0 bg-black/50" />
          </Transition.Child>

          <div className="fixed inset-0 overflow-y-auto">
            <div className="flex min-h-full items-center justify-center p-4 text-center">
              <Transition.Child
                as={Fragment}
                enter="ease-out duration-300"
                enterFrom="opacity-0 scale-95"
                enterTo="opacity-100 scale-100"
                leave="ease-in duration-200"
                leaveFrom="opacity-100 scale-100"
                leaveTo="opacity-0 scale-95"
              >
                <Dialog.Panel className="w-full max-w-md transform overflow-hidden rounded-2xl bg-white dark:bg-slate-800 p-6 text-left align-middle shadow-xl transition-all">
                  <div className="flex items-center space-x-3 mb-4">
                    <div className="w-10 h-10 rounded-full bg-red-100 dark:bg-red-900/30 flex items-center justify-center">
                      <AlertCircle className="w-5 h-5 text-red-600" />
                    </div>
                    <Dialog.Title className="text-lg font-medium text-gray-900 dark:text-gray-100">
                      Remove Fingerprint
                    </Dialog.Title>
                  </div>

                  <p className="text-sm text-gray-600 dark:text-gray-400 mb-6">
                    Are you sure you want to remove the {selectedMethod} fingerprint for {student.first_name} {student.last_name}? 
                    This action cannot be undone.
                  </p>

                  <div className="flex space-x-3">
                    <button
                      onClick={handleConfirmRemoval}
                      disabled={loading}
                      className="flex-1 px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                    >
                      {loading ? (
                        <Loader2 className="w-4 h-4 animate-spin mx-auto" />
                      ) : (
                        'Remove Fingerprint'
                      )}
                    </button>
                    <button
                      onClick={() => setShowConfirmation(false)}
                      className="flex-1 px-4 py-2 bg-gray-200 dark:bg-slate-600 text-gray-800 dark:text-gray-200 rounded-lg hover:bg-gray-300 dark:hover:bg-slate-500 transition-colors"
                    >
                      Cancel
                    </button>
                  </div>
                </Dialog.Panel>
              </Transition.Child>
            </div>
          </div>
        </Dialog>
      </Transition>
    </>
  );
};

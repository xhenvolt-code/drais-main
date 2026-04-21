"use client";
import React, { useState, useEffect } from 'react';
import { CreditCard } from 'lucide-react';
import Modal from '@/components/ui/Modal';
import { toast } from 'react-hot-toast';
import useSWR from 'swr';
import { fetcher } from '@/utils/fetcher';

interface FeeData {
  id?: number;
  class_id: number;
  term_id: number;
  item: string;
  amount: number;
}

interface FeeModalProps {
  open: boolean;
  onClose: () => void;
  onSubmit: () => void;
  mode: 'add' | 'edit';
  initialData?: FeeData;
  schoolId: number;
}

const FeeModal: React.FC<FeeModalProps> = ({
  open,
  onClose,
  onSubmit,
  mode,
  initialData,
  schoolId
}) => {
  const [formData, setFormData] = useState<FeeData>({
    class_id: 0,
    term_id: 0,
    item: '',
    amount: 0
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  // Fetch classes and terms
  const { data: classesData } = useSWR(`/api/classes?school_id=${schoolId}`, fetcher);
  const { data: termsData } = useSWR(`/api/terms?school_id=${schoolId}`, fetcher);

  const classes = classesData?.data || [];
  const terms = termsData?.data || [];

  // Common fee items
  const commonFeeItems = [
    'Tuition Fees',
    'Registration Fees',
    'Examination Fees',
    'Library Fees',
    'Sports Fees',
    'Transport Fees',
    'Boarding Fees',
    'Activity Fees',
    'Laboratory Fees',
    'Computer Fees'
  ];

  // Reset form when modal opens/closes or mode changes
  useEffect(() => {
    if (open) {
      if (mode === 'edit' && initialData) {
        setFormData(initialData);
      } else {
        setFormData({
          class_id: 0,
          term_id: 0,
          item: '',
          amount: 0
        });
      }
      setErrors({});
    }
  }, [open, mode, initialData]);

  const validateForm = () => {
    const newErrors: Record<string, string> = {};

    if (!formData.class_id) {
      newErrors.class_id = 'Class is required';
    }

    if (!formData.term_id) {
      newErrors.term_id = 'Term is required';
    }

    if (!formData.item.trim()) {
      newErrors.item = 'Fee item is required';
    }

    if (formData.amount <= 0) {
      newErrors.amount = 'Amount must be greater than 0';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!validateForm()) {
      return;
    }

    setIsSubmitting(true);

    try {
      const url = mode === 'edit' 
        ? `/api/finance/fees/${formData.id}`
        : '/api/finance/fees';
      
      const method = mode === 'edit' ? 'PUT' : 'POST';

      const response = await fetch(url, {
        method,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          ...formData,
          school_id: schoolId
        })
      });

      const result = await response.json();

      if (result.success) {
        toast.success(
          mode === 'edit' 
            ? 'Fee structure updated successfully!' 
            : 'Fee structure created successfully!'
        );
        onSubmit();
        onClose();
      } else {
        toast.error(result.error || 'Failed to save fee structure');
      }
    } catch (error) {
      toast.error('An error occurred while saving');
      console.error('Fee save error:', error);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleInputChange = (field: keyof FeeData, value: string | number) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
    
    // Clear error when user starts typing
    if (errors[field]) {
      setErrors(prev => ({
        ...prev,
        [field]: ''
      }));
    }
  };

  return (
    <Modal
      title={mode === 'edit' ? 'Edit Fee Structure' : 'Add Fee Structure'}
      open={open}
      onClose={onClose}
      size="md"
    >
      <form onSubmit={handleSubmit} className="space-y-6">
        {/* Class and Term Selection */}
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
              Class *
            </label>
            <select
              value={formData.class_id}
              onChange={(e) => handleInputChange('class_id', parseInt(e.target.value))}
              className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors ${
                errors.class_id ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
              } bg-white dark:bg-slate-700 text-gray-900 dark:text-white`}
              disabled={isSubmitting}
            >
              <option value="">Select Class</option>
              {classes.map((cls: any) => (
                <option key={cls.id} value={cls.id}>
                  {cls.name}
                </option>
              ))}
            </select>
            {errors.class_id && (
              <p className="mt-1 text-sm text-red-600">{errors.class_id}</p>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
              Term *
            </label>
            <select
              value={formData.term_id}
              onChange={(e) => handleInputChange('term_id', parseInt(e.target.value))}
              className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors ${
                errors.term_id ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
              } bg-white dark:bg-slate-700 text-gray-900 dark:text-white`}
              disabled={isSubmitting}
            >
              <option value="">Select Term</option>
              {terms.map((term: any) => (
                <option key={term.id} value={term.id}>
                  {term.name}
                </option>
              ))}
            </select>
            {errors.term_id && (
              <p className="mt-1 text-sm text-red-600">{errors.term_id}</p>
            )}
          </div>
        </div>

        {/* Fee Item */}
        <div>
          <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Fee Item *
          </label>
          <div className="space-y-3">
            <input
              type="text"
              value={formData.item}
              onChange={(e) => handleInputChange('item', e.target.value)}
              className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors ${
                errors.item ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
              } bg-white dark:bg-slate-700 text-gray-900 dark:text-white`}
              placeholder="Enter fee item name"
              disabled={isSubmitting}
            />
            
            {/* Quick Select Common Items */}
            <div className="flex flex-wrap gap-2">
              <span className="text-xs text-gray-500">Quick select:</span>
              {commonFeeItems.slice(0, 5).map((item) => (
                <button
                  key={item}
                  type="button"
                  onClick={() => handleInputChange('item', item)}
                  className="text-xs px-2 py-1 bg-gray-100 dark:bg-slate-600 text-gray-700 dark:text-gray-300 rounded hover:bg-gray-200 dark:hover:bg-slate-500 transition-colors"
                  disabled={isSubmitting}
                >
                  {item}
                </button>
              ))}
            </div>
          </div>
          {errors.item && (
            <p className="mt-1 text-sm text-red-600">{errors.item}</p>
          )}
        </div>

        {/* Amount */}
        <div>
          <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Amount (UGX) *
          </label>
          <div className="relative">
            <input
              type="number"
              min="0"
              step="0.01"
              value={formData.amount}
              onChange={(e) => handleInputChange('amount', parseFloat(e.target.value) || 0)}
              className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors ${
                errors.amount ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
              } bg-white dark:bg-slate-700 text-gray-900 dark:text-white`}
              placeholder="0.00"
              disabled={isSubmitting}
            />
            {formData.amount > 0 && (
              <div className="mt-1 text-sm text-gray-500">
                UGX {formData.amount.toLocaleString()}
              </div>
            )}
          </div>
          {errors.amount && (
            <p className="mt-1 text-sm text-red-600">{errors.amount}</p>
          )}
        </div>

        {/* Submit Buttons */}
        <div className="flex items-center justify-end space-x-4 pt-4 border-t border-gray-200 dark:border-gray-700">
          <button
            type="button"
            onClick={onClose}
            className="px-6 py-2 border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 rounded-lg hover:bg-gray-50 dark:hover:bg-slate-700 transition-colors"
            disabled={isSubmitting}
          >
            Cancel
          </button>
          <button
            type="submit"
            disabled={isSubmitting}
            className="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg transition-colors disabled:opacity-50 disabled:cursor-not-allowed flex items-center space-x-2"
          >
            {isSubmitting && (
              <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
            )}
            <span>{mode === 'edit' ? 'Update Fee' : 'Create Fee'}</span>
          </button>
        </div>
      </form>
    </Modal>
  );
};

export default FeeModal;

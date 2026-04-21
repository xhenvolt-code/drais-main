"use client";
import React, { useState } from 'react';
import { MessageSquare, Send, Phone, Mail, Clock, CheckCircle2, X, Smartphone } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import Swal from 'sweetalert2';

interface NotificationTemplate {
  id: string;
  name: string;
  message: string;
  type: 'absence' | 'late' | 'disciplinary' | 'custom';
}

interface ParentNotificationsProps {
  studentId?: number;
  classId?: string;
  onClose?: () => void;
}

const defaultTemplates: NotificationTemplate[] = [
  {
    id: 'absence',
    name: 'Student Absence',
    message: 'Your child {student_name} was marked absent today ({date}). Please contact the school if this is an error.',
    type: 'absence'
  },
  {
    id: 'late',
    name: 'Late Arrival',
    message: 'Your child {student_name} arrived late to school today. Please ensure punctuality.',
    type: 'late'
  },
  {
    id: 'low_attendance',
    name: 'Low Attendance Alert',
    message: 'Your child {student_name} has attendance below 75%. Current rate: {attendance_rate}%. Please contact the school to discuss.',
    type: 'disciplinary'
  },
  {
    id: 'good_attendance',
    name: 'Good Attendance',
    message: 'Congratulations! {student_name} has excellent attendance of {attendance_rate}%. Keep up the good work!',
    type: 'custom'
  }
];

export const ParentNotifications: React.FC<ParentNotificationsProps> = ({
  studentId,
  classId,
  onClose
}) => {
  const [selectedTemplate, setSelectedTemplate] = useState<string>('');
  const [customMessage, setCustomMessage] = useState('');
  const [communicationMethods, setCommunicationMethods] = useState({
    sms: true,
    email: true,
    whatsapp: false
  });
  const [isLoading, setIsLoading] = useState(false);
  const [sendHistory, setSendHistory] = useState<any[]>([]);

  const sendNotification = async () => {
    if (!selectedTemplate && !customMessage.trim()) {
      Swal.fire('Error', 'Please select a template or write a custom message', 'error');
      return;
    }

    const template = defaultTemplates.find(t => t.id === selectedTemplate);
    const messageToSend = template ? template.message : customMessage;

    if (!Object.values(communicationMethods).some(method => method)) {
      Swal.fire('Error', 'Please select at least one communication method', 'error');
      return;
    }

    setIsLoading(true);

    try {
      const response = await fetch('/api/notifications/send', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          student_id: studentId,
          class_id: classId,
          message: messageToSend,
          template_id: selectedTemplate,
          methods: communicationMethods
        })
      });

      const result = await response.json();

      if (result.success) {
        Swal.fire({
          title: 'Messages Sent Successfully! 📱',
          html: `
            <div class="text-center space-y-2">
              ${communicationMethods.sms ? `<p>✅ SMS: ${result.sms_sent || 0} sent</p>` : ''}
              ${communicationMethods.email ? `<p>✅ Email: ${result.emails_sent || 0} sent</p>` : ''}
              ${communicationMethods.whatsapp ? `<p>✅ WhatsApp: ${result.whatsapp_sent || 0} sent</p>` : ''}
              <p class="text-sm text-gray-600 mt-3">Total recipients: ${result.total_recipients || 0}</p>
            </div>
          `,
          icon: 'success'
        });

        // Reset form
        setSelectedTemplate('');
        setCustomMessage('');
        
        // Add to history
        setSendHistory(prev => [{
          id: Date.now(),
          message: messageToSend,
          methods: communicationMethods,
          timestamp: new Date(),
          recipients: result.total_recipients || 0
        }, ...prev]);

      } else {
        Swal.fire('Error', result.error || 'Failed to send notifications', 'error');
      }
    } catch (error) {
      Swal.fire('Error', 'An unexpected error occurred', 'error');
    } finally {
      setIsLoading(false);
    }
  };

  const previewMessage = () => {
    const template = defaultTemplates.find(t => t.id === selectedTemplate);
    const message = template ? template.message : customMessage;
    
    // Replace placeholders with sample data
    const previewText = message
      .replace('{student_name}', 'John Doe')
      .replace('{date}', new Date().toLocaleDateString())
      .replace('{attendance_rate}', '85');

    Swal.fire({
      title: 'Message Preview',
      html: `
        <div class="text-left p-4 bg-gray-50 rounded-lg">
          <p class="text-sm text-gray-600 mb-2">Preview:</p>
          <p class="text-gray-800">${previewText}</p>
        </div>
      `,
      confirmButtonText: 'Close'
    });
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
      <div className="absolute inset-0 bg-black/50" onClick={onClose} />
      <motion.div
        initial={{ scale: 0.9, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        exit={{ scale: 0.9, opacity: 0 }}
        className="relative bg-white dark:bg-slate-800 rounded-2xl shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto"
      >
        {/* Header */}
        <div className="sticky top-0 bg-white dark:bg-slate-800 p-6 border-b border-gray-200 dark:border-gray-600 rounded-t-2xl">
          <div className="flex items-center justify-between">
            <h2 className="text-xl font-semibold text-gray-900 dark:text-white flex items-center gap-2">
              <MessageSquare className="w-6 h-6 text-blue-600" />
              Parent Communication
            </h2>
            <button
              onClick={onClose}
              className="p-2 hover:bg-gray-100 dark:hover:bg-slate-700 rounded-lg transition-colors"
            >
              <X className="w-5 h-5" />
            </button>
          </div>
        </div>

        <div className="p-6 space-y-6">
          {/* Template Selection */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
              Message Template
            </label>
            <select
              value={selectedTemplate}
              onChange={(e) => {
                setSelectedTemplate(e.target.value);
                setCustomMessage('');
              }}
              className="input-field"
            >
              <option value="">Choose a template or write custom message</option>
              {defaultTemplates.map((template) => (
                <option key={template.id} value={template.id}>
                  {template.name}
                </option>
              ))}
            </select>
          </div>

          {/* Custom Message */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
              Custom Message
            </label>
            <textarea
              value={selectedTemplate ? defaultTemplates.find(t => t.id === selectedTemplate)?.message || '' : customMessage}
              onChange={(e) => {
                if (!selectedTemplate) {
                  setCustomMessage(e.target.value);
                }
              }}
              placeholder="Write your custom message here..."
              rows={4}
              className="input-field resize-none"
              disabled={!!selectedTemplate}
            />
            <p className="text-xs text-gray-500 mt-1">
              Available placeholders: {'{student_name}'}, {'{date}'}, {'{attendance_rate}'}
            </p>
          </div>

          {/* Communication Methods */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">
              Communication Methods
            </label>
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
              <label className="flex items-center p-3 border border-gray-200 dark:border-gray-600 rounded-lg cursor-pointer hover:bg-gray-50 dark:hover:bg-slate-700">
                <input
                  type="checkbox"
                  checked={communicationMethods.sms}
                  onChange={(e) => setCommunicationMethods(prev => ({ ...prev, sms: e.target.checked }))}
                  className="mr-3"
                />
                <Smartphone className="w-5 h-5 text-green-600 mr-2" />
                <span className="text-sm font-medium">SMS</span>
              </label>

              <label className="flex items-center p-3 border border-gray-200 dark:border-gray-600 rounded-lg cursor-pointer hover:bg-gray-50 dark:hover:bg-slate-700">
                <input
                  type="checkbox"
                  checked={communicationMethods.email}
                  onChange={(e) => setCommunicationMethods(prev => ({ ...prev, email: e.target.checked }))}
                  className="mr-3"
                />
                <Mail className="w-5 h-5 text-blue-600 mr-2" />
                <span className="text-sm font-medium">Email</span>
              </label>

              <label className="flex items-center p-3 border border-gray-200 dark:border-gray-600 rounded-lg cursor-pointer hover:bg-gray-50 dark:hover:bg-slate-700">
                <input
                  type="checkbox"
                  checked={communicationMethods.whatsapp}
                  onChange={(e) => setCommunicationMethods(prev => ({ ...prev, whatsapp: e.target.checked }))}
                  className="mr-3"
                />
                <MessageSquare className="w-5 h-5 text-green-500 mr-2" />
                <span className="text-sm font-medium">WhatsApp</span>
              </label>
            </div>
          </div>

          {/* Actions */}
          <div className="flex gap-3">
            <button
              onClick={previewMessage}
              className="btn-secondary flex-1"
              disabled={!selectedTemplate && !customMessage.trim()}
            >
              Preview Message
            </button>
            <button
              onClick={sendNotification}
              disabled={isLoading || (!selectedTemplate && !customMessage.trim())}
              className="btn-primary flex-1 gap-2"
            >
              {isLoading ? (
                <>
                  <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                  Sending...
                </>
              ) : (
                <>
                  <Send className="w-4 h-4" />
                  Send Message
                </>
              )}
            </button>
          </div>

          {/* Send History */}
          {sendHistory.length > 0 && (
            <div>
              <h3 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">
                Recent Messages
              </h3>
              <div className="space-y-2 max-h-40 overflow-y-auto">
                {sendHistory.map((item) => (
                  <div key={item.id} className="p-3 bg-gray-50 dark:bg-slate-700 rounded-lg text-sm">
                    <div className="flex items-center justify-between mb-1">
                      <span className="font-medium text-gray-900 dark:text-white">
                        {item.recipients} recipients
                      </span>
                      <span className="text-xs text-gray-500">
                        {item.timestamp.toLocaleTimeString()}
                      </span>
                    </div>
                    <p className="text-gray-600 dark:text-gray-400 text-xs line-clamp-2">
                      {item.message}
                    </p>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      </motion.div>
    </div>
  );
};

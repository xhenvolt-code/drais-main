'use client';
import React from 'react';

interface ShareModalProps {
  isOpen: boolean;
  onClose: () => void;
  timetableId: string;
}

export default function ShareModal({ isOpen, onClose, timetableId }: ShareModalProps) {
  if (!isOpen) return null;

  const shareUrl = `${window.location.origin}/timetable/${timetableId}`;

  const copyToClipboard = () => {
    navigator.clipboard.writeText(shareUrl);
    alert('Link copied to clipboard!');
  };

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div className="bg-white dark:bg-gray-800 rounded-lg p-6 max-w-md w-full">
        <h2 className="text-xl font-bold mb-4">Share Timetable</h2>
        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium mb-1">Share Link</label>
            <div className="flex gap-2">
              <input
                type="text"
                value={shareUrl}
                readOnly
                className="flex-1 px-3 py-2 border rounded-lg bg-gray-50"
              />
              <button
                onClick={copyToClipboard}
                className="px-4 py-2 bg-blue-600 text-white rounded-lg"
              >
                Copy
              </button>
            </div>
          </div>
          <button
            onClick={onClose}
            className="w-full px-4 py-2 border rounded-lg"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  );
}

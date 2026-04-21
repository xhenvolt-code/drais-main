"use client";
import React from 'react';
import { Dialog, Transition } from '@headlessui/react';
import { X } from 'lucide-react';

interface EnhancedModalProps {
  isOpen: boolean;
  onClose: () => void;
  title: string;
  children: React.ReactNode;
  maxWidth?: 'sm' | 'md' | 'lg' | 'xl' | '2xl';
  showCloseButton?: boolean;
}

export const EnhancedModal: React.FC<EnhancedModalProps> = ({
  isOpen,
  onClose,
  title,
  children,
  maxWidth = 'md',
  showCloseButton = true
}) => {
  const maxWidthClasses = {
    sm: 'max-w-sm',
    md: 'max-w-md',
    lg: 'max-w-lg',
    xl: 'max-w-xl',
    '2xl': 'max-w-2xl'
  };

  return (
    <Transition appear show={isOpen} as={React.Fragment}>
      <Dialog as="div" className="relative z-[9999]" onClose={onClose}>
        <Transition.Child
          as={React.Fragment}
          enter="modal-overlay-enter"
          enterFrom="modal-overlay-enter-from"
          enterTo="modal-overlay-enter-to"
          leave="modal-overlay-leave"
          leaveFrom="modal-overlay-leave-from"
          leaveTo="modal-overlay-leave-to"
        >
          <div className="fixed inset-0 modal-backdrop-glass" />
        </Transition.Child>

        <div className="fixed inset-0 overflow-y-auto">
          <div className="flex items-center justify-center min-h-full p-4">
            <Transition.Child
              as={React.Fragment}
              enter="modal-enter"
              enterFrom="modal-enter-from"
              enterTo="modal-enter-to"
              leave="modal-leave"
              leaveFrom="modal-leave-from"
              leaveTo="modal-leave-to"
            >
              <Dialog.Panel className={`w-full ${maxWidthClasses[maxWidth]} modal-panel-enhanced p-8`}>
                <div className="flex items-center justify-between mb-8">
                  <Dialog.Title className="text-2xl font-bold text-gray-900 dark:text-gray-100">
                    {title}
                  </Dialog.Title>
                  {showCloseButton && (
                    <button 
                      onClick={onClose} 
                      className="modal-button-enhanced p-3"
                    >
                      <X className="w-5 h-5 text-gray-500" />
                    </button>
                  )}
                </div>
                
                <div className="modal-content-appear">
                  {children}
                </div>
              </Dialog.Panel>
            </Transition.Child>
          </div>
        </div>
      </Dialog>
    </Transition>
  );
};

export default EnhancedModal;

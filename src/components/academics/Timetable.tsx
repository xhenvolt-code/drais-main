"use client";
import React, { useState } from "react";
import { useI18n } from "@/components/i18n/I18nProvider";
import useSWR from "swr";
import { fetcher } from "@/utils/fetcher";
import { motion, AnimatePresence } from "framer-motion";
import {
  Calendar,
  Clock,
  Plus,
  Edit,
  Trash2,
  BookOpen,
  Users,
  X
} from "lucide-react";

// Simple Modal component since @/components/ui doesn't exist
interface ModalProps {
  isOpen: boolean;
  onClose: () => void;
  title: string;
  children: React.ReactNode;
}

const Modal: React.FC<ModalProps> = ({ isOpen, onClose, title, children }) => {
  if (!isOpen) return null;

  return (
    <AnimatePresence>
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center p-4 z-50"
        onClick={onClose}
      >
        <motion.div
          initial={{ scale: 0.9, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          exit={{ scale: 0.9, opacity: 0 }}
          onClick={(e) => e.stopPropagation()}
          className="bg-white dark:bg-slate-800 rounded-2xl shadow-2xl border border-white/30 dark:border-slate-700/30 w-full max-w-2xl max-h-[80vh] overflow-hidden"
        >
          <div className="p-6 border-b border-gray-200 dark:border-gray-700">
            <div className="flex items-center justify-between">
              <h3 className="text-xl font-bold text-gray-900 dark:text-white">
                {title}
              </h3>
              <button
                onClick={onClose}
                className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-200 transition-colors duration-200"
              >
                <X className="w-5 h-5" />
              </button>
            </div>
          </div>
          <div className="p-6 overflow-y-auto max-h-[60vh]">
            {children}
          </div>
        </motion.div>
      </motion.div>
    </AnimatePresence>
  );
};

// Simple Tab component
interface TabProps {
  tabs: string[];
  activeTab: number;
  onTabChange: (index: number) => void;
}

const Tab: React.FC<TabProps> = ({ tabs, activeTab, onTabChange }) => {
  return (
    <div className="flex space-x-1 bg-gray-100 dark:bg-gray-800 rounded-xl p-1">
      {tabs.map((tab, index) => (
        <button
          key={tab}
          onClick={() => onTabChange(index)}
          className={`
            px-4 py-2 rounded-lg font-medium text-sm transition-all duration-200
            ${activeTab === index
              ? 'bg-white dark:bg-gray-700 text-blue-600 dark:text-blue-400 shadow-sm'
              : 'text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-200'
            }
          `}
        >
          {tab}
        </button>
      ))}
    </div>
  );
}

const API_BASE = "/api";

export const Timetable: React.FC = () => {
  const { t } = useI18n();
  const [modalOpen, setModalOpen] = useState(false);
  const [selectedDay, setSelectedDay] = useState<number | null>(null);
  const { data: timetableData, mutate } = useSWR(`${API_BASE}/timetable`, fetcher);

  const handleAddSchedule = () => {
    setModalOpen(true);
  };

  const handleSaveSchedule = async (schedule: any) => {
    try {
      const response = await fetch(`${API_BASE}/timetable`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(schedule),
      });
      if (response.ok) {
        mutate();
        setModalOpen(false);
      } else {
        console.error("Failed to save schedule");
      }
    } catch (error) {
      console.error("Error saving schedule:", error);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex justify-between items-center">
        <h1 className="text-xl font-bold">{t("timetable", "Timetable")}</h1>
        <button
          onClick={handleAddSchedule}
          className="px-4 py-2 bg-blue-500 text-white rounded-lg"
        >
          {t("add_schedule", "Add Schedule")}
        </button>
      </div>
      <Tab tabs={["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]} activeTab={0} onTabChange={() => {}}>
        {["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"].map((day, index) => (
          <Tab.Panel key={index} title={t(day.toLowerCase(), day)}>
            <div>
              {timetableData?.[day.toLowerCase()]?.map((schedule: any) => (
                <div key={schedule.id} className="p-2 border-b">
                  {schedule.subject} - {schedule.start_time} to {schedule.end_time}
                </div>
              ))}
            </div>
          </Tab.Panel>
        ))}
      </Tab>
      {modalOpen && (
        <Modal isOpen={modalOpen} onClose={() => setModalOpen(false)} title={t("add_schedule", "Add Schedule")}>
          <div>
            {/* Form for adding schedule */}
            <button onClick={() => handleSaveSchedule({ day: selectedDay })}>
              {t("save", "Save")}
            </button>
          </div>
        </Modal>
      )}
    </div>
  );
};

export default Timetable;

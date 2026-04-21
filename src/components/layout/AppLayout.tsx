"use client";
import React, { useState, useEffect } from 'react';
import { usePathname } from 'next/navigation';
import { Navbar } from './Navbar';
import {Sidebar} from './Sidebar'; // Changed from { Sidebar } to default import
import { useTheme } from '@/components/theme/ThemeProvider';
import { useThemeStore } from '@/hooks/useThemeStore';
import { useI18n } from '@/components/i18n/I18nProvider';
import clsx from 'clsx';

interface AppLayoutProps {
  children: React.ReactNode;
}

export const AppLayout: React.FC<AppLayoutProps> = ({ children }) => {
  const pathname = usePathname();
  const theme = useTheme();
  const store = useThemeStore();
  const { dir } = useI18n();
  const [sidebarOpen, setSidebarOpen] = useState(false);

  const isAuthPage = pathname?.startsWith('/login') || pathname?.startsWith('/register');
  const isRTL = dir === 'rtl';
  const collapsed = theme.sidebarCollapsed;
  const sidebarPosition = store.sidebarPosition || 'left';

  // Close sidebar on route change (mobile)
  useEffect(() => {
    setSidebarOpen(false);
  }, [pathname]);

  // Handle sidebar position and collapsed state for content margin
  const getContentMargin = () => {
    if (isAuthPage) return '0';
    
    const sidebarWidth = collapsed ? '4rem' : '16rem';
    
    if (sidebarPosition === 'right') {
      return isRTL ? `0 0 0 ${sidebarWidth}` : `0 ${sidebarWidth} 0 0`;
    } else {
      return isRTL ? `0 ${sidebarWidth} 0 0` : `0 0 0 ${sidebarWidth}`;
    }
  };

  if (isAuthPage) {
    return <>{children}</>;
  }

  return (
    <div className="flex h-screen overflow-hidden bg-gray-50 dark:bg-gray-900">
      {/* Sidebar */}
      <Sidebar 
        open={sidebarOpen} 
        onClose={() => setSidebarOpen(false)} 
      />

      {/* Main Content Area */}
      <div className="flex-1 flex flex-col overflow-hidden">
        {/* Navbar */}
        <Navbar onToggleSidebar={() => setSidebarOpen(!sidebarOpen)} />

        {/* Page Content */}
        <main 
          className={clsx(
            "flex-1 overflow-x-hidden overflow-y-auto transition-all duration-300 custom-scroll",
            "lg:ml-0" // Reset default margin on large screens
          )}
          style={{
            marginTop: '4rem', // Account for fixed navbar
            margin: `4rem 0 0 ${getContentMargin()}`,
            minHeight: 'calc(100vh - 4rem)'
          }}
        >
          <div className={clsx(
            "container mx-auto p-4 sm:p-6 lg:p-8",
            store.layoutWidth === 'boxed' && 'max-w-7xl',
            store.layoutWidth === 'wide' && 'max-w-[1800px]'
          )}>
            {children}
          </div>
        </main>
      </div>
    </div>
  );
};

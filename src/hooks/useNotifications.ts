import { useState, useEffect, useCallback } from 'react';
import { useSocket } from '@/hooks/useSocket';
import useSWR from 'swr';
import { fetcher } from '@/utils/fetcher';

interface Notification {
  id: number;
  title: string;
  message: string;
  priority: 'low' | 'normal' | 'high' | 'critical';
  created_at: string;
  is_read: boolean;
  metadata?: any;
  entity_type?: string;
  entity_id?: number;
}

interface UseNotificationsOptions {
  userId: number;
  schoolId?: number;
  autoRefresh?: boolean;
  refreshInterval?: number;
}

interface UseNotificationsReturn {
  notifications: Notification[];
  unreadCount: number;
  isLoading: boolean;
  error: any;
  markAsRead: (ids: number[]) => Promise<void>;
  markAllAsRead: () => Promise<void>;
  archiveNotifications: (ids: number[]) => Promise<void>;
  refresh: () => void;
}

export const useNotifications = (options: UseNotificationsOptions): UseNotificationsReturn => {
  // Provide default values to prevent destructuring errors
  const {
    userId = 1,
    schoolId,
    autoRefresh = true,
    refreshInterval = 30000
  } = options || {};

  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [unreadCount, setUnreadCount] = useState(0);
  const socket = useSocket();

  // Fetch unread count
  const { data: unreadData, mutate: mutateUnread } = useSWR(
    userId ? `/api/notifications/unread-count?user_id=${userId}${schoolId ? `&school_id=${schoolId}` : ''}` : null,
    fetcher,
    { 
      refreshInterval: autoRefresh ? refreshInterval : 0,
      revalidateOnFocus: true,
      onError: (error) => {
        console.error('Error fetching unread count:', error);
      }
    }
  );

  // Fetch notifications list
  const { data: notificationsData, error, isLoading, mutate: mutateNotifications } = useSWR(
    userId ? `/api/notifications/list?user_id=${userId}&filter=all&limit=50${schoolId ? `&school_id=${schoolId}` : ''}` : null,
    fetcher,
    { 
      refreshInterval: autoRefresh ? refreshInterval : 0,
      revalidateOnFocus: true,
      onError: (error) => {
        console.error('Error fetching notifications:', error);
      }
    }
  );

  // Update local state when data changes
  useEffect(() => {
    if (unreadData?.unread !== undefined) {
      setUnreadCount(unreadData.unread);
    }
  }, [unreadData]);

  useEffect(() => {
    if (notificationsData?.notifications) {
      setNotifications(notificationsData.notifications);
    }
  }, [notificationsData]);

  // Listen for real-time notifications (only if socket is available)
  useEffect(() => {
    if (!socket || !autoRefresh || !userId) return;

    const handleNewNotification = (data: any) => {
      // Add new notification to the beginning of the list
      setNotifications(prev => [data, ...prev]);
      setUnreadCount(prev => prev + 1);
      
      // Show browser notification if permission granted
      if (typeof window !== 'undefined' && 'Notification' in window && Notification.permission === 'granted') {
        new Notification(data.title, {
          body: data.message,
          icon: '/favicon.ico',
          tag: `notification-${data.id}`
        });
      }
    };

    const handleNotificationUpdate = (data: any) => {
      if (data.action === 'marked_read') {
        // Update notifications read status
        setNotifications(prev => 
          prev.map(notif => 
            data.ids.includes(notif.id) 
              ? { ...notif, is_read: true }
              : notif
          )
        );
        setUnreadCount(prev => Math.max(0, prev - data.ids.length));
      } else if (data.action === 'archived') {
        // Remove archived notifications from list
        setNotifications(prev => 
          prev.filter(notif => !data.ids.includes(notif.id))
        );
        // Update unread count for any unread items being archived
        const archivedUnreadCount = notifications.filter(n => 
          data.ids.includes(n.id) && !n.is_read
        ).length;
        setUnreadCount(prev => Math.max(0, prev - archivedUnreadCount));
      }
    };

    socket.on('notification:new', handleNewNotification);
    socket.on('notification:updated', handleNotificationUpdate);

    return () => {
      socket.off('notification:new', handleNewNotification);
      socket.off('notification:updated', handleNotificationUpdate);
    };
  }, [socket, autoRefresh, notifications, userId]);

  // Request notification permission on mount
  useEffect(() => {
    if (typeof window !== 'undefined' && 'Notification' in window && Notification.permission === 'default') {
      Notification.requestPermission();
    }
  }, []);

  // Mark notifications as read
  const markAsRead = useCallback(async (ids: number[]) => {
    if (!userId || ids.length === 0) return;

    try {
      const response = await fetch('/api/notifications/mark-read', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ids, user_id: userId })
      });

      if (response.ok) {
        // Update local state
        setNotifications(prev => 
          prev.map(notif => 
            ids.includes(notif.id) 
              ? { ...notif, is_read: true }
              : notif
          )
        );
        
        // Update unread count
        const unreadMarkings = ids.filter(id => {
          const notif = notifications.find(n => n.id === id);
          return notif && !notif.is_read;
        }).length;
        
        setUnreadCount(prev => Math.max(0, prev - unreadMarkings));
        
        // Refresh data from server
        mutateUnread();
        mutateNotifications();
      } else {
        throw new Error('Failed to mark as read');
      }
    } catch (error) {
      console.error('Error marking notifications as read:', error);
      throw error;
    }
  }, [userId, notifications, mutateUnread, mutateNotifications]);

  // Mark all notifications as read
  const markAllAsRead = useCallback(async () => {
    const unreadIds = notifications.filter(n => !n.is_read).map(n => n.id);
    if (unreadIds.length > 0) {
      await markAsRead(unreadIds);
    }
  }, [notifications, markAsRead]);

  // Archive notifications
  const archiveNotifications = useCallback(async (ids: number[]) => {
    if (!userId || ids.length === 0) return;

    try {
      const response = await fetch('/api/notifications/archive', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ids, user_id: userId })
      });

      if (response.ok) {
        // Remove from local state
        setNotifications(prev => 
          prev.filter(notif => !ids.includes(notif.id))
        );
        
        // Update unread count for any unread items being archived
        const archivedUnreadCount = notifications.filter(n => 
          ids.includes(n.id) && !n.is_read
        ).length;
        
        setUnreadCount(prev => Math.max(0, prev - archivedUnreadCount));
        
        // Refresh data from server
        mutateUnread();
        mutateNotifications();
      } else {
        throw new Error('Failed to archive notifications');
      }
    } catch (error) {
      console.error('Error archiving notifications:', error);
      throw error;
    }
  }, [userId, notifications, mutateUnread, mutateNotifications]);

  // Refresh data
  const refresh = useCallback(() => {
    mutateUnread();
    mutateNotifications();
  }, [mutateUnread, mutateNotifications]);

  return {
    notifications,
    unreadCount,
    isLoading,
    error,
    markAsRead,
    markAllAsRead,
    archiveNotifications,
    refresh
  };
};

export default useNotifications;

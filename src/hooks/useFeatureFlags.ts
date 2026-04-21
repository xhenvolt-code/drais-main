import { useState, useEffect } from 'react';
import useSWR from 'swr';
import { fetcher } from '@/utils/fetcher';

interface FeatureFlag {
  id: number;
  route_name: string;
  route_path: string;
  label: string;
  description?: string;
  is_new: boolean;
  is_enabled: boolean;
  version_tag: string;
  category: string;
  priority: number;
  date_added: string;
  expires_at?: string;
}

interface UseFeatureFlagsOptions {
  schoolId?: number;
  category?: string;
  autoRefresh?: boolean;
}

export const useFeatureFlags = (options: UseFeatureFlagsOptions = {}) => {
  const { schoolId, category, autoRefresh = true } = options;
  
  const queryParams = new URLSearchParams();
  if (schoolId) queryParams.set('school_id', schoolId.toString());
  if (category) queryParams.set('category', category);

  const { data, error, isLoading, mutate } = useSWR(
    `/api/feature-flags?${queryParams.toString()}`,
    fetcher,
    {
      refreshInterval: autoRefresh ? 60000 : 0, // Refresh every minute
      revalidateOnFocus: true,
      dedupingInterval: 30000 // Dedupe for 30 seconds
    }
  );

  const featureFlags: FeatureFlag[] = data?.data || [];

  // Helper function to check if a route is new
  const isRouteNew = (routePath: string): boolean => {
    return featureFlags.some(flag => 
      flag.route_path === routePath && flag.is_new && flag.is_enabled
    );
  };

  // Helper function to get feature flag by route
  const getFeatureFlag = (routePath: string): FeatureFlag | undefined => {
    return featureFlags.find(flag => 
      flag.route_path === routePath && flag.is_enabled
    );
  };

  // Helper function to record interaction
  const recordInteraction = async (routePath: string, interactionType: 'viewed' | 'clicked' | 'dismissed') => {
    const flag = getFeatureFlag(routePath);
    if (!flag) return;

    try {
      await fetch('/api/feature-flags/interact', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          user_id: 1, // TODO: Get from session
          feature_flag_id: flag.id,
          interaction_type: interactionType
        })
      });
    } catch (error) {
      console.error('Failed to record feature interaction:', error);
    }
  };

  // Get new features by category
  const getNewFeaturesByCategory = () => {
    const categorizedFlags = featureFlags
      .filter(flag => flag.is_new && flag.is_enabled)
      .reduce((acc, flag) => {
        if (!acc[flag.category]) acc[flag.category] = [];
        acc[flag.category].push(flag);
        return acc;
      }, {} as Record<string, FeatureFlag[]>);

    // Sort each category by priority
    Object.keys(categorizedFlags).forEach(cat => {
      categorizedFlags[cat].sort((a, b) => b.priority - a.priority);
    });

    return categorizedFlags;
  };

  return {
    featureFlags,
    isLoading,
    error,
    isRouteNew,
    getFeatureFlag,
    recordInteraction,
    getNewFeaturesByCategory,
    refresh: mutate
  };
};

export default useFeatureFlags;

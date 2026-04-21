"use client";
import React, { useEffect, useState } from 'react';
import StreamsManager from '@/components/academics/StreamsManager';

export default function StreamsPage() {
  return (
    <div className="p-4 md:p-8">
      <StreamsManager />
    </div>
  );
}
"use client";
import React, { useState } from 'react';
import { PayrollDefinitions } from './PayrollDefinitions';
import { StaffSalaryManager } from './StaffSalaryManager';
import { SalaryPaymentsManager } from './SalaryPaymentsManager';
import { t } from '@/lib/i18n';

export default function PayrollDashboard(){
  const [staffId,setStaffId]=useState('');
  return (
    <div className="space-y-8">
      <h1 className="text-xl font-semibold">{t('payroll.title','Payroll')}</h1>
      <PayrollDefinitions />
      <div className="p-5 rounded-xl border bg-white/60 dark:bg-slate-900/60 backdrop-blur border-white/30 dark:border-white/10 space-y-4">
        <h2 className="font-semibold text-sm">{t('payroll.staff_payroll','Staff Payroll')}</h2>
        <input value={staffId} onChange={e=>setStaffId(e.target.value)} placeholder={t('payroll.staff_id','Staff ID')} className="px-3 py-2 rounded border text-sm" />
        {staffId ? (
          <div className="grid md:grid-cols-2 gap-6">
            <StaffSalaryManager staffId={parseInt(staffId,10)} />
            <SalaryPaymentsManager staffId={parseInt(staffId,10)} />
          </div>
        ) : <div className="text-xs text-gray-500">{t('payroll.enter_staff_id','Enter a staff ID')}</div>}
      </div>
    </div>
  );
}
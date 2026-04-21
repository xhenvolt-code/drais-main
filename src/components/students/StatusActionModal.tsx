import React from 'react';
import { Dialog, Transition } from '@headlessui/react';
import { X, Download, Printer, Mail, MessageCircle } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

interface StudentBrief {
  id: number;
  first_name?: string;
  last_name?: string;
  admission_no?: string;
  class_name?: string;
  photo_url?: string;
}

interface Props {
  open: boolean;
  onClose: () => void;
  student: StudentBrief | null;
  action: 'suspend' | 'expel' | null;
  onCompleted?: (res: any) => void;
}

const API_BASE = '/api';

const formatDate = (d?: string) => {
  if (!d) return '';
  const dt = new Date(d);
  return dt.toLocaleDateString();
};

const letterTemplate = (opts: {
  schoolName: string;
  schoolAddress?: string;
  logoUrl?: string;
  dateStr: string;
  studentName: string;
  admissionNo?: string;
  className?: string;
  bodyHtml: string;
  signatureName?: string;
}) => {
  return `<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<title>Letter</title>
<style>
  body { font-family: Arial, Helvetica, sans-serif; color:#111; padding:40px; }
  .header { display:flex; align-items:center; gap:16px; margin-bottom:24px;}
  .logo { width:72px; height:72px; object-fit:contain; }
  .school { font-size:18px; font-weight:700; }
  .address { font-size:12px; color:#555; }
  .date { text-align:right; margin-top:8px; font-size:13px; color:#333 }
  .content { margin-top:24px; font-size:15px; line-height:1.6; }
  .center { text-align:center; }
  .signature { margin-top:40px; }
  .signature-line { margin-top:40px; border-top:1px solid #999; width:220px; text-align:center; padding-top:8px; color:#444; }
</style>
</head>
<body>
  <div class="header">
    ${opts.logoUrl ? `<img src="${opts.logoUrl}" class="logo" alt="logo" />` : ''}
    <div>
      <div class="school">${opts.schoolName}</div>
      <div class="address">${opts.schoolAddress || ''}</div>
    </div>
    <div style="flex:1"></div>
    <div class="date">${opts.dateStr}</div>
  </div>

  <div class="content">
    <p>To: <strong>${opts.studentName}</strong> ${opts.admissionNo ? ` (Admission No: ${opts.admissionNo})` : ''}</p>
    ${opts.className ? `<p>Class: ${opts.className}</p>` : ''}
    <div style="margin-top:20px">${opts.bodyHtml}</div>
    <div class="signature">
      <div class="signature-line">${opts.signatureName || 'Headteacher'}</div>
    </div>
  </div>
</body>
</html>`;
};

export function StatusActionModal({ open, onClose, student, action, onCompleted }: Props) {
   const [suspendFrom, setSuspendFrom] = React.useState<string>('');
   const [returnDate, setReturnDate] = React.useState<string>('');
   const [suspendReason, setSuspendReason] = React.useState<string>('');
   const [effectiveDate, setEffectiveDate] = React.useState<string>('');
   const [expelReason, setExpelReason] = React.useState<string>('');
   const [permanent, setPermanent] = React.useState<boolean>(false);
   const [previewHtml, setPreviewHtml] = React.useState<string>('');
   const [loading, setLoading] = React.useState(false);
   const [letterUrl, setLetterUrl] = React.useState<string | null>(null);
   const [schoolConfig, setSchoolConfig] = React.useState<any>({
     name: 'School Name',
     address: 'School Address Line 1 • Phone: 000-000-000',
     logo: '/uploads/logo.png',
     principal: 'Principal / Headteacher'
   });
 
   // Fetch school configuration on mount
   React.useEffect(() => {
     const fetchSchoolConfig = async () => {
       try {
         const response = await fetch('/api/school-config');
         if (response.ok) {
           const data = await response.json();
           const school = data.school || data.data;
           if (school) {
             setSchoolConfig({
               name: school.name || school.school_name || 'School Name',
               address: `${school.address || 'School Address'} • Phone: ${school.contact?.phone || '000-000-000'}`,
               logo: school.branding?.logo || '/uploads/logo.png',
               principal: school.principal?.name || school.principal?.title || 'Principal / Headteacher'
             });
           }
         }
       } catch (err) {
         console.warn('Could not fetch school config:', err);
       }
     };
     
     if (open) {
       fetchSchoolConfig();
     }
   }, [open]);
 
   React.useEffect(() => {
     // reset when opening
     if (open) {
       setSuspendFrom('');
       setReturnDate('');
       setSuspendReason('');
       setEffectiveDate('');
       setExpelReason('');
       setPermanent(false);
       setPreviewHtml('');
       setLetterUrl(null);
     }
   }, [open, action, student]);
 
   if (!open || !student || !action) return null;
 
   const buildPreview = () => {
     const dateStr = new Date().toLocaleDateString();
     let body = '';
     if (action === 'suspend') {
       body = `<h2 class="center">Notice of Suspension</h2>
 <p>Dear Parent/Guardian,</p>
 <p>This is to inform you that <strong>${student.first_name} ${student.last_name}</strong> (Admission No: ${student.admission_no || '—'}) has been suspended effective <strong>${formatDate(suspendFrom)}</strong> and is expected to return on <strong>${formatDate(returnDate)}</strong>.</p>
 <p><strong>Reason:</strong> ${suspendReason || 'Not specified'}</p>
 <p>Please ensure the learner observes the suspension conditions and returns on the stipulated date.</p>`;
     } else {
       body = `<h2 class="center">Notice of Expulsion</h2>
 <p>Dear Parent/Guardian,</p>
 <p>This is to inform you that <strong>${student.first_name} ${student.last_name}</strong> (Admission No: ${student.admission_no || '—'}) has been expelled effective <strong>${formatDate(effectiveDate)}</strong>.</p>
 <p><strong>Reason:</strong> ${expelReason || 'Not specified'}</p>
 <p>${permanent ? '<strong>This expulsion is permanent; the learner is barred from returning.</strong>' : ''}</p>`;
     }
 
     // Fetch school info from centralized configuration
     const html = letterTemplate({
       schoolName: schoolConfig.name,
       schoolAddress: schoolConfig.address,
       logoUrl: schoolConfig.logo,
       dateStr,
       studentName: `${student.first_name} ${student.last_name}`,
       admissionNo: student.admission_no,
       className: student.class_name,
       bodyHtml: body,
       signatureName: schoolConfig.principal
     });
     setPreviewHtml(html);
   };
 
   const submitAction = async () => {
     setLoading(true);
     try {
       const payload: any = {
         student_id: student.id,
         action: action === 'suspend' ? 'suspended' : 'expelled',
         details: {}
       };
       if (action === 'suspend') {
         payload.details = {
           start_date: suspendFrom || null,
           return_date: returnDate || null,
           reason: suspendReason || null,
           permanent: false
         };
       } else {
         payload.details = {
           effective_date: effectiveDate || null,
           reason: expelReason || null,
           permanent: permanent ? 1 : 0
         };
       }
 
       const res = await fetch(`${API_BASE}/students/status-action`, {
         method: 'POST',
         headers: { 'Content-Type': 'application/json' },
         body: JSON.stringify(payload)
       });
       const data = await res.json();
       if (res.ok && data.success) {
         setLetterUrl(data.letterUrl || null);
         if (onCompleted) onCompleted({ success: true, letterUrl: data.letterUrl, data });
       } else {
         if (onCompleted) onCompleted({ success: false, error: data.error || 'Failed' });
       }
     } catch (err: any) {
       if (onCompleted) onCompleted({ success: false, error: err.message });
     } finally {
       setLoading(false);
     }
   };
 
   const openPreviewWindow = () => {
     if (!previewHtml && !letterUrl) buildPreview();
     const url = letterUrl || null;
     if (url) {
       window.open(url, '_blank');
       return;
     }
     const w = window.open('', '_blank');
     if (w) {
       w.document.open();
       w.document.write(previewHtml);
       w.document.close();
     }
   };
 
   const downloadLetter = async () => {
    // Prefer server-stored letter URL; fetch blob and force download with proper extension
    if (letterUrl) {
      try {
        const resp = await fetch(letterUrl);
        if (!resp.ok) {
          // fallback: open in new tab
          window.open(letterUrl, '_blank');
          return;
        }
        const blob = await resp.blob();
        const ct = resp.headers.get('content-type') || blob.type || '';
        let ext = 'html';
        if (ct.includes('pdf')) ext = 'pdf';
        else if (ct.includes('html')) ext = 'html';
        const filename = `letter_${student.id}.${ext}`;
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        a.remove();
        URL.revokeObjectURL(url);
        return;
      } catch (err) {
        // fallback to opening url
        window.open(letterUrl, '_blank');
        return;
      }
    }
    // If no server file, download preview HTML
    if (previewHtml) {
      const blob = new Blob([previewHtml], { type: 'text/html' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `letter_${student.id}.html`;
      document.body.appendChild(a);
      a.click();
      a.remove();
      URL.revokeObjectURL(url);
    } else {
      // create preview then download
      buildPreview();
      setTimeout(() => downloadLetter(), 300);
    }
  };
 
   const sendWhatsApp = () => {
     const target = letterUrl || null;
     if (navigator.share && target) {
       navigator.share({ title: `Official letter - ${student.first_name} ${student.last_name}`, url: target }).catch(() => {});
       return;
     }
     const text = encodeURIComponent(`Please see the official letter for ${student.first_name} ${student.last_name}: ${target || ''}`);
     window.open(`https://wa.me/?text=${text}`, '_blank');
   };
 
   const sendEmail = () => {
     const subject = encodeURIComponent(`Official letter - ${student.first_name} ${student.last_name}`);
     const body = encodeURIComponent(`Please find the official letter here: ${letterUrl || ''}`);
     window.location.href = `mailto:?subject=${subject}&body=${body}`;
   };
 
   return (
     <Transition show={open} as={React.Fragment}>
       <Dialog as="div" className="relative z-50" onClose={onClose}>
         <div className="fixed inset-0 bg-black/40" aria-hidden />
         <div className="fixed inset-0 overflow-y-auto p-4">
           <div className="mx-auto max-w-3xl">
             <Dialog.Panel className="bg-white dark:bg-slate-800 rounded-2xl shadow-xl p-6 max-h-[90vh] overflow-auto">
               <div className="flex items-start justify-between">
                 <h3 className="text-lg font-semibold">
                   {action === 'suspend' ? 'Suspend Learner' : 'Expel Learner'}
                 </h3>
                 <button onClick={onClose} className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-slate-700">
                   <X className="w-5 h-5" />
                 </button>
               </div>
 
               <div className="mt-4 space-y-4">
                 <div className="text-sm text-gray-700 dark:text-gray-200">
                   <strong>{student.first_name} {student.last_name}</strong> — {student.admission_no || '—'} • {student.class_name || '—'}
                 </div>
 
                 {action === 'suspend' && (
                   <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                     <div>
                       <label className="text-xs text-gray-500">Start Date</label>
                       <input type="date" className="input-field" value={suspendFrom} onChange={e => setSuspendFrom(e.target.value)} />
                     </div>
                     <div>
                       <label className="text-xs text-gray-500">Return Date</label>
                       <input type="date" className="input-field" value={returnDate} onChange={e => setReturnDate(e.target.value)} />
                     </div>
                     <div>
                       <label className="text-xs text-gray-500">Reason</label>
                       <input className="input-field" value={suspendReason} onChange={e => setSuspendReason(e.target.value)} />
                     </div>
                   </div>
                 )}
 
                 {action === 'expel' && (
                   <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                     <div>
                       <label className="text-xs text-gray-500">Effective Date</label>
                       <input type="date" className="input-field" value={effectiveDate} onChange={e => setEffectiveDate(e.target.value)} />
                     </div>
                     <div>
                       <label className="text-xs text-gray-500">Permanent?</label>
                       <div className="mt-1">
                         <label className="inline-flex items-center gap-2">
                           <input type="checkbox" checked={permanent} onChange={(e) => setPermanent(e.target.checked)} />
                           <span className="text-sm">Permanently barred</span>
                         </label>
                       </div>
                     </div>
                     <div>
                       <label className="text-xs text-gray-500">Reason</label>
                       <input className="input-field" value={expelReason} onChange={e => setExpelReason(e.target.value)} />
                     </div>
                   </div>
                 )}
 
                 <div className="flex items-center gap-3">
                   <button onClick={() => { buildPreview(); }} className="btn-secondary">Preview</button>
                   <button
                     onClick={async () => {
                       await buildPreview();
                       await submitAction();
                     }}
                     className="btn-primary"
                     disabled={loading}
                   >
                     {loading ? 'Processing...' : 'Generate & Save Letter'}
                   </button>
                   <>
                     <button onClick={openPreviewWindow} className="btn-secondary"><Printer className="w-4 h-4" /> Preview / Print</button>
                     <button onClick={downloadLetter} className="btn-secondary"><Download className="w-4 h-4" /> Download</button>
                     <button onClick={sendWhatsApp} className="btn-secondary"><MessageCircle className="w-4 h-4" /> WhatsApp</button>
                     <button onClick={sendEmail} className="btn-secondary"><Mail className="w-4 h-4" /> Email</button>
                     {navigator.share && (
                       <button onClick={() => {
                         const shareUrl = letterUrl || '';
                         navigator.share({ title: `Official letter - ${student.first_name} ${student.last_name}`, url: shareUrl }).catch(()=>{});
                       }} className="btn-secondary">Share</button>
                     )}
                   </>
                 </div>
 
                 <div className="mt-4">
                   <h4 className="text-sm font-semibold mb-2">Letter Preview</h4>
                   <div className="border rounded p-3 bg-white dark:bg-slate-900" style={{ minHeight: 160 }}>
                     <div dangerouslySetInnerHTML={{ __html: previewHtml || (letterUrl ? `<a href="${letterUrl}" target="_blank">Open generated letter</a>` : '<em>No preview. Click Preview.</em>') }} />
                   </div>
                 </div>
               </div>
             </Dialog.Panel>
           </div>
         </div>
       </Dialog>
     </Transition>
   );
 }
 
 // keep default export for compatibility with other imports
 export default StatusActionModal;

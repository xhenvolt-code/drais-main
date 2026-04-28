import { SubjectAllocationsManager } from '@/components/academics/SubjectAllocationsManager';

export default function SubjectAllocationsPage() {
  return (
    <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">Teacher Subject Allocation</h1>
          <p className="text-sm text-gray-600 dark:text-gray-400">
            Assign teachers to subjects per class. This is the source of truth for report card initials.
          </p>
        </div>
      </div>
      <SubjectAllocationsManager />
    </div>
  );
}

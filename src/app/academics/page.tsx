import { ClassesManager } from '@/components/academics/ClassesManager';
import { SubjectsManager } from '@/components/academics/SubjectsManager';
import { ClassSubjectsManager } from '@/components/academics/ClassSubjectsManager';
import { ExamsManager } from '@/components/academics/ExamsManager';
import { ResultsManager } from '@/components/academics/ResultsManager';

export default function AcademicsPage(){
  return (
    <div className="p-6 space-y-10">
      <div className="grid lg:grid-cols-2 gap-10">
        <ClassesManager />
        <SubjectsManager />
      </div>
      <ClassSubjectsManager />
      <div className="grid lg:grid-cols-2 gap-10">
        <ExamsManager />
        <ResultsManager />
      </div>
    </div>
  );
}
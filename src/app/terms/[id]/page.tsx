import TermDetail from '@/components/terms/TermDetail';
import { notFound } from 'next/navigation';

export default function TermDetailPage({ params }: { params:{ id:string } }) {
  const { id } = params;
  if(!/^\d+$/.test(id)) return notFound();
  return (
    <div className="p-6">
      <TermDetail id={id} />
    </div>
  );
}
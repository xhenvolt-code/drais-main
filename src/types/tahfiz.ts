export type TahfizPlanType = 'tilawa' | 'hifz' | 'muraja' | 'other';
export type TahfizRecordStatus = 'presented' | 'absent' | 'excused' | 'pending';

export interface TahfizPlan {
  id?: number;
  school_id: number;
  teacher_id: number;
  class_id?: number;
  stream_id?: number;
  assigned_date: string;
  portion_text: string;
  portion_unit?: string;
  expected_length?: number;
  type: TahfizPlanType;
  notes?: string;
}

export interface TahfizRecord {
  id?: number;
  school_id: number;
  plan_id: number;
  student_id: number;
  presented: boolean;
  presented_length: number;
  retention_score?: number;
  mark?: number;
  status: TahfizRecordStatus;
  notes?: string;
  recorded_by?: number;
}

'use client';
import React, { useEffect, useState } from 'react';

const LearnersReport: React.FC = () => {
  const [data, setData] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchReports = async () => {
      try {
        const res = await fetch('/api/reports/learners');
        if (!res.ok) {
          throw new Error('Failed to fetch reports');
        }
        const result = await res.json();
        setData(result);
      } catch (err: any) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchReports();
  }, []);

  if (loading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>Error: {error}</div>;
  }

  if (!data) {
    return <div>No data available</div>;
  }

  const { labels, learners, schoolInfo } = data;

  return (
    <div className="container mt-4">
      <h1 className="text-center mb-4">{schoolInfo.name}</h1>
      <p className="text-center">{schoolInfo.address}</p>
      <div className="table-responsive">
        <table className="table table-bordered">
          <thead>
            <tr>
              <th>{labels.name}</th>
              <th>{labels.age}</th>
              <th>{labels.email}</th>
              <th>{labels.phone}</th>
              <th>{labels.status}</th>
              <th>{labels.branch}</th>
              <th>{labels.grades}</th>
              <th>{labels.comments}</th>
            </tr>
          </thead>
          <tbody>
            {learners.map((learner: any) => (
              <tr key={learner.id}>
                <td>{learner.name}</td>
                <td>{learner.age}</td>
                <td>{learner.email}</td>
                <td>{learner.phone}</td>
                <td>{learner.status}</td>
                <td>{learner.branch_name || ''}</td>
                <td>
                  <ul>
                    {learner.grades.map((grade: any, index: number) => (
                      <li key={index}>
                        {labels.subject}: {grade.subject}, {labels.score}: {grade.score}
                      </li>
                    ))}
                  </ul>
                </td>
                <td>{learner.comments || 'N/A'}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default LearnersReport;
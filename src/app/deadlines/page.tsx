"use client";
import { useState, useEffect } from "react";

export default function DeadlinesPage() {
  const [deadlines, setDeadlines] = useState([]);

  useEffect(() => {
    fetch("/api/deadlines")
      .then((res) => res.json())
      .then((data) => setDeadlines(data.data || [])) // Ensure `data.data` is used
      .catch((error) => {
        console.error("Error fetching deadlines:", error);
        setDeadlines([]); // Fallback to an empty array on error
      });
  }, []);

  return (
    <div>
      <h1>Result Submission Deadlines</h1>
      <ul>
        {deadlines.map((deadline) => (
          <li key={deadline.id}>
            Exam ID: {deadline.exam_id}, Deadline: {new Date(deadline.deadline_date).toLocaleString()}
          </li>
        ))}
      </ul>
    </div>
  );
}

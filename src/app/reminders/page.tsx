"use client";
import { useState, useEffect } from "react";

export default function RemindersPage() {
  const [reminders, setReminders] = useState([]);

  useEffect(() => {
    fetch("/api/reminders")
      .then((res) => res.json())
      .then(setReminders);
  }, []);

  return (
    <div>
      <h1>Reminders</h1>
      <ul>
        {reminders.map((reminder) => (
          <li key={reminder.id}>
            {reminder.title} - {reminder.dueDate}
          </li>
        ))}
      </ul>
    </div>
  );
}

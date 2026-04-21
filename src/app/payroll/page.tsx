'use client';
import React, { useState, useEffect } from 'react';

const API_PAYROLL_DEFINITIONS = '/api/payroll_definitions';

interface PayrollDefinition {
  id: number;
  name: string;
  type: string;
}

export default function PayrollPage() {
  const [definitions, setDefinitions] = useState<PayrollDefinition[]>([]);
  const [modalOpen, setModalOpen] = useState(false);
  const [form, setForm] = useState<{ id: number | null; name: string; type: string }>({ id: null, name: '', type: '' });

  const loadDefinitions = async () => {
    const res = await fetch(API_PAYROLL_DEFINITIONS);
    const data = await res.json();
    setDefinitions(data);
  };

  const handleSubmit = async () => {
    const method = form.id ? 'PUT' : 'POST';
    await fetch(API_PAYROLL_DEFINITIONS, {
      method,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(form),
    });
    setModalOpen(false);
    loadDefinitions();
  };

  useEffect(() => {
    loadDefinitions();
  }, []);

  return (
    <div>
      <h1>Payroll Definitions</h1>
      <button onClick={() => setModalOpen(true)}>Add Definition</button>
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {definitions.map((def) => (
            <tr key={def.id}>
              <td>{def.name}</td>
              <td>{def.type}</td>
              <td>
                <button onClick={() => { setForm(def); setModalOpen(true); }}>Edit</button>
                <button onClick={async () => {
                  await fetch(API_PAYROLL_DEFINITIONS, {
                    method: 'DELETE',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ id: def.id }),
                  });
                  loadDefinitions();
                }}>Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      {modalOpen && (
        <div className="modal">
          <h2>{form.id ? 'Edit' : 'Add'} Definition</h2>
          <input
            placeholder="Name"
            value={form.name}
            onChange={(e) => setForm({ ...form, name: e.target.value })}
          />
          <input
            placeholder="Type"
            value={form.type}
            onChange={(e) => setForm({ ...form, type: e.target.value })}
          />
          <button onClick={handleSubmit}>Save</button>
          <button onClick={() => setModalOpen(false)}>Cancel</button>
        </div>
      )}
    </div>
  );
}
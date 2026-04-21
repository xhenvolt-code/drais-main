import React, { useState, useEffect } from 'react';

const API_STAFF_SALARIES = '/api/staff_salaries';
const API_SALARY_PAYMENTS = '/api/salary_payments';

export default function StaffSalariesPage() {
  const [salaries, setSalaries] = useState([]);
  const [payments, setPayments] = useState([]);
  const [salaryModalOpen, setSalaryModalOpen] = useState(false);
  const [paymentModalOpen, setPaymentModalOpen] = useState(false);
  const [salaryForm, setSalaryForm] = useState({ id: null, staff_id: '', month: '', period_month: '', definition_id: '', amount: '' });
  const [paymentForm, setPaymentForm] = useState({ id: null, staff_id: '', wallet_id: '', amount: '', method: '', reference: '' });

  const loadSalaries = async () => {
    const res = await fetch(API_STAFF_SALARIES);
    const data = await res.json();
    setSalaries(data);
  };

  const loadPayments = async () => {
    const res = await fetch(API_SALARY_PAYMENTS);
    const data = await res.json();
    setPayments(data);
  };

  const handleSalarySubmit = async () => {
    const method = salaryForm.id ? 'PUT' : 'POST';
    await fetch(API_STAFF_SALARIES, {
      method,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(salaryForm),
    });
    setSalaryModalOpen(false);
    loadSalaries();
  };

  const handlePaymentSubmit = async () => {
    const method = paymentForm.id ? 'PUT' : 'POST';
    await fetch(API_SALARY_PAYMENTS, {
      method,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(paymentForm),
    });
    setPaymentModalOpen(false);
    loadPayments();
  };

  useEffect(() => {
    loadSalaries();
    loadPayments();
  }, []);

  return (
    <div>
      <h1>Staff Salaries</h1>
      <button onClick={() => setSalaryModalOpen(true)}>Add Salary</button>
      <table>
        <thead>
          <tr>
            <th>Staff ID</th>
            <th>Month</th>
            <th>Period</th>
            <th>Definition</th>
            <th>Amount</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {salaries.map((salary) => (
            <tr key={salary.id}>
              <td>{salary.staff_id}</td>
              <td>{salary.month}</td>
              <td>{salary.period_month}</td>
              <td>{salary.definition_id}</td>
              <td>{salary.amount}</td>
              <td>
                <button onClick={() => { setSalaryForm(salary); setSalaryModalOpen(true); }}>Edit</button>
                <button onClick={async () => {
                  await fetch(API_STAFF_SALARIES, {
                    method: 'DELETE',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ id: salary.id }),
                  });
                  loadSalaries();
                }}>Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      <h1>Salary Payments</h1>
      <button onClick={() => setPaymentModalOpen(true)}>Add Payment</button>
      <table>
        <thead>
          <tr>
            <th>Staff ID</th>
            <th>Wallet ID</th>
            <th>Amount</th>
            <th>Method</th>
            <th>Reference</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {payments.map((payment) => (
            <tr key={payment.id}>
              <td>{payment.staff_id}</td>
              <td>{payment.wallet_id}</td>
              <td>{payment.amount}</td>
              <td>{payment.method}</td>
              <td>{payment.reference}</td>
              <td>
                <button onClick={() => { setPaymentForm(payment); setPaymentModalOpen(true); }}>Edit</button>
                <button onClick={async () => {
                  await fetch(API_SALARY_PAYMENTS, {
                    method: 'DELETE',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ id: payment.id }),
                  });
                  loadPayments();
                }}>Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      {salaryModalOpen && (
        <div className="modal">
          <h2>{salaryForm.id ? 'Edit' : 'Add'} Salary</h2>
          <input
            placeholder="Staff ID"
            value={salaryForm.staff_id}
            onChange={(e) => setSalaryForm({ ...salaryForm, staff_id: e.target.value })}
          />
          <input
            placeholder="Month"
            value={salaryForm.month}
            onChange={(e) => setSalaryForm({ ...salaryForm, month: e.target.value })}
          />
          <input
            placeholder="Period Month"
            value={salaryForm.period_month}
            onChange={(e) => setSalaryForm({ ...salaryForm, period_month: e.target.value })}
          />
          <input
            placeholder="Definition ID"
            value={salaryForm.definition_id}
            onChange={(e) => setSalaryForm({ ...salaryForm, definition_id: e.target.value })}
          />
          <input
            placeholder="Amount"
            value={salaryForm.amount}
            onChange={(e) => setSalaryForm({ ...salaryForm, amount: e.target.value })}
          />
          <button onClick={handleSalarySubmit}>Save</button>
          <button onClick={() => setSalaryModalOpen(false)}>Cancel</button>
        </div>
      )}

      {paymentModalOpen && (
        <div className="modal">
          <h2>{paymentForm.id ? 'Edit' : 'Add'} Payment</h2>
          <input
            placeholder="Staff ID"
            value={paymentForm.staff_id}
            onChange={(e) => setPaymentForm({ ...paymentForm, staff_id: e.target.value })}
          />
          <input
            placeholder="Wallet ID"
            value={paymentForm.wallet_id}
            onChange={(e) => setPaymentForm({ ...paymentForm, wallet_id: e.target.value })}
          />
          <input
            placeholder="Amount"
            value={paymentForm.amount}
            onChange={(e) => setPaymentForm({ ...paymentForm, amount: e.target.value })}
          />
          <input
            placeholder="Method"
            value={paymentForm.method}
            onChange={(e) => setPaymentForm({ ...paymentForm, method: e.target.value })}
          />
          <input
            placeholder="Reference"
            value={paymentForm.reference}
            onChange={(e) => setPaymentForm({ ...paymentForm, reference: e.target.value })}
          />
          <button onClick={handlePaymentSubmit}>Save</button>
          <button onClick={() => setPaymentModalOpen(false)}>Cancel</button>
        </div>
      )}
    </div>
  );
}
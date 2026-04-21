export const mapHeaders = (headers: string[]) => {
  const dbFields = {
    admission_no: 'Admission Number',
    first_name: 'First Name',
    last_name: 'Last Name',
    gender: 'Gender',
    date_of_birth: 'Date of Birth',
    phone: 'Phone',
    email: 'Email',
    address: 'Address',
    village_id: 'Village ID',
    admission_date: 'Admission Date',
    status: 'Status',
    notes: 'Notes',
  };

  const mappedHeaders: Record<string, string> = {};
  const unmappedHeaders: string[] = [];

  headers.forEach((header) => {
    const dbField = Object.keys(dbFields).find((key) =>
      dbFields[key].toLowerCase() === header.toLowerCase()
    );
    if (dbField) {
      mappedHeaders[dbField] = header;
    } else {
      unmappedHeaders.push(header);
    }
  });

  return { mappedHeaders, unmappedHeaders };
};

export const validateData = (rows: Record<string, unknown>[], mappedHeaders: Record<string, string>) => {
  const validRows = [];
  const errors = [];

  rows.forEach((row, rowIndex) => {
    const cleanRow: Record<string, unknown> = {};
    let hasError = false;

    Object.keys(mappedHeaders).forEach((dbField) => {
      const value = row[mappedHeaders[dbField]];
      if (!value && dbField !== 'notes') {
        errors.push({ row: rowIndex + 2, field: dbField, error: 'Missing value' });
        hasError = true;
      } else {
        cleanRow[dbField] = value;
      }
    });

    if (!hasError) {
      validRows.push(cleanRow);
    }
  });

  return { validRows, errors };
};

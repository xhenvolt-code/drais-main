"use client";
import React, { useState, useRef, useEffect } from 'react';
import { Upload, FileText, AlertCircle, CheckCircle, Download, Eye, ArrowRight, X } from 'lucide-react';
import { Button } from '@/components/ui/Button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/Card';
import { Progress } from '@/components/ui/loading/Progress';
import * as XLSX from 'xlsx';

interface Option { id: number; name: string; }

interface Mapping {
  [header: string]: string;
}

interface ImportPreview {
  headers: string[];
  rows: any[][];
  totalRows: number;
  sampleRows: any[][];
}

interface ValidationResult {
  isValid: boolean;
  errors: string[];
  warnings: string[];
}

export default function ResultsImportSystem() {
  const [step, setStep] = useState<'upload' | 'mapping' | 'preview' | 'import'>('upload');
  const [file, setFile] = useState<File | null>(null);
  const [preview, setPreview] = useState<ImportPreview | null>(null);
  const [mappings, setMappings] = useState<Mapping>({});
  const [academicYears, setAcademicYears] = useState<Option[]>([]);
  const [terms, setTerms] = useState<Option[]>([]);
  const [classes, setClasses] = useState<Option[]>([]);
  const [resultTypes, setResultTypes] = useState<Option[]>([]);
  const [subjects, setSubjects] = useState<Option[]>([]);
  const [selectedAcademicYear, setSelectedAcademicYear] = useState<string>('');
  const [selectedTerm, setSelectedTerm] = useState<string>('');
  const [selectedClass, setSelectedClass] = useState<string>('');
  const [selectedResultType, setSelectedResultType] = useState<string>('');
  const [loading, setLoading] = useState(false);
  const [importing, setImporting] = useState(false);
  const [validation, setValidation] = useState<ValidationResult>({ isValid: false, errors: [], warnings: [] });
  const [importResult, setImportResult] = useState<any>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  // Load metadata on mount
  useEffect(() => {
    loadMetadata();
  }, []);

  const loadMetadata = async () => {
    try {
      const [yearsRes, termsRes, classesRes, typesRes, subjectsRes] = await Promise.all([
        fetch('/api/academic_years'),
        fetch('/api/terms'),
        fetch('/api/classes'),
        fetch('/api/result_types'),
        fetch('/api/subjects')
      ]);

      const years = yearsRes.ok ? await yearsRes.json() : [];
      const terms = termsRes.ok ? await termsRes.json() : [];
      const classes = classesRes.ok ? await classesRes.json() : [];
      const types = typesRes.ok ? await typesRes.json() : [];
      const subjects = subjectsRes.ok ? await subjectsRes.json() : [];

      setAcademicYears(years);
      setTerms(terms);
      setClasses(classes);
      setResultTypes(types);
      setSubjects(subjects);
    } catch (error) {
      console.error('Error loading metadata:', error);
    }
  };

  const handleFileSelect = async (selectedFile: File) => {
    setFile(selectedFile);
    setLoading(true);

    try {
      const arrayBuffer = await selectedFile.arrayBuffer();
      let rows: any[][] = [];

      if (selectedFile.name.endsWith('.xlsx') || selectedFile.name.endsWith('.xls')) {
        const workbook = XLSX.read(arrayBuffer, { type: 'buffer' });
        const sheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[sheetName];
        rows = XLSX.utils.sheet_to_json(worksheet, { header: 1 });
      } else if (selectedFile.name.endsWith('.csv')) {
        // For CSV, we'll handle it in the preview step
        const text = await selectedFile.text();
        const lines = text.split('\n').filter(line => line.trim());
        rows = lines.map(line => line.split(','));
      }

      if (rows.length === 0) {
        throw new Error('No data found in file');
      }

      const headers = rows[0];
      const dataRows = rows.slice(1);
      const sampleRows = dataRows.slice(0, 5); // Show first 5 rows as sample

      setPreview({
        headers,
        rows: dataRows,
        totalRows: dataRows.length,
        sampleRows
      });

      // Auto-detect mappings
      const autoMappings: Mapping = {};
      headers.forEach((header: string) => {
        const lowerHeader = header.toLowerCase().trim();

        if (lowerHeader.includes('student') && lowerHeader.includes('no')) {
          autoMappings[header] = 'admission_no';
        } else if (lowerHeader.includes('admission')) {
          autoMappings[header] = 'admission_no';
        } else if (lowerHeader.includes('first') && lowerHeader.includes('name')) {
          autoMappings[header] = 'first_name';
        } else if (lowerHeader.includes('last') && lowerHeader.includes('name')) {
          autoMappings[header] = 'last_name';
        } else {
          // Check if it matches any subject
          const matchingSubject = subjects.find(s =>
            s.name.toLowerCase().includes(lowerHeader) ||
            lowerHeader.includes(s.name.toLowerCase())
          );
          if (matchingSubject) {
            autoMappings[header] = `subject_${matchingSubject.id}`;
          }
        }
      });

      setMappings(autoMappings);
      setStep('mapping');
    } catch (error) {
      console.error('Error processing file:', error);
      alert('Error processing file: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleMappingChange = (header: string, field: string) => {
    setMappings(prev => ({
      ...prev,
      [header]: field
    }));
  };

  const validateMappings = () => {
    const errors: string[] = [];
    const warnings: string[] = [];

    // Check if student identifier is mapped
    const hasStudentId = Object.values(mappings).some(field =>
      field === 'admission_no' || field === 'first_name' || field === 'last_name'
    );

    if (!hasStudentId) {
      errors.push('At least one student identifier (admission number, first name, or last name) must be mapped');
    }

    // Check if at least one subject is mapped
    const hasSubjects = Object.values(mappings).some(field => field.startsWith('subject_'));

    if (!hasSubjects) {
      errors.push('At least one subject column must be mapped');
    }

    // Check for required selections
    if (!selectedAcademicYear) {
      errors.push('Academic year must be selected');
    }
    if (!selectedTerm) {
      errors.push('Term must be selected');
    }
    if (!selectedClass) {
      errors.push('Class must be selected');
    }
    if (!selectedResultType) {
      errors.push('Result type must be selected');
    }

    setValidation({ isValid: errors.length === 0, errors, warnings });
    return errors.length === 0;
  };

  const handleImport = async () => {
    if (!validateMappings() || !file) return;

    setImporting(true);
    try {
      const formData = new FormData();
      formData.append('file', file);
      formData.append('academic_year_id', selectedAcademicYear);
      formData.append('term_id', selectedTerm);
      formData.append('class_id', selectedClass);
      formData.append('result_type_id', selectedResultType);
      formData.append('mappings', JSON.stringify(mappings));

      const response = await fetch('/api/class_results/import', {
        method: 'POST',
        body: formData,
      });

      const result = await response.json();

      if (response.ok && result.success) {
        setImportResult(result);
        setStep('import');
      } else {
        alert('Import failed: ' + (result.error || 'Unknown error'));
      }
    } catch (error) {
      console.error('Import error:', error);
      alert('Import failed: ' + error.message);
    } finally {
      setImporting(false);
    }
  };

  const downloadTemplate = () => {
    const headers = ['Student No', 'First Name', 'Last Name'];
    subjects.slice(0, 5).forEach(subject => {
      headers.push(subject.name);
    });

    const sampleData = [
      headers,
      ['STU001', 'John', 'Doe', 85, 90, 88, 92, 87],
      ['STU002', 'Jane', 'Smith', 92, 88, 95, 90, 91]
    ];

    const ws = XLSX.utils.aoa_to_sheet(sampleData);
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, 'Results Template');
    XLSX.writeFile(wb, 'results_import_template.xlsx');
  };

  const resetImport = () => {
    setStep('upload');
    setFile(null);
    setPreview(null);
    setMappings({});
    setValidation({ isValid: false, errors: [], warnings: [] });
    setImportResult(null);
  };

  return (
    <div className="max-w-6xl mx-auto p-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Import Academic Results</h1>
          <p className="text-gray-600 mt-1">Upload Excel or CSV files to bulk import student results</p>
        </div>
        <Button onClick={downloadTemplate} variant="outline" className="flex items-center gap-2">
          <Download className="w-4 h-4" />
          Download Template
        </Button>
      </div>

      {/* Progress Steps */}
      <div className="flex items-center space-x-4">
        {[
          { key: 'upload', label: 'Upload File', icon: Upload },
          { key: 'mapping', label: 'Map Columns', icon: FileText },
          { key: 'preview', label: 'Preview & Validate', icon: Eye },
          { key: 'import', label: 'Import Results', icon: CheckCircle }
        ].map(({ key, label, icon: Icon }, index) => (
          <div key={key} className="flex items-center">
            <div className={`flex items-center justify-center w-8 h-8 rounded-full ${
              step === key ? 'bg-blue-600 text-white' :
              ['upload', 'mapping', 'preview', 'import'].indexOf(step) > index ? 'bg-green-600 text-white' :
              'bg-gray-200 text-gray-600'
            }`}>
              <Icon className="w-4 h-4" />
            </div>
            <span className={`ml-2 text-sm font-medium ${
              step === key ? 'text-blue-600' : 'text-gray-600'
            }`}>
              {label}
            </span>
            {index < 3 && <ArrowRight className="w-4 h-4 mx-4 text-gray-400" />}
          </div>
        ))}
      </div>

      {/* Step Content */}
      {step === 'upload' && (
        <Card>
          <CardHeader>
            <CardTitle>Upload File</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center">
              <Upload className="w-12 h-12 mx-auto text-gray-400 mb-4" />
              <h3 className="text-lg font-medium text-gray-900 mb-2">Upload your results file</h3>
              <p className="text-gray-600 mb-4">Support for Excel (.xlsx, .xls) and CSV files</p>
              <input
                ref={fileInputRef}
                type="file"
                accept=".xlsx,.xls,.csv"
                onChange={(e) => e.target.files?.[0] && handleFileSelect(e.target.files[0])}
                className="hidden"
              />
              <Button onClick={() => fileInputRef.current?.click()} disabled={loading}>
                {loading ? 'Processing...' : 'Choose File'}
              </Button>
            </div>

            {file && (
              <div className="flex items-center justify-between p-4 bg-green-50 border border-green-200 rounded-lg">
                <div className="flex items-center space-x-3">
                  <FileText className="w-5 h-5 text-green-600" />
                  <div>
                    <p className="font-medium text-green-900">{file.name}</p>
                    <p className="text-sm text-green-700">{(file.size / 1024).toFixed(1)} KB</p>
                  </div>
                </div>
                <Button onClick={() => setStep('mapping')} variant="outline" size="sm">
                  Continue
                </Button>
              </div>
            )}
          </CardContent>
        </Card>
      )}

      {step === 'mapping' && preview && (
        <Card>
          <CardHeader>
            <CardTitle>Map Columns to Fields</CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            {/* Target Selection */}
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
              <div>
                <label className="block text-sm font-medium mb-2">Academic Year</label>
                <select
                  value={selectedAcademicYear}
                  onChange={(e) => setSelectedAcademicYear(e.target.value)}
                  className="w-full p-2 border rounded-lg"
                >
                  <option value="">Select Year</option>
                  {academicYears.map(year => (
                    <option key={year.id} value={year.id}>{year.name}</option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium mb-2">Term</label>
                <select
                  value={selectedTerm}
                  onChange={(e) => setSelectedTerm(e.target.value)}
                  className="w-full p-2 border rounded-lg"
                >
                  <option value="">Select Term</option>
                  {terms.map(term => (
                    <option key={term.id} value={term.id}>{term.name}</option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium mb-2">Class</label>
                <select
                  value={selectedClass}
                  onChange={(e) => setSelectedClass(e.target.value)}
                  className="w-full p-2 border rounded-lg"
                >
                  <option value="">Select Class</option>
                  {classes.map(cls => (
                    <option key={cls.id} value={cls.id}>{cls.name}</option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium mb-2">Result Type</label>
                <select
                  value={selectedResultType}
                  onChange={(e) => setSelectedResultType(e.target.value)}
                  className="w-full p-2 border rounded-lg"
                >
                  <option value="">Select Type</option>
                  {resultTypes.map(type => (
                    <option key={type.id} value={type.id}>{type.name}</option>
                  ))}
                </select>
              </div>
            </div>

            {/* Column Mappings */}
            <div className="space-y-4">
              <h3 className="text-lg font-medium">Column Mappings</h3>
              <div className="grid gap-4">
                {preview.headers.map((header, index) => (
                  <div key={index} className="flex items-center space-x-4 p-4 border rounded-lg">
                    <div className="flex-1">
                      <span className="font-medium">{header}</span>
                      <div className="text-sm text-gray-500 mt-1">
                        Sample: {preview.sampleRows[0]?.[index] || 'N/A'}
                      </div>
                    </div>
                    <select
                      value={mappings[header] || ''}
                      onChange={(e) => handleMappingChange(header, e.target.value)}
                      className="flex-1 p-2 border rounded-lg"
                    >
                      <option value="">Don't import</option>
                      <option value="admission_no">Student Number</option>
                      <option value="first_name">First Name</option>
                      <option value="last_name">Last Name</option>
                      {subjects.map(subject => (
                        <option key={subject.id} value={`subject_${subject.id}`}>
                          Subject: {subject.name}
                        </option>
                      ))}
                    </select>
                  </div>
                ))}
              </div>
            </div>

            {/* Validation Errors */}
            {validation.errors.length > 0 && (
              <div className="p-4 border border-red-200 bg-red-50 rounded-lg">
                <div className="flex items-center space-x-2">
                  <AlertCircle className="h-4 w-4 text-red-600" />
                  <h4 className="text-sm font-medium text-red-800">Validation Errors</h4>
                </div>
                <ul className="mt-2 list-disc list-inside text-sm text-red-700">
                  {validation.errors.map((error, index) => (
                    <li key={index}>{error}</li>
                  ))}
                </ul>
              </div>
            )}

            <div className="flex justify-between">
              <Button onClick={() => setStep('upload')} variant="outline">
                Back
              </Button>
              <Button onClick={() => setStep('preview')} disabled={!validation.isValid}>
                Preview Import
              </Button>
            </div>
          </CardContent>
        </Card>
      )}

      {step === 'preview' && preview && (
        <Card>
          <CardHeader>
            <CardTitle>Preview Import Data</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="overflow-x-auto">
              <table className="w-full border-collapse border border-gray-300">
                <thead>
                  <tr className="bg-gray-50">
                    {preview.headers.map((header, index) => (
                      <th key={index} className="border border-gray-300 p-2 text-left">
                        {header}
                        <div className="text-xs text-gray-500">
                          → {mappings[header] || 'Not mapped'}
                        </div>
                      </th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {preview.sampleRows.map((row, rowIndex) => (
                    <tr key={rowIndex}>
                      {row.map((cell, cellIndex) => (
                        <td key={cellIndex} className="border border-gray-300 p-2">
                          {cell || '-'}
                        </td>
                      ))}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            <div className="text-sm text-gray-600">
              Showing {preview.sampleRows.length} of {preview.totalRows} rows
            </div>

            <div className="flex justify-between">
              <Button onClick={() => setStep('mapping')} variant="outline">
                Back
              </Button>
              <Button onClick={handleImport} disabled={importing}>
                {importing ? 'Importing...' : 'Start Import'}
              </Button>
            </div>
          </CardContent>
        </Card>
      )}

      {step === 'import' && importResult && (
        <Card>
          <CardHeader>
            <CardTitle>Import Complete</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="text-center">
              <CheckCircle className="w-16 h-16 text-green-600 mx-auto mb-4" />
              <h3 className="text-xl font-semibold text-green-900 mb-2">Import Successful!</h3>
              <div className="space-y-2 text-gray-600">
                <p>Imported: {importResult.imported} records</p>
                <p>Skipped: {importResult.skipped} records</p>
                {importResult.warnings.length > 0 && (
                  <div className="mt-4">
                    <h4 className="font-medium text-yellow-800">Warnings:</h4>
                    <ul className="list-disc list-inside text-yellow-700">
                      {importResult.warnings.map((warning: string, index: number) => (
                        <li key={index}>{warning}</li>
                      ))}
                    </ul>
                  </div>
                )}
              </div>
            </div>

            <div className="flex justify-center">
              <Button onClick={resetImport}>
                Import Another File
              </Button>
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
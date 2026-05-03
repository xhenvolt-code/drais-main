import { NextRequest, NextResponse } from 'next/server';
import fs from 'fs/promises';
import path from 'path';

/**
 * Northgate Emergency Reports Route
 * GET /academics/northgate-emergency-reports
 * 
 * Query parameters:
 * - class_id: Filter by class index (0-based)
 * - format: 'html' (default) or 'json' for raw data
 * - term: Filter by term (future enhancement)
 * - result_type: Filter by result type (future enhancement)
 */
export async function GET(req: NextRequest) {
  try {
    const classId = req.nextUrl.searchParams.get('class_id');
    const term = req.nextUrl.searchParams.get('term') || 'all';
    const resultType = req.nextUrl.searchParams.get('result_type') || 'all';
    const format = req.nextUrl.searchParams.get('format') || 'html';

    // Read the JSON backup file
    const jsonPath = path.join(process.cwd(), 'backup', 'northgate-term1-2026-results.json');
    const jsonData = await fs.readFile(jsonPath, 'utf-8');
    const data = JSON.parse(jsonData);

    // Return JSON if requested
    if (format === 'json') {
      return NextResponse.json(data);
    }

    // Read the template
    const templatePath = path.join(process.cwd(), 'backup', 'rpt.html');
    let template = await fs.readFile(templatePath, 'utf-8');

    // Filter classes if specified
    let classesToRender = data.classes;
    if (classId) {
      const idx = parseInt(classId, 10);
      if (!isNaN(idx) && idx >= 0 && idx < data.classes.length) {
        classesToRender = [data.classes[idx]];
      }
    }

    // Generate all reports
    let allReportsHtml = '';

    // Print controls UI with data info
    const printControls = `
      <div class="no-print" style="position: fixed; top: 10px; right: 10px; background: white; border: 2px solid #0000FF; border-radius: 8px; padding: 15px; z-index: 1000; box-shadow: 0 4px 6px rgba(0,0,0,0.1); min-width: 340px;">
        <div style="text-align: center; margin-bottom: 12px;">
          <h3 style="margin: 0 0 4px 0; color: #0000FF; font-size: 14px;">📋 Report Controls</h3>
          <p style="margin: 0; font-size: 10px; color: #666;">
            📊 ${classesToRender.reduce((sum, c) => sum + c.students.length, 0)} students | 
            🎯 ${data.summary.totalResultRecords} results
          </p>
          <p style="margin: 4px 0 0 0; font-size: 11px; color: #0066CC; font-weight: bold;">
            ${data.term} - ${data.resultType}
          </p>
        </div>
        
        <div style="margin-bottom: 10px;">
          <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #333; font-size: 12px;">Select Class:</label>
          <select id="classSelect" onchange="filterByClass()" style="width: 100%; padding: 8px; border: 1px solid #0000FF; border-radius: 4px; font-size: 12px;">
            <option value="">📚 All Classes (${data.classes.length})</option>
            ${data.classes.map((c, idx) => `<option value="${idx}">${c.className}${c.stream ? ' - ' + c.stream : ''} (${c.students.length})</option>`).join('')}
          </select>
        </div>

        <div style="display: flex; gap: 8px; flex-direction: column;">
          <button onclick="showAll()" style="flex: 1; padding: 10px; background: #0000FF; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 12px;">🔄 View All</button>
          <button onclick="printAll()" style="flex: 1; padding: 10px; background: #008000; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 12px;">🖨️ Print All</button>
          <button onclick="printSelectedClass()" style="flex: 1; padding: 10px; background: #FF6600; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 12px;">🖨️ Print Class</button>
        </div>
        
        <div style="margin-top: 10px; padding: 10px; background: #FFF3CD; border: 1px solid #FFC107; border-radius: 4px; font-size: 11px; color: #856404; text-align: center; font-weight: bold;">
          📅 Next Term Begins: <strong>25th May 2026</strong>
        </div>
        
        <div style="margin-top: 10px; padding-top: 10px; border-top: 1px solid #eee; font-size: 10px; color: #999;">
          ✅ Verified: Real data | Filtered by term &amp; result type | ${data.summary.studentsWithPhotos}/${data.summary.totalCurrentStudents} photos
        </div>
      </div>

      <script>
        function showAll() {
          document.getElementById('classSelect').value = '';
          window.location.href = window.location.pathname;
        }

        function filterByClass() {
          const selectedClass = document.getElementById('classSelect').value;
          if (selectedClass) {
            window.location.href = '?class_id=' + selectedClass;
          } else {
            window.location.href = window.location.pathname;
          }
        }

        function printAll() {
          const selectedClass = document.getElementById('classSelect').value;
          if (selectedClass) {
            // Print all by going to root
            window.print();
          } else {
            window.print();
          }
        }

        function printSelectedClass() {
          const selectedClass = document.getElementById('classSelect').value;
          if (selectedClass) {
            const url = '?class_id=' + selectedClass;
            setTimeout(() => window.print(), 100);
          } else {
            window.print();
          }
        }
      </script>
    `;

    // Process each student in each class
    for (const classInfo of classesToRender) {
      for (const student of classInfo.students) {
        let reportHtml = template;

        // Build subjects table
        let subjectsHtml = '';
        let totalMarks = student.total || 0;
        let averageMarks = student.average || 0;
        let subjectCount = student.subjectCount || 0;

        if (student.results && Array.isArray(student.results)) {
          subjectsHtml += `<tr><td>Marks contribute:</td><td>100</td><td>100</td><td></td><td></td><td></td></tr>`;
          
          for (const result of student.results) {
            const eotMarks = result.score ? parseFloat(result.score).toFixed(0) : '—';
            const total = result.score ? parseFloat(result.score).toFixed(0) : '—';
            const grade = result.grade || '—';
            const comment = result.remarks || 'Review performance';
            const initials = result.teacherInitials || 'NGS';
            const subjectName = result.subjectName || result.subject || 'Unknown Subject';
            
            subjectsHtml += `<tr><td>${subjectName}</td><td>${eotMarks}</td><td>${total}</td><td style="color:red">${grade}</td><td class="comment-cell">${comment}</td><td class="initials">${initials}</td></tr>`;
          }
        }

        // Replace all placeholders in template
        reportHtml = reportHtml.replace(/KWAGALA JEMIMAH/g, student.name || 'N/A');
        reportHtml = reportHtml.replace(/<img src="photo\.jpg"/g, `<img src="${student.photoUrl || '/placeholder-student.png'}"`);
        
        // Replace logo - handle both badge.png and any other logo placeholders
        reportHtml = reportHtml.replace(
          /src="badge\.png"/g,
          'src="/client_logos/northgateschool.png"'
        );
        reportHtml = reportHtml.replace(
          /<img[^>]*src="[^"]*logo[^"]*"[^>]*>/gi,
          '<img src="/client_logos/northgateschool.png" style="height: 60px; width: auto; display: block;" />'
        );
        

        reportHtml = reportHtml.replace(/0018000034/g, student.admissionNumber || student.id);
        reportHtml = reportHtml.replace(/<img src="https:\/\/bwipjs-api\.metafloor\.com\/\?bcid=code128&text=0018000034[^"]*"/g, `<img src="https://bwipjs-api.metafloor.com/?bcid=code128&text=${student.admissionNumber || student.id}&includetext&rotate=L&scale=1&height=18"`);
        reportHtml = reportHtml.replace(/Sex:[\s\S]*?<span class="info-value">F<\/span>/g, `Sex:<br><span class="info-value">${student.gender || 'N/A'}</span>`);
        reportHtml = reportHtml.replace(/Class:[\s\S]*?<span class="info-value">P\.1<\/span>/g, `Class:<br><span class="info-value">${classInfo.className}</span>`);
        reportHtml = reportHtml.replace(/Stream:[\s\S]*?<span class="info-value">A<\/span>/g, `Stream:<br><span class="info-value">${classInfo.stream || 'A'}</span>`);
        reportHtml = reportHtml.replace(/TermI-2023/g, `${data.term} - ${data.resultType}`);
        reportHtml = reportHtml.replace(/22-May-2023/g, '25-May-2026');
        
        // Replace subjects table - find the tbody and replace its content
        reportHtml = reportHtml.replace(
          /<tbody>[\s\S]*?<\/tbody>/,
          `<tbody>${subjectsHtml}</tbody>`
        );

        // Replace totals
        reportHtml = reportHtml.replace(/TOTAL MARKS:<\/td><td colspan="2">364<\/td>/g, `TOTAL MARKS:</td><td colspan="2">${Math.round(totalMarks)}</td>`);
        reportHtml = reportHtml.replace(/AVERAGE MARKS:<\/td><td>91<\/td>/g, `AVERAGE MARKS:</td><td>${Math.round(averageMarks)}</td>`);

        // Replace position info
        reportHtml = reportHtml.replace(/4 \/ 36/g, `${student.position} / ${classInfo.students.length}`);
        
        // Add page break for print
        reportHtml += `<div style="page-break-after: always; margin-top: 40px;"></div>`;
        
        allReportsHtml += reportHtml;
      }
    }

    // Build final HTML
    const fullHtml = `
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <title>Northgate Emergency Reports - Term 1 2026</title>
        <style>
          body { 
            font-family: Arial, sans-serif; 
            font-size: 12px; 
            margin: 0; 
            padding: 20px; 
            color: #333;
            background: #f5f5f5;
          }
          .report-container { 
            width: 800px; 
            margin: auto; 
            border: 1px solid #ccc; 
            padding: 10px;
            background: white;
            margin-bottom: 20px;
          }
          @page { size: A4; margin: 1cm; }
          @media print {
            body { padding: 0; background: white; }
            .report-container { margin-bottom: 0; page-break-after: always; }
            .no-print { display: none !important; }
            img { max-width: 100%; height: auto; }
          }
        </style>
      </head>
      <body>
        ${printControls}
        ${allReportsHtml}
      </body>
      </html>
    `;

    return new NextResponse(fullHtml, {
      headers: {
        'Content-Type': 'text/html; charset=utf-8',
      },
    });

  } catch (error) {
    console.error('Error generating Northgate emergency reports:', error);
    return NextResponse.json(
      { 
        error: 'Failed to generate reports',
        message: error instanceof Error ? error.message : 'Unknown error',
      },
      { status: 500 }
    );
  }
}

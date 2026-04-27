<?php
/*
 * DRAIS Student Reports - PHP Implementation
 * 
 * NEXT.JS PARITY IMPLEMENTATION
 * =============================
 * This file has been enhanced to achieve complete parity with the Next.js reports module.
 * 
 * IMPLEMENTED FEATURES:
 * 
 * 1. PROMOTION LOGIC ENGINE
 *    - Complete promotion status calculation system
 *    - Class name normalization (handles variations like "Primary 1", "P1", "p.1")
 *    - Automatic next class determination 
 *    - Support for nursery, primary lower, and primary upper logic
 *    - Probation and repeat recommendations
 * 
 * 2. SUBJECT GROUPING
 *    - Separation of principal subjects vs other subjects
 *    - Dynamic table rendering for both subject types
 *    - Proper subject type detection and categorization
 * 
 * 3. ENHANCED POSITIONING LOGIC
 *    - Improved sorting by average marks within classes
 *    - Consistent ranking algorithms (kept disabled per requirements)
 * 
 * 4. VISUAL DESIGN PARITY
 *    - Matching table styles, colors, and layouts
 *    - Proper banner styling and positioning
 *    - Consistent typography and spacing
 *    - Promotion status badges with proper color coding
 * 
 * 5. TEACHER INITIALS SYSTEM
 *    - Centralized teacher mapping by class and subject
 *    - Automatic initials generation
 *    - Fallback system for unmapped subjects
 * 
 * 6. DATA VALIDATION & ERROR HANDLING
 *    - Proper validation of student data
 *    - Default values for missing fields
 *    - Error handling for calculation functions
 * 
 * MAINTENANCE NOTES:
 * - Filtering system left unchanged as per requirements
 * - Position calculation kept disabled as per requirements
 * - All styling variables are customizable through the admin panel
 * - Promotion logic can be extended for custom criteria in the future
 * 
 * COMPATIBILITY:
 * - Fully compatible with existing PHP backend
 * - Maintains all existing functionality
 * - Extends features without breaking changes
 */
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Student Reports - Enhanced with Next.js Parity</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      padding: 20px;
      background: #fff;
    }
    .student-info-container {
      display: flex; 
      flex-direction: row;
      margin-bottom: 0px;
    }
    .student-info {
      display: flex; 
      flex-direction: column;
    }
    .report-page {
      page-break-after: always;
      background: #fff;
      box-shadow: 0 2px 8px #e6f0fa;
      padding: 16px 18px 16px 18px;
      border-radius: 8px;
      max-width: 900px;
      margin: 0 auto 40px;
      font-size: 14px;
    }
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding-bottom: 10px;
      opacity: .8;
      margin-bottom: 0px;
      margin-top: 0px;
    }
    .motto {
      font-family: "times new roman";
    }
    .school_name {
      font-family: "bernard mt condensed";
      color:rgb(5, 48, 165);

    }
    .school-info {
      font-family: "verdana";
      font-size: 19px;
      color:rgb(5, 48, 165);
    }
    .value {
      color:red;
      text-decoration: underline dashed;
    }
    .school-info h1 {
      margin: 0;
      font-size: 40px;
    }
    .school-info p {
      margin: 3px 0;
      font-size: 13px;
      color: #000;
    }
    .school-logo img {
      width: 90px;
      height: 90px;
      object-fit: contain;
    }
    .blue-banner {
      background-color:rgb(5, 50, 173);
      color: white;
      text-align: center;
      font-size: 16px;
      font-weight: bold;
      padding: 8px;
      margin-top: 8px;
      margin-bottom: 4px;
    }
    .gray-ribbon {
      position: relative;
      background:rgb(145, 140, 140);
      color: #000;
      text-align: center;
      font-weight: bold;
      font-size: 18px;
      padding: 4px;
      margin-top: 4px;
      margin-bottom: 20px;
      margin-left: 15%;
      margin-right: 15%;
      max-width: 70%;
      justify-content: center;
    }
    .gray-ribbon::after {
      content: "";
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
      bottom: -16px;
      width: 0;
      height: 20px;
      border-left: 16px solid transparent;
      border-right: 16px solid transparent;
      border-top: 16px solid rgb(145, 140, 140);
    }
    .student-details {
      display: flex;
      gap: 5px;
      margin-bottom: 2px;
    }
    .student-photo {
      width: 120px;
      height: 125px;
      object-fit: cover; 
      margin-right:20px;
      cursor: pointer;
      transition: opacity 0.2s;
      position: relative;
    }
    .student-photo:hover {
      opacity: 0.7;
    }
    .photo-upload-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 120px;
      height: 125px;
      display: none;
      background: rgba(0,0,0,0.5);
      color: white;
      align-items: center;
      justify-content: center;
      font-size: 12px;
      pointer-events: none;
    }
    .student-photo:hover + .photo-upload-overlay {
      display: flex;
    }
    .editable-score {
      cursor: text;
      background: #fffacd;
      transition: background 0.2s;
    }
    .editable-score:hover {
      background: #ffeb3b;
    }
    .editable-score:focus {
      outline: 2px solid #1a4be7;
      background: #fff;
    }
    .delete-row-btn {
      display: none;
      cursor: pointer;
      color: red;
      font-weight: bold;
      padding: 2px 6px;
      background: #ffe6e6;
      border: 1px solid red;
      border-radius: 3px;
      font-size: 11px;
      margin-left: 5px;
    }
    .student-table tr:hover .delete-row-btn {
      display: inline-block;
    }
    .delete-row-btn:hover {
      background: #ff0000;
      color: white;
    }
    @media print {
      .delete-row-btn { display: none !important; }
    }
    .barcode-card {
      display: flex;
      flex-direction: row;
      padding: 0px;
      margin:0;
      gap: 2px;
      align-items: center;
    }
    .barcode-img {
      width: 110px;
      height: 50px;
      margin-right:-30px;
      margin-left:-20px;
      transform: rotate(270deg);
    }
    .barcode-vertical {
      font-size: 15px;
      font-weight: 500;
      margin: 0px;
      transform: rotate(180deg);
      writing-mode: vertical-rl;
    }
    .student-table {
      border-collapse: collapse;
      width: 100%;
      margin-top: 10px;
      font-size: 14px;
    }
    .student-table th,
    .student-table td {
      border: 1px solid black;
      padding: 6px;
      text-align: center;
    }
    .student-table th {
      background: #f0f8ff;
    }
    .comments {
      margin-top: 30px;
      border-top: 2px dashed #999;
      padding-top: 15px;
    }
    .comments div {
      margin-bottom: 10px;
    }
    .grade-table {
      margin-top: 20px;
    }
    .grade-table table {
      width: 100%;
      border-collapse: collapse;
    }
    .grade-table th,
    .grade-table td {
      border: 1px solid rgb(4, 8, 26);
      text-align: center;
      padding: 6px;
    }
    .grade-table th {
      background: #f0f0f0;
    }
    .bold {
      font-weight: bold;
    }
    .center {
      text-align: center;
    }
    .next-term, .comment {
      text-decoration: underline dashed;
    }
    .bottom-ribbon {
      margin-top:20%;
    }
    .ribbon {
      display: inline-block;
      position: relative;
      background: var(--ribbon-bg, rgb(145, 140, 140));
      color: #000;
      font-weight: bold;
      padding: 4px 20px 4px 12px;
      border-radius: 0;
      margin-right: 18px;
      margin-bottom: 8px;
      font-size: 14px;
      /* keep slight rounding optional via inline styles */
    }
    .ribbon::after {
      content: "";
      position: absolute;
      right: -16px;
      top: 50%;
      transform: translateY(-50%);
      width: 0;
      height: 0;
      border-top: 14px solid transparent;
      border-bottom: 14px solid transparent;
      border-left: 16px solid var(--ribbon-bg, rgb(145, 140, 140));
    }
    /* optional small notch to enhance pentagonal look */
    .ribbon::before {
      content: "";
      position: absolute;
      left: -4px;
      top: 50%;
      transform: translateY(-50%);
      width: 0;
      height: 0;
      border-top: 6px solid transparent;
      border-bottom: 6px solid transparent;
      border-right: 4px solid var(--ribbon-bg, rgb(145, 140, 140));
    }
    /* Specific classes to avoid CSS conflicts elsewhere */
    .ribbon.class-teacher {}
    .ribbon.dos {}
    .ribbon.headteacher {}
    .comment {
      display: inline;
      color: #1a4be7;
      font-style: italic;
      border-bottom: 1.5px dashed #1a4be7;
      text-decoration: none;
    }
    .student-value {
      display: inline;
      color: blue; /* Changed from yellow to blue */
      font-style: italics;
      font-weight: bolder;
      text-decoration: none;
    }
    .report-page.hidden {
      display: none !important;
    }

    @media print {
      .report-actions { display: none !important; }
      body, html {
        width: 100vw;
        height: 100vh;
        margin: 0;
        padding: 0;
        background: #fff !important;
      }
      .report-page {
        page-break-after: always;
        width: 100vw !important;
        max-width: 100vw !important;
        min-width: 0 !important;
        box-sizing: border-box;
        margin: 0 !important;
        padding: 0.5cm 0.5cm 0.5cm 0.5cm !important;
        font-size: 13px !important;
        background: #fff !important;
        box-shadow: none !important;
        border-radius: 0 !important;
      }
      .report-page * {
        box-sizing: border-box !important;
        max-width: 100vw !important;
      }
      
      /* Enhanced barcode print styles */
      .barcode-svg {
        display: inline-block !important;
        visibility: visible !important;
        opacity: 1 !important;
        width: 110px !important;
        height: 50px !important;
        transform: rotate(270deg) !important;
        transform-origin: center center !important;
      }
      
      .barcode-card {
        display: flex !important;
        flex-direction: row !important;
        align-items: center !important;
        gap: 2px !important;
        visibility: visible !important;
      }
      
      .barcode-vertical {
        display: block !important;
        font-size: 15px !important;
        font-weight: 500 !important;
        transform: rotate(180deg) !important;
        writing-mode: vertical-rl !important;
        visibility: visible !important;
      }
    }
  </style>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Add JsBarcode library for SVG barcode generation -->
  <script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.5/dist/JsBarcode.all.min.js"></script>
</head>
<body>
  <div class="report-actions" style="display:flex; gap:10px; margin-bottom:16px; justify-content:flex-end;">
    <select id="filter-term" class="form-select" style="width:auto;">
      <option value="">All Terms</option>
      <option value="Term 1">Term 1</option>
      <option value="Term 2">Term 2</option>
      <option value="Term 3">Term 3</option>
    </select>
    <select id="filter-result-type" class="form-select" style="width:auto;">
      <option value="">All Result Types</option>
      <!-- Populated dynamically -->
    </select>
    <select id="filter-class" class="form-select" style="width:auto;">
      <option value="">All Classes</option>
      <!-- Populated dynamically -->
    </select>
    <input id="filter-student" class="form-control" style="width:auto;" placeholder="Type student name or ID" />
    <button onclick="applyFilters()" style="padding:8px 18px; font-size:15px; background:#0a8c3a; color:#fff; border:none; border-radius:5px; cursor:pointer;">Get Reports</button>
    <button onclick="window.print()" style="padding:8px 18px; font-size:15px; background:#134ef1; color:#fff; border:none; border-radius:5px; cursor:pointer;">Print</button>
    <button onclick="exportReports('pdf')" style="padding:8px 18px; font-size:15px; background:#1a4be7; color:#fff; border:none; border-radius:5px; cursor:pointer;">Export PDF</button>
    <button onclick="exportReports('csv')" style="padding:8px 18px; font-size:15px; background:#1a4be7; color:#fff; border:none; border-radius:5px; cursor:pointer;">Export CSV</button>
    <button onclick="openCustomizationModal()" style="padding:8px 18px; font-size:15px; background:#0a8c3a; color:#fff; border:none; border-radius:5px; cursor:pointer;">Customize Style</button>
  </div>
  <div id="reports-root"></div>
  <!-- Customization Modal -->
  <div id="customizationModal" class="modal fade" tabindex="-1" aria-labelledby="customizationModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h2 class="modal-title fs-4" id="customizationModalLabel">Customize Report Style</h2>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <ul class="nav nav-tabs mb-3" id="customTabs" role="tablist">
            <li class="nav-item" role="presentation">
              <button class="nav-link active" id="school-tab" data-bs-toggle="tab" data-bs-target="#school" type="button" role="tab">School</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="banner-tab" data-bs-toggle="tab" data-bs-target="#banner" type="button" role="tab">Banners</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="table-tab" data-bs-toggle="tab" data-bs-target="#table" type="button" role="tab">Tables</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="comment-tab" data-bs-toggle="tab" data-bs-target="#comment" type="button" role="tab">Comments</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="other-tab" data-bs-toggle="tab" data-bs-target="#other" type="button" role="tab">Other</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="badge-tab" data-bs-toggle="tab" data-bs-target="#badge" type="button" role="tab">Badge</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="result-comments-tab" data-bs-toggle="tab" data-bs-target="#result-comments" type="button" role="tab">Result Comments</button>
            </li>
          </ul>
          <form id="customizationForm">
            <div class="tab-content" id="customTabsContent">
              <div class="tab-pane fade show active" id="school" role="tabpanel">
                <div class="row g-3 mb-2">
                  <div class="col-md-6">
                    <label class="form-label">School Name</label>
                    <input type="text" class="form-control" name="school_name" placeholder="School Name">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">School Badge/Logo</label>
                    <input type="file" class="form-control" name="school_logo_file" accept="image/*">
                    <input type="hidden" name="school_logo" />
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">School Motto</label>
                    <input type="text" class="form-control" name="school_motto" placeholder="School Motto">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">School Contact</label>
                    <input type="text" class="form-control" name="school_contact" placeholder="School Contact">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">School Address</label>
                    <input type="text" class="form-control" name="school_address" placeholder="School Address">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">School Registration Number</label>
                    <input type="text" class="form-control" name="school_registration_number" placeholder="PPS/N/297">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">UNEB Center Number</label>
                    <input type="text" class="form-control" name="uneb_center_number" placeholder="080484">
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="banner" role="tabpanel">
                <div class="row g-3 mb-2">
                  <div class="col-md-6">
                    <label class="form-label">Banner1 BG</label>
                    <input type="color" class="form-control form-control-color" name="banner1_bgcolor" value="#0532ad">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Banner1 Text Color</label>
                    <input type="color" class="form-control form-control-color" name="banner1_textcolor" value="#ffffff">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Banner2 BG</label>
                    <input type="color" class="form-control form-control-color" name="banner2_bgcolor" value="#91908c">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Banner2 Text Color</label>
                    <input type="color" class="form-control form-control-color" name="banner2_textcolor" value="#000000">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Banner3 BG</label>
                    <input type="color" class="form-control form-control-color" name="banner3_bgcolor" value="#91908c">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Banner3 Text Color</label>
                    <input type="color" class="form-control form-control-color" name="banner3_textcolor" value="#000000">
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="table" role="tabpanel">
                <div class="row g-3 mb-2">
                  <div class="col-md-6">
                    <label class="form-label">Table Header BG</label>
                    <input type="color" class="form-control form-control-color" name="table_header_bg" value="#f0f8ff">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Table Border Color</label>
                    <input type="color" class="form-control form-control-color" name="table_border_color" value="#000000">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Table Font Size</label>
                    <input type="number" class="form-control" name="table_font_size" min="8" max="20" value="14">
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="comment" role="tabpanel">
                <div class="row g-3 mb-2">
                  <div class="col-md-6">
                    <label class="form-label">Class Teacher's Comment (Division 1)</label>
                    <select class="form-select" name="class_teacher_comment_div1" id="class_teacher_comment_div1">
                      <option value="Brilliant!! all my hopes are in you.">Brilliant!! all my hopes are in you.</option>
                      <option value="Outstanding Results, keep focused.">Outstanding Results, keep focused.</option>
                      <option value="Excellent Results, keep focused.">Excellent Results, keep focused.</option>
                      <option value="Very good performance, keep up.">Very good performance, keep up.</option>
                      <option value="Encouraging results, keep up">Encouraging results, keep up</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Class Teacher's Comment (Division 2)</label>
                    <select class="form-select" name="class_teacher_comment_div2" id="class_teacher_comment_div2">
                      <option value="Promising results, keep more focused.">Promising results, keep more focused.</option>
                      <option value="work harder for a first grade.">work harder for a first grade.</option>
                      <option value="I believe you can perform better than this.">I believe you can perform better than this.</option>
                      <option value="I expect a first grade out of you.">I expect a first grade out of you.</option>
                      <option value="I believe you can do better than this.">I believe you can do better than this.</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Class Teacher's Comment (Division 3)</label>
                    <select class="form-select" name="class_teacher_comment_div3" id="class_teacher_comment_div3">
                      <option value="Improve and make it to the next grade.">Improve and make it to the next grade.</option>
                      <option value="Create more time for revision.">Create more time for revision.</option>
                      <option value="Make very good use of the discussion groups.">Make very good use of the discussion groups.</option>
                      <option value="Consult your teachers more often.">Consult your teachers more often.</option>
                      <option value="Improve and make it to the higher level">Improve and make it to the higher level</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Class Teacher's Comment (Division 4)</label>
                    <select class="form-select" name="class_teacher_comment_div4" id="class_teacher_comment_div4">
                      <option value="You have to be very active in the discussion groups.">You have to be very active in the discussion groups.</option>
                      <option value="concentrate more on your books.">concentrate more on your books.</option>
                      <option value="Consult the teachers more often.">Consult the teachers more often.</option>
                      <option value="More effort is needed please.">More effort is needed please.</option>
                      <option value="Work harder please!!">Work harder please!!</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Class Teacher's Comment (Division U)</label>
                    <select class="form-select" name="class_teacher_comment_divU" id="class_teacher_comment_divU">
                      <option value="More concentration is needed from you in order to perform better.">More concentration is needed from you in order to perform better.</option>
                      <option value="Learn to always consult your friends and teachers.">Learn to always consult your friends and teachers.</option>
                      <option value="Make proper use of the discussion groups please.">Make proper use of the discussion groups please.</option>
                      <option value="You have to create more time for academic work please.">You have to create more time for academic work please.</option>
                      <option value="Work very hard please, you can make it to the next grade.">Work very hard please, you can make it to the next grade.</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Headteacher's Comment (Division 1)</label>
                    <select class="form-select" name="headteacher_comment_div1" id="headteacher_comment_div1">
                      <option value="Great work done, keep it up.">Great work done, keep it up.</option>
                      <option value="All our hopes are in you, dont relax.">All our hopes are in you, dont relax.</option>
                      <option value="Job well done, keep it up.">Job well done, keep it up.</option>
                      <option value="Excellent performance, keep it up.">Excellent performance, keep it up.</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Headteacher's Comment (Division 2)</label>
                    <select class="form-select" name="headteacher_comment_div2" id="headteacher_comment_div2">
                      <option value="You are a firstgrade material, keep more focused.">You are a firstgrade material, keep more focused.</option>
                      <option value="Quite remarkable performance, keep more focused.">Quite remarkable performance, keep more focused.</option>
                      <option value="Pretty good results, keep more focused.">Pretty good results, keep more focused.</option>
                      <option value="Quite good results, keep more focused.">Quite good results, keep more focused.</option>
                      <option value="Quite encouraging. keep more focused">Quite encouraging. keep more focused</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Headteacher's Comment (Division 3)</label>
                    <select class="form-select" name="headteacher_comment_div3"   id="headteacher_comment_div3">
                      <option value="You need to be active in discussions.">You need to be active in discussions.</option>
                      <option value="You are capable of doing better than doing this.">You are capable of doing better than doing this.</option>
                      <option value="More effort is needed from You.">More effort is needed from You.</option>
                      <option value="You area capable of doing better than this.">You area capable of doing better than this.</option>
                      <option value="Work harder for better grade.">Work harder for better grade.</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Headteacher's Comment (Division 4)</label>
                    <select class="form-select" name="headteacher_comment_div4" id="headteacher_comment_div4">
                      <option value="You are capable of Improving, just keep focused.">You are capable of Improving, just keep focused.</option>
                      <option value="Create more time for academic work.">Create more time for academic work.</option>
                      <option value="There is still room for improvement, never give up.">There is still room for improvement, never give up.</option>
                      <option value="Cultivate a positive attitude towards the teachers.">Cultivate a positive attitude towards the teachers.</option>
                      <option value="Develop a positive attitude towards learning">Develop a positive attitude towards learning</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Headteacher's Comment (Division U)</label>
                    <select class="form-select" name="headteacher_comment_divU" id="headteacher_comment_divU">
                      <option value="concentrate more on academics for a better performance.">concentrate more on academics for a better performance.</option>
                      <option value="Cultivate a positive attitude towards academics.">Cultivate a positive attitude towards academics.</option>
                      <option value="Don't lose hope,there is still room for improvement.">Don't lose hope,there is still room for improvement.</option>
                      <option value="Don't relax, you can still make it to the next level">Don't relax, you can still make it to the next level</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="other" role="tabpanel">
                <div class="row g-3 mb-2">
                  <div class="col-md-6">
                    <label class="form-label">Student Label Color</label>
                    <input type="color" class="form-control form-control-color" name="student_label_color" value="#000000">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Student Value Color</label>
                    <input type="color" class="form-control form-control-color" name="student_value_color" value="#0066cc">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Show Barcode</label>
                    <select class="form-select" name="show_barcode">
                      <option value="yes">Yes</option>
                      <option value="no">No</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Barcode Width</label>
                    <input type="number" class="form-control" name="barcode_width" min="30" max="200" value="90">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Barcode Height</label>
                    <input type="number" class="form-control" name="barcode_height" min="10" max="100" value="30">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Page Font Family</label>
                    <select class="form-select" name="page_font_family">
                      <option value="'Segoe UI', sans-serif">Segoe UI</option>
                      <option value="'Arial', sans-serif">Arial</option>
                      <option value="'Roboto', sans-serif">Roboto</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Page Font Size</label>
                    <input type="number" class="form-control" name="page_font_size" min="8" max="30" value="14">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Page Background Color</label>
                    <input type="color" class="form-control form-control-color" name="page_background_color" value="#ffffff">
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="badge" role="tabpanel">
                <div class="row g-3 mb-2">
                  <div class="col-md-6">
                    <label class="form-label">Badge Size</label>
                    <select class="form-select" name="badge_size">
                      <option value="small">Small (50px)</option>
                      <option value="medium" selected>Medium (150px)</option>
                      <option value="large">Large (300px)</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="result-comments" role="tabpanel">
                <div class="row g-3 mb-2">
                  <div class="col-md-6">
                    <label class="form-label">Comment for Grade D1</label>
                    <select class="form-select" name="result_comment_d1" id="result_comment_d1">
                      <option value="Excellent results, keep it up.">Excellent results, keep it up.</option>
                      <option value="Very encouraging results, Donot relax.">Very encouraging results, Donot relax.</option>
                      <option value="Great work done, keep engaging.">Great work done, keep engaging.</option>
                      <option value="Well done good learner, keep focused.">Well done good learner, keep focused.</option>
                      <option value="Excellent, all hopes are in you.">Excellent, all hopes are in you.</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Comment for Grade D2</label>
                    <select class="form-select" name="result_comment_d2" id="result_comment_d2">
                      <option value="Very good score, but aim at excellency.">Very good score, but aim at excellency.</option>
                      <option value="This is encouraging, though you should push for D1.">This is encouraging, though you should push for D1.</option>
                      <option value="Very good results, though you can do better than this.">Very good results, though you can do better than this.</option>
                      <option value="Thank you for the good work done, however, keep more focused.">Thank you for the good work done, however, keep more focused.</option>
                      <option value="Encouraging results, but you can improve on them next time.">Encouraging results, but you can improve on them next time.</option>
                    </select>
                  </div>
                </div>
              </div>
            </div>
            <div class="modal-footer mt-3">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" class="btn btn-primary" id="apply-button">Apply</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
  <script>
    
    // Global utility function - Remove duplicate subjects for learners
    function uniqueBySubject(arr) {
      const seen = new Set();
      return arr.filter(r => {
        const subj = (r.subject || '').toLowerCase();
        if (seen.has(subj)) return false;
        seen.add(subj);
        return true;
      });
    }
    
    // Calculate next term begins date (always a Monday) - Copied from Next.js
    function getNextTermBeginsDate(currentTerm, currentYear) {
      const year = typeof currentYear === 'string' ? parseInt(currentYear) : currentYear;
      const termLower = currentTerm.toLowerCase();
      
      // Helper function to find first Monday in a date range
      const findFirstMonday = (startDate) => {
        const date = new Date(startDate);
        // If not Monday (1), move to next Monday
        const dayOfWeek = date.getDay();
        if (dayOfWeek !== 1) {
          const daysUntilMonday = dayOfWeek === 0 ? 1 : (8 - dayOfWeek);
          date.setDate(date.getDate() + daysUntilMonday);
        }
        return date;
      };
      
      // Format date as DD/MM/YYYY
      const formatDate = (date) => {
        const day = String(date.getDate()).padStart(2, '0');
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const year = date.getFullYear();
        return `${day}/${month}/${year}`;
      };
      
      if (termLower.includes('term 1') || termLower.includes('term1') || termLower.includes('termi')) {
        // Term 1 → Next term begins mid May (May 10-20)
        const targetDate = new Date(year, 4, 10); // May 10
        return formatDate(findFirstMonday(targetDate));
      } else if (termLower.includes('term 2') || termLower.includes('term2') || termLower.includes('termii')) {
        // Term 2 → Next term begins late August (August 10-25)
        const targetDate = new Date(year, 7, 10); // August 10
        return formatDate(findFirstMonday(targetDate));
      } else if (termLower.includes('term 3') || termLower.includes('term3') || termLower.includes('termiii')) {
        // Term 3 → Next term begins early February next year (February 1-10)
        const targetDate = new Date(year + 1, 1, 1); // February 1 next year
        return formatDate(findFirstMonday(targetDate));
      }
      
      // Default fallback
      return '';
    }
    
    const applyButton = document.getElementById('apply-button');

    // Enhanced barcode generation function using PHP API
    async function generateBarcode(elementId, value, options = {}) {
      try {
        const element = document.getElementById(elementId);
        if (!element) {
          console.warn(`Barcode element with ID '${elementId}' not found`);
          return false;
        }

        // Generate barcode using PHP API with correct parameters
        const response = await fetch(`http://localhost/drais/api/barcode.php?text=${encodeURIComponent(value)}&type=png&size=2&height=40`);
        
        if (!response.ok) {
          throw new Error(`Barcode API returned ${response.status}`);
        }

        // Get the barcode as blob and create object URL
        const blob = await response.blob();
        const imageUrl = URL.createObjectURL(blob);

        // Replace SVG with IMG element
        const img = document.createElement('img');
        img.src = imageUrl;
        img.className = 'barcode-img';
        img.style.width = '110px';
        img.style.height = '50px';
        img.style.marginRight = '-30px';
        img.style.marginLeft = '-20px';
        img.style.transform = 'rotate(270deg)';
        img.style.transformOrigin = 'center center';
        img.alt = `Barcode: ${value}`;
        
        // Replace the SVG element with IMG
        element.parentNode.replaceChild(img, element);

        console.log(`PHP Barcode generated successfully for student ID: ${value}`);
        return true;
      } catch (error) {
        console.error('PHP Barcode generation failed:', error);
        
        // Fallback: create a simple text representation
        const element = document.getElementById(elementId);
        if (element) {
          element.innerHTML = `
            <svg viewBox="0 0 -60 50" style="width: 110px; height: 30px;">
              <!-- Barcode-like black lines -->
              <rect x="5" y="5" width="2" height="40" fill="black"/>
              <rect x="9" y="5" width="1" height="40" fill="black"/>
              <rect x="12" y="5" width="3" height="40" fill="black"/>
              <rect x="17" y="5" width="1" height="40" fill="black"/>
              <rect x="20" y="5" width="2" height="40" fill="black"/>
              <rect x="24" y="5" width="1" height="40" fill="black"/>
              <rect x="27" y="5" width="4" height="40" fill="black"/>
              <rect x="33" y="5" width="1" height="40" fill="black"/>
              <rect x="36" y="5" width="2" height="40" fill="black"/>
              <rect x="40" y="5" width="1" height="40" fill="black"/>
              <rect x="43" y="5" width="3" height="40" fill="black"/>
              <rect x="48" y="5" width="1" height="40" fill="black"/>
              <rect x="51" y="5" width="2" height="40" fill="black"/>
              <rect x="55" y="5" width="4" height="40" fill="black"/>
              <rect x="61" y="5" width="1" height="40" fill="black"/>
              <rect x="64" y="5" width="2" height="40" fill="black"/>
              <rect x="68" y="5" width="1" height="40" fill="black"/>
              <rect x="71" y="5" width="3" height="40" fill="black"/>
              <rect x="76" y="5" width="1" height="40" fill="black"/>
              <rect x="79" y="5" width="2" height="40" fill="black"/>
              <rect x="83" y="5" width="1" height="40" fill="black"/>
              <rect x="86" y="5" width="4" height="40" fill="black"/>
              <rect x="92" y="5" width="1" height="40" fill="black"/>
              <rect x="95" y="5" width="2" height="40" fill="black"/>
              <rect x="99" y="5" width="1" height="40" fill="black"/>
              <rect x="102" y="5" width="3" height="40" fill="black"/>
              </svg>
              `;
              // <text x="55" y="52" text-anchor="middle" font-family="monospace" font-size="8" fill="#666">${value}</text>
        }
        return false;
      }
    }

    // Batch generate all barcodes using PHP API
    function generateAllBarcodes() {
      const barcodeElements = document.querySelectorAll('.barcode-svg');
      let successCount = 0;
      
      // Process barcodes sequentially to avoid overwhelming the API
      const processBarcodes = async () => {
        for (const element of barcodeElements) {
          const studentId = element.dataset.studentId;
          
          if (studentId) {
            try {
              const success = await generateBarcode(element.id, studentId);
              if (success) successCount++;
              
              // Small delay between requests to prevent server overload
              await new Promise(resolve => setTimeout(resolve, 100));
            } catch (error) {
              console.error(`Failed to generate barcode for ${studentId}:`, error);
            }
          }
        }
        
        console.log(`Generated ${successCount} of ${barcodeElements.length} PHP barcodes`);
        return successCount;
      };

      return processBarcodes();
    }

    // Wait for fonts and layout to be ready before generating barcodes
    function initializeBarcodes() {
      // Use requestAnimationFrame to ensure DOM is fully rendered
      requestAnimationFrame(() => {
        setTimeout(async () => {
          const generatedCount = await generateAllBarcodes();
          
          if (generatedCount === 0) {
            // Retry after a short delay if no barcodes were generated
            setTimeout(async () => {
              console.log('Retrying PHP barcode generation...');
              await generateAllBarcodes();
            }, 1000);
          }
        }, 500); // Allow time for report rendering
      });
    }

    async function fetchFilters() {
      // Fetch classes and result types from new endpoints
      const [classRes, resultTypeRes] = await Promise.all([
        fetch('../../api/reports/classes.php'),
        fetch('../../api/reports/result_types.php')
      ]);
      const classData = await classRes.json();
      const resultTypeData = await resultTypeRes.json();
      const classes = classData.classes || [];
      const resultTypes = resultTypeData.result_types || [];
      // Populate dropdowns
      const termSel = document.getElementById('filter-term');
      termSel.innerHTML = '<option value="">All Terms</option>';
      ['Term 1', 'Term 2', 'Term 3'].forEach(t => { const opt = document.createElement('option'); opt.value = t; opt.textContent = t; termSel.appendChild(opt); });
      const typeSel = document.getElementById('filter-result-type');
      typeSel.innerHTML = '<option value="">All Result Types</option>';
      resultTypes.forEach(t => { const opt = document.createElement('option'); opt.value = t; opt.textContent = t; typeSel.appendChild(opt); });
      const classSel = document.getElementById('filter-class');
      classSel.innerHTML = '<option value="">All Classes</option>';
      classes.forEach(c => { const opt = document.createElement('option'); opt.value = c.id; opt.textContent = c.name; classSel.appendChild(opt); });
    }

    async function fetchReports(filters = {}) {
      let data = {};
      try {
        const params = new URLSearchParams(filters).toString();
        // Use the enhanced PHP endpoint that matches the NextJS API structure
        const res = await fetch('../../api/reports/list.php' + (params ? '?' + params : ''));
        data = await res.json();
        
        // The PHP endpoint now returns data in the exact format expected
        if (!data.success) {
          console.error('API Error:', data.message);
          data = { students: [], results: [], customization: {} };
        }
      } catch (e) {
        console.error('Error fetching reports:', e);
        data = { students: [], results: [], customization: {} };
      }
      
      data.students = data.students || [];
      data.results = data.results || [];
      data.customization = data.customization || {};
      return data;
    }

    function groupResultsByStudent(students, results) {
      // Attach results and other_subjects to each student
      const studentMap = {};
      students.forEach(s => {
        s.results = [];
        s.other_subjects = [];
        studentMap[s.student_id] = s;
      });
      results.forEach(r => {
        const s = studentMap[r.student_id];
        if (!s) return;
        if (r.subject_type && r.subject_type.toLowerCase() === 'core') {
          s.results.push(r);
        } else {
          s.other_subjects.push(r);
        }
      });
      // Set term and year from first result if available
      students.forEach(s => {
        if (!s.term && s.results.length > 0) s.term = s.results[0].term || '';
        if (!s.year && s.results.length > 0) s.year = s.results[0].year || '';
      });
      // Only return students with results
      return students.filter(s => s.results.length > 0);
    }

    function getCustomization(opt, def) {
      if (window.reportCustomization && window.reportCustomization[opt]) return window.reportCustomization[opt];
      return def;
    }

    function applyStyle(el, styles) {
      if (!el || !styles) return;
      Object.entries(styles).forEach(([key,val]) => {
        if(val !== undefined && val !== null) el.style[key] = val;
      });
    }

    // Helper for fallback chain: returns first non-empty string
    function getFallback(...args) {
      for (const v of args) {
        if (typeof v === 'string' && v.trim() !== '') return v;
      }
      return '';
    }

    function commentsSection(student) {
      // Ensure customization is applied correctly for comments and school info
      const ribbonBg = getCustomization('comment_ribbon_bg', 'rgb(145, 140, 140)');
      const ribbonTextColor = getCustomization('comment_ribbon_text_color', '#000000');
      const commentTextColor = getCustomization('comment_text_color', '#1a4be7');
      const commentFontStyle = getCustomization('comment_text_font_style', 'italic');
      const commentDecoration = getCustomization('comment_text_decoration', 'underline dashed');
      const reportDate = (student.report_date && student.report_date.trim()) ? student.report_date : getCustomization('default_report_date', '15-SEPT-2025');
      const classTeacherComment = (student.class_teacher_comment && student.class_teacher_comment.trim()) ? student.class_teacher_comment : getCustomization('default_class_teacher_comment', 'Class teacher comment');
      const dosComment = (student.dos_comment && student.dos_comment.trim()) ? student.dos_comment : getCustomization('default_dos_comment', 'DOS comment');
      const headteacherComment = (student.headteacher_comment && student.headteacher_comment.trim()) ? student.headteacher_comment : getCustomization('default_headteacher_comment', 'Headteacher comment');
      // Inline style string for comment text:
      const commentTextStyle = `
        color: ${commentTextColor};
        font-style: ${commentFontStyle};
        border-bottom: 1.5px dashed ${commentTextColor};
        text-decoration: none;
        display: inline;
      `;
      // SVG ribbon generator to avoid CSS conflicts
      const renderRibbonSVG = (label, bg, width = 208, height = 28) => {
        const arrowW = 18;
        const bodyW = width - arrowW;
        const textX = 10;
        const textY = Math.round(height / 2 + 5);
        return `
          <svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${height}" viewBox="0 0 ${width} ${height}" style="vertical-align:middle;margin-right:12px;">
            <defs>
              <clipPath id="ribbon-clip">
                <path d="M0 0 H ${bodyW} L ${width} ${height/2} L ${bodyW} ${height} H 0 Z" />
              </clipPath>
            </defs>
            <path d="M0 0 H ${bodyW} L ${width} ${height/2} L ${bodyW} ${height} H 0 Z" fill="${bg}" />
            <text x="${textX}" y="${textY}" fill="#000" font-size="14" font-weight="700" font-family="Segoe UI, Arial">${label}</text>
          </svg>
        `;
      };

      // Using data attributes for CSS ::after via style tag is tricky, so fallback with <span> and inline SVG/triangle
      // Instead, use <span> for ribbon with inline style and a small triangle after.

      return `
      <div class="bottom-ribbon" style="margin-top:1%;">
        Comments/Remarks
        <div class="comments-content" style="margin-top:2px;">
          <div style="margin-bottom:10px; width:100%; display:flex; align-items:center; gap:6px;">
            ${renderRibbonSVG("Class Teacher's Comment:", ribbonBg)}
            <span style="${commentTextStyle}; margin-bottom:0px;padding:0px;border-bottom:2px dashed black;" class="class-teacher-comment">${classTeacherComment}</span>
          </div>
          <div style="margin-bottom:10px; display:flex; align-items:center; gap:6px;">
            ${renderRibbonSVG("DOS Comment:", ribbonBg)}
            <span style="${commentTextStyle}; margin-bottom:0px;padding:0px;border-bottom:2px dashed black;" class="dos-comment">${dosComment}</span>
          </div>
          <div style="margin-bottom:10px; display:flex; align-items:center; gap:6px;">
            ${renderRibbonSVG("Headteacher's Comment:", ribbonBg)}
            <span style="${commentTextStyle} margin-bottom:0px;padding:0px;border-bottom:2px dashed black;" class="headteacher-comment">${headteacherComment}</span>
          </div>
          
          <!-- Combined Promotion Status and Next Term - Single Line -->
          <div style="margin-top: 12px; display: flex; align-items: center; gap: 20px; flex-wrap: wrap;">
            <div style="text-decoration: underline dashed; color: #1d1717ff; font-weight: 500;">Next Term Begins: ${getNextTermBeginsDate(student.term || '', student.year || new Date().getFullYear())}</div>
            <div id="promotion-container-${student.student_id}" data-student-id="${student.student_id}" style="display: inline-flex; align-items: center;"></div>
          </div>
          </div>
          </div>`;
        }

    function getGrade(score) {
      score = Number(score);
      if (score >= 90) return 'D1';
      if (score >= 80) return 'D2';
      if (score >= 70) return 'C3';
      if (score >= 60) return 'C4';
      if (score >= 55) return 'C5';
      if (score >= 50) return 'C6';
      if (score >= 40) return 'P8';
      return 'F9';
    }
    function getGradePoint(grade) {
      switch (grade) {
        case 'D1': return 1;
        case 'D2': return 2;
        case 'C3': return 3;
        case 'C4': return 4;
        case 'C5': return 5;
        case 'C6': return 6;
        case 'P8': return 8;
        case 'F9': return 9;
        default: return 9;
      }
    }
    function getDivision(aggregates) {
      if (aggregates >= 4 && aggregates <= 12) return 'Division 1';
      if (aggregates >= 13 && aggregates <= 24) return 'Division 2';
      if (aggregates >= 25 && aggregates <= 28) return 'Division 3';
      if (aggregates >= 29 && aggregates <= 32) return 'Division 4';
      return 'Division U';
    }

    // ==================== PROMOTION ENGINE ====================
    
    // Class normalization mapping (PHP equivalent of TypeScript version)
    const CLASS_ALIASES = {
      // Nursery Classes
      'baby': 'baby',
      'baby class': 'baby',
      'b.class': 'baby',
      'b class': 'baby',
      
      'middle': 'middle',
      'middle class': 'middle',
      'mid class': 'middle',
      'm.class': 'middle',
      'm class': 'middle',
      
      'top': 'top',
      'top class': 'top',
      't.class': 'top',
      't class': 'top',
      
      // Primary Classes
      'p1': 'p1',
      'p.1': 'p1',
      'primary 1': 'p1',
      'primary one': 'p1',
      'primary1': 'p1',
      'one': 'p1',
      '1': 'p1',
      
      'p2': 'p2',
      'p.2': 'p2',
      'primary 2': 'p2',
      'primary two': 'p2',
      'primary2': 'p2',
      'two': 'p2',
      '2': 'p2',
      
      'p3': 'p3',
      'p.3': 'p3',
      'primary 3': 'p3',
      'primary three': 'p3',
      'primary3': 'p3',
      'three': 'p3',
      '3': 'p3',
      
      'p4': 'p4',
      'p.4': 'p4',
      'primary 4': 'p4',
      'primary four': 'p4',
      'primary4': 'p4',
      'four': 'p4',
      '4': 'p4',
      
      'p5': 'p5',
      'p.5': 'p5',
      'primary 5': 'p5',
      'primary five': 'p5',
      'primary5': 'p5',
      'five': 'p5',
      '5': 'p5',
      
      'p6': 'p6',
      'p.6': 'p6',
      'primary 6': 'p6',
      'primary six': 'p6',
      'primary6': 'p6',
      'six': 'p6',
      '6': 'p6',
      
      'p7': 'p7',
      'p.7': 'p7',
      'primary 7': 'p7',
      'primary seven': 'p7',
      'primary7': 'p7',
      'seven': 'p7',
      '7': 'p7'
    };

    function normalizeClassName(className) {
      if (!className || typeof className !== 'string') return 'unknown';
      
      let normalized = className.toLowerCase().trim();
      normalized = normalized.replace(/\s+/g, ' '); // Multiple spaces to single
      normalized = normalized.replace(/[.,;:!?]+$/g, ''); // Remove trailing punctuation
      
      return CLASS_ALIASES[normalized] || 'unknown';
    }

    function getNextClassName(currentClass) {
      const normalized = normalizeClassName(currentClass);
      
      const nextClassMap = {
        'baby': 'Middle Class',
        'middle': 'Top Class',
        'top': 'Primary 1',
        'p1': 'Primary 2',
        'p2': 'Primary 3',
        'p3': 'Primary 4',
        'p4': 'Primary 5',
        'p5': 'Primary 6',
        'p6': 'Primary 7',
        'p7': 'Senior 1'
      };
      
      return nextClassMap[normalized] || 'Next Class';
    }

    function getClassLevel(normalizedClass) {
      if (['baby', 'middle', 'top'].includes(normalizedClass)) {
        return 'nursery';
      } else if (['p1', 'p2', 'p3'].includes(normalizedClass)) {
        return 'primary_lower';
      } else if (['p4', 'p5', 'p6'].includes(normalizedClass)) {
        return 'primary_upper';
      } else if (['p7'].includes(normalizedClass)) {
        return 'primary_seven';
      } else if (['s1', 's2', 's3', 's4', 's5', 's6'].includes(normalizedClass)) {
        return 'senior';
      }
      return 'unknown';
    }

    function applyDefaultPromotionLogic(classLevel, normalizedClass, averageMarks, nextClass) {
      let status = 'promoted';
      let text = '';
      
      if (classLevel === 'nursery' || classLevel === 'primary_lower') {
        // Nursery to P3: Simple logic
        if (averageMarks >= 50) {
          status = 'promoted';
          text = `Promoted to ${nextClass}`;
        } else {
          status = 'repeat';
          text = `Advised to Repeat`;
        }
      } else if (classLevel === 'primary_upper') {
        // P4 to P6: Advanced logic with probation
        const promotionThreshold = 50;
        
        if (averageMarks >= promotionThreshold + 10) {
          status = 'promoted';
          text = `Promoted to ${nextClass}`;
        } else if (averageMarks >= promotionThreshold) {
          status = 'probation';
          text = `Promoted on Probation to ${nextClass}`;
        } else {
          status = 'repeat';
          text = `Advised to Repeat`;
        }
      } else {
        // Unknown or Senior: Default to promoted
        status = 'promoted';
        text = `Promoted to ${nextClass}`;
      }
      
      return {
        'status': status,
        'text': text,
        'ruleSource': 'default',
        'debugInfo': {
          'normalizedClass': normalizedClass,
          'classLevel': classLevel,
          'criteriaFound': false
        }
      };
    }

    function calculatePromotionStatus(student, totalMarks, averageMarks, division) {
      const normalizedClass = normalizeClassName(student.class_name || '');
      const classLevel = getClassLevel(normalizedClass);
      const nextClass = getNextClassName(student.class_name || '');
      
      // For now, use default promotion logic
      // In future, this can be extended to check for custom promotion settings
      return applyDefaultPromotionLogic(classLevel, normalizedClass, averageMarks, nextClass);
    }

    // ==================== SUBJECT GROUPING ====================
    
    function separateSubjects(student) {
      if (!student.results) {
        student.results = [];
        student.other_subjects = [];
        return;
      }
      
      const principalSubjects = [];
      const otherSubjects = [];
      
      // Remove duplicates first
      const uniqueResults = uniqueBySubject(student.results);
      
      // Separate subjects based on subject_type or default logic
      uniqueResults.forEach(result => {
        if (result.subject_type && result.subject_type.toLowerCase() === 'other') {
          otherSubjects.push(result);
        } else {
          // Default to principal subjects
          principalSubjects.push(result);
        }
      });
      
      // Update student object
      student.results = principalSubjects;
      student.other_subjects = otherSubjects;
      
      // Ensure other_subjects exists even if empty
      if (!student.other_subjects) {
        student.other_subjects = [];
      }
    }

    function gradeTable() {
      return `<div class="grade-table">
        <table>
          <tr><td>GRADE</td><td>D1</td><td>D2</td><td>C3</td><td>C4</td><td>C5</td><td>C6</td><td>P7</td><td>P8</td><td>F9</td></tr>
          <tr><td>SCORE RANGE</td><td>90–100</td><td>80–89</td><td>70–79</td><td>60–69</td><td>55–59</td><td>50–54</td><td>49-44</td><td>40–44</td><td>0–39</td></tr>
        </table>
      </div>`;
    }

    // Enhanced position calculation function with proper sorting and ranking based on average marks
    function calculatePositions(students) {
      // Group students by class_name for class positions
      const classGroups = {};
      students.forEach(student => {
        const className = (student.class_name || '').trim().toLowerCase();
        if (!classGroups[className]) classGroups[className] = [];
        classGroups[className].push(student);
      });

      // Process each class separately
      Object.values(classGroups).forEach(classStudents => {
        // Calculate averages for each student
        classStudents.forEach(student => {
          if (student.results && student.results.length > 0) {
            const totalMarks = student.results.reduce((sum, r) => sum + (parseFloat(r.score) || 0), 0);
            const subjectCount = student.results.length;
            student.calculatedAverage = totalMarks / subjectCount;
            student.displayAverage = student.calculatedAverage;
          } else {
            student.calculatedAverage = 0;
            student.displayAverage = 0;
          }
          
          // Calculate positions properly
          // For now, keep positions empty as per the user's request not to touch filtering/positioning
          student.class_position = '';
          student.stream_position = '';
        });

        // Sort by average marks (descending) for proper ranking, then by name for consistent display
        classStudents.sort((a, b) => {
          // Primary sort: by average marks (highest first)
          const avgDiff = (b.calculatedAverage || 0) - (a.calculatedAverage || 0);
          if (avgDiff !== 0) return avgDiff;
          
          // Secondary sort: by name for consistency when averages are equal
          const nameA = `${a.firstname || ''} ${a.lastname || ''}`.trim();
          const nameB = `${b.firstname || ''} ${b.lastname || ''}`.trim();
          return nameA.localeCompare(nameB);
        });
        
        // Note: Position calculation is kept disabled as per user requirements
      });

      // Sort all students globally for display order (by class then by performance within class)
      students.sort((a, b) => {
        // Primary sort: by class name
        const classCompare = (a.class_name || '').localeCompare(b.class_name || '');
        if (classCompare !== 0) return classCompare;
        
        // Secondary sort: by average marks (highest first) within the same class
        const avgDiff = (b.calculatedAverage || 0) - (a.calculatedAverage || 0);
        if (avgDiff !== 0) return avgDiff;
        
        // Tertiary sort: by name for consistency
        const nameA = `${a.firstname || ''} ${a.lastname || ''}`.trim();
        const nameB = `${b.firstname || ''} ${b.lastname || ''}`.trim();
        return nameA.localeCompare(nameB);
      });

      // Apply subject grouping to separate principal and other subjects
      students.forEach(student => {
        separateSubjects(student);
      });
    }

    function getTeacherInitials(subject, className) {
      const subj = (subject || '').toLowerCase();
      const cls = (className || '').toLowerCase();
      let map = {};
      
      // Nursery classes
      if (cls === "baby class") {
        map = {
          "english": "NAMUKUVE DERIRA",
          "language development i": "NAMUKUVE DERIRA",
          "language development ii": "MUTUNDA SUSAN",
          "social studies": "NAMUKUVE DERIRA",
          "social development ": "NAMUKUVE DERIRA",
          "mathematics": "MIREMBE RESTY",
          "numbers": "MIREMBE RESTY",
          "health habits": "MIREMBE RESTY"
        };
      } else if (cls === "middle class") {
        map = {
          "english": "NAMUKUVE DERIRA",
          "language development i": "KITIMBO FLORENCE",
          "language development ii": "MUTUNDA SUSAN",
          "social studies": "NAMUKUVE DERIRA",
          "social development ": "NAMUKUVE DERIRA",
          "mathematics": "MIREMBE RESTY",
          "numbers": "MIREMBE RESTY",
          "health habits": "KITIMBO FLORENCE"
        };
      } else if (cls === "top class") {
        map = {
          "english": "NAMUKUVE DERIRA",
          "language development i": "KITIMBO FLORENCE",
          "language development ii": "MUTUNDA SUSAN",
          "social studies": "NAMUKUVE DERIRA",
          "social development": "NAMUKUVE DERIRA",
          "mathematics": "MIREMBE RESTY",
          "numbers": "MIREMBE RESTY",
          "health habits": "MIREMBE RESTY"
        };
      } 
      // Primary classes P1–P7
      else if (cls === "primary seven") {
        map = {
          "social studies": "EPENYU ABRAHAM",
          "science": "EKARU SYLUS",
          "mathematics": "EKARU EMANUEL",
          "english": "EMERU JOEL",
          "literacy ii": "AWOR TOPISTA",
          "language development": "NAMUKUVE DERIRA",
          "health habits": "MIREMBE RESTY"
        };
      } else if (cls === "primary six") {
        map = {
          "social studies":"EPENYU ABRAHAM",
          "mathematics": "EGAU GERALD",
          "science": "EKARU SYLUS",
          "english": "EMERU JOEL"
        };
      } else if (cls === "primary five") {
        map = {
          "social studies": "EWAYU LUKE",
          "mathematics": "EGAU GERALD",
          "science": "EKARU SYLUS",
          "english": "AWOR TOPISTA",
          "literacy ii": "AWOR TOPISTA"
        };
      } else if (cls === "primary four") {
        map = {
          "social studies": "EWAYU LUKE",
          "science": "EGAU GERALD",
          "english": "EMERU JOEL",
          "mathematics": "IKOMERA CHRISTINE",
          "literacy i": "IKOMERA CHRISTINE",
          "religious education": "IKOMERA CHRISTINE"
        };
      } else if (cls === "primary three") {
        map = {
          "mathematics": "EKARU SYLUS",
          "science": "EKARU SYLUS",
          "religious education": "BISATIBIWA JOSEPH",
          "literacy i": "BISATIBIWA JOSEPH",
          "english": "NAIGAGA ANNET",
          "literacy ii": "NAIGAGA ANNET"
        };
      } else if (cls === "primary two") {
        map = {
          "english": "AWOR TOPISTA",
          "literacy ii": "AWOR TOPISTA",
          "literacy i": "IKOMERA CHRISTINE",
          "religious education": "AWOR TOPISTA",
          "mathematics": "MIREMBE RESTY",
          "science": "MIREMBE RESTY"
        };
      } else if (cls === "primary one") {
        map = {
          "literacy i": "IKOMERA CHRISTINE",
          "literacy ii": "KITIMBO FLORENCE",
          "religious education": "AWOR TOPISTA",
          "mathematics": "MIREMBE RESTY",
          "english": "KITIMBO FLORENCE"
        };
      } 
      // Default for any unmapped class/subject
      else {
        map = {
          "social studies": "KITI MOSES",
          "science": "KITI MOSES",
          "mathematics": "EKARU EMANUEL",
          "english": "KITI MOSES",
          "literacy ii": "KITI MOSES",
          "literacy i": "KITI MOSES",
          "numbers": "MIREMBE RESTY",
          "language development i": "NAMUKUVE DERIRA",
          "language development ii": "MUTUNDA SUSAN",
          "health habits": "MIREMBE RESTY",
          "religious education": "KITI MOSES"
        };
      }
      
      // Get teacher for subject or default
      const teacher = map[subj] || "KITI MOSES";
      
      // Return initials
      return teacher.split(' ').map(n => n[0]).join('');
    }

    function renderReport(student) {
      // Validate student data and provide defaults
      if (!student) {
        console.error('No student data provided to renderReport');
        return '<div>Error: No student data available</div>';
      }
      
      // Ensure required fields exist with defaults
      student.firstname = student.firstname || '';
      student.lastname = student.lastname || '';
      student.othername = student.othername || '';
      student.class_name = student.class_name || 'Unknown Class';
      student.stream_name = student.stream_name || 'A';
      student.term = student.term || 'Term I';
      student.year = student.year || new Date().getFullYear();
      student.results = student.results || [];
      student.other_subjects = student.other_subjects || [];
      
      // Customization keys mapping to your CSS classes
      const customization = window.reportCustomization || {};

      // SCHOOL INFO
      const schoolName = getCustomization('school_name', 'NORTHGATE SCHOOL');
      const schoolEmail = getCustomization('school_email', 'northgateschooluganda@gmail.com');
      const schoolContact = getCustomization('school_contact', 'Tel: 0706416264, 0782583278');
      const schoolAddress = getCustomization('school_address', 'IGANGA, Bulubandi Central B');
      const schoolMotto = getCustomization('school_motto', '');
      const schoolUNEBCenterNo = getCustomization('school_uneb_center_no', 'UNEB CENTRE No: 080484');
      const schoolReg = getCustomization('school_registration_no', 'Reg no: MOES/ECD/510/2020/001');
      const schoolRegPrimary = getCustomization('school_registration_no', 'PPS/N/297');
      const schoolLogo = getCustomization('school_logo', '/public/assets/images/logo.jpg');

      // Styles for school name and motto from customization
      const schoolNameFont = getCustomization('school_name_font', '"bernard mt condensed"');
      const schoolNameColor = getCustomization('school_name_color', 'rgb(5, 48, 165)');
      const schoolMottoFont = getCustomization('school_motto_font', '"times new roman"');
      const schoolMottoColor = getCustomization('school_motto_color', '#000'); // default black if you want customizable

      // BANNERS (using first, second, third banner terminology)
      const firstBannerText = getCustomization('banner1_text', `${student.term ? student.term.toUpperCase() : 'MID TERM'} REPORT`);
      const firstBannerBg = getCustomization('banner1_bgcolor', 'rgb(5, 50, 173)');
      const firstBannerColor = getCustomization('banner1_textcolor', '#fff');

      const secondBannerText = getCustomization('banner2_text', 'Principal Subjects Comprising the General Assessment');
      const secondBannerBg = getCustomization('banner2_bgcolor', 'rgb(145, 140, 140)');
      const secondBannerColor = getCustomization('banner2_textcolor', '#000');

      const thirdBannerText = getCustomization('banner3_text', 'Other Subjects (Not part of Assessment)');
      const thirdBannerBg = getCustomization('banner3_bgcolor', 'rgb(145, 140, 140)');
      const thirdBannerColor = getCustomization('banner3_textcolor', '#000');

      // Table header and border customization
      const tableHeaderBg = getCustomization('table_header_bg', '#f0f8ff');
      const tableBorderColor = getCustomization('table_border_color', 'black');
      const tableFontSize = getCustomization('table_font_size', 14);

      // Prepare inline styles for banners and tables
      const firstBannerStyle = `background-color: ${firstBannerBg}; color: ${firstBannerColor};`;
      const secondBannerStyle = `background-color: ${secondBannerBg}; color: ${secondBannerColor};`;
      const thirdBannerStyle = `background-color: ${thirdBannerBg}; color: ${thirdBannerColor};`;
      const tableHeaderStyle = `background: ${tableHeaderBg}; border: 1px solid ${tableBorderColor}; font-size: ${tableFontSize}px;`;
      const tableCellStyle = `border: 1px solid ${tableBorderColor}; font-size: ${tableFontSize}px;`;
      const commentCellStyle = `border: 1px solid ${tableBorderColor}; font-size: ${Math.floor(tableFontSize * 1.2)}px; font-weight: 500;`;

      // Student Info Colors - Updated default to blue
      const studentLabelColor = getCustomization('student_label_color', '#000');
      const studentValueColor = getCustomization('student_value_color', '#0066cc'); // Changed from '#d61515ff' to blue

      // Nursery class check (case-insensitive)
      const nurseryClasses = ["baby class", "middle class", "top class"];
      const isNursery = nurseryClasses.includes((student.class_name || '').trim().toLowerCase());

      // Use the global uniqueBySubject function
      student.results = uniqueBySubject(student.results || []);
      student.other_subjects = uniqueBySubject(student.other_subjects || []);

      // EOT column header abbreviation
      const eotHeader = student.results.length > 0 && student.results[0].results_type ? student.results[0].results_type.split(' ').map(w => w[0]).join('').toUpperCase() : 'EOT';

      // Use the calculated average for display instead of recalculating
      const totalMarks = student.results.reduce((sum, r) => sum + Math.floor(r.score || 0), 0);
      const averageMarks = student.displayAverage ? student.displayAverage.toFixed(2) : '0.00';
      
      // Calculate promotion status with error handling
      let promotionResult = { status: 'none', text: '', ruleSource: 'default' };
      try {
        const aggregates = student.results.reduce((sum, r) => sum + getGradePoint(getGrade(r.score || 0)), 0);
        const division = getDivision(aggregates);
        promotionResult = calculatePromotionStatus(student, totalMarks, parseFloat(averageMarks), division);
      } catch (error) {
        console.warn('Error calculating promotion status:', error);
        promotionResult = { status: 'none', text: '', ruleSource: 'error' };
      }
      
      // Format promotion status for display
      const promotionStatusHtml = promotionResult.status !== 'none' ? `
        <div class="promotion-status-container" style="margin-top: 15px; display: flex; align-items: center; justify-content: center;">
          <div class="promotion-status ${promotionResult.status}" style="
            display: inline-block;
            padding: 6px 12px;
            border-radius: 4px;
            font-weight: bold;
            font-size: 14px;
            border: 2px solid;
            ${
              promotionResult.status === 'promoted' 
                ? 'background-color: #dcfce7; color: #166534; border-color: #bbf7d0;'
                : promotionResult.status === 'probation'
                ? 'background-color: #fef3c7; color: #92400e; border-color: #fde68a;'
                : 'background-color: #fee2e2; color: #dc2626; border-color: #fecaca;'
            }
          ">
            ${promotionResult.text}
          </div>
        </div>
      ` : '';

      // Add badge size customization
      const badgeSize = getCustomization('badge_size', 'medium');
      const badgeDimensions = {
        small: { width: 50, height: 50 },
        medium: { width: 150, height: 150 },
        large: { width: 300, height: 300 }
      };
      const { width: badgeWidth, height: badgeHeight } = badgeDimensions[badgeSize] || badgeDimensions['medium'];

      function commentsForGrade(grade) {
        const comments = {
          D1: getCustomization('result_comment_d1', 'Excellent results, keep it up.'),
          D2: getCustomization('result_comment_d2', 'Good job, but there is room for improvement.'),
          C3: getCustomization('result_comment_c3', 'Satisfactory performance, please work harder.'),
          C4: getCustomization('result_comment_c4', 'Needs improvement, consider seeking help.'),
          C5: getCustomization('result_comment_c5', 'Unsatisfactory, please see your teacher.')
        };
        if (grade === 'F9') {
          return getCustomization('result_comment_f9', 'Work with your teacher to improve.');
        }
        if (grade === 'P8') {
          return getCustomization('result_comment_p8', 'Passed, but you can do better.'); 
        }
        if (grade === 'C6') {
          return getCustomization('result_comment_c6', 'Needs improvement, consider seeking help.');
        }
        if (grade === 'C5') {
          return getCustomization('result_comment_c5', 'Unsatisfactory, please see your teacher.');
        }
        if (grade === 'C4') {
          return getCustomization('result_comment_c4', 'Needs improvement, consider seeking help.');
        }
        if (grade === 'C3') {
          return getCustomization('result_comment_c3', 'Satisfactory performance, please work harder.');
        }
        if (grade === 'D2') {
          return getCustomization('result_comment_d2', 'Good job, but there is room for improvement.');
        }
        if (grade === 'D1') {
          return getCustomization('result_comment_d1', 'Excellent results, keep it up.');
        }
        return comments[grade] || '';
      }

      // Generate unique barcode ID for this student
      const barcodeId = `barcode-${student.student_id}-${Date.now()}`;
      
      // Enhanced barcode HTML with SVG element (will be replaced with PHP-generated image)
      const barcodeHtml = `
        <div class="barcode-card" style="margin-right:10px;gap:-5px;align-items:center;justify-content:center;">
          <svg 
            id="${barcTerm:odeId}" 
            class="barcode-svg" 
            data-student-id="${student.student_id}"
            data-rotate="270"
            style="width: 110px; height: 50px; margin-right: -30px; margin-left: -20px; transform: rotate(270deg); transform-origin: center center; background: #f0f0f0; border: 1px dashed #ccc;"
            viewBox="0 0 110 50"
            preserveAspectRatio="xMidYMid meet"
          >
            <text x="50%" y="50%" text-anchor="middle" dominant-baseline="middle" font-family="monospace" font-size="8" fill="#666">
              Loading...
            </text>
          </svg>
          <span class="barcode-vertical" style="margin: 0;padding: 0;margin-left:-5px;">${formatStudentId(student.student_id, student)}</span>
        </div>
      `;

      // Add resizable functionality to the badge
      return `
      <div class="report-page" style="font-weight: bold;">
        <div class="header" style="opacity: ${getCustomization('header_opacity', 0.8)};">
          <div class="school-info" style="font-family: ${schoolNameFont}; color: ${schoolNameColor}; font-size: ${getCustomization('school_name_font_size', 40)}px;">
            <h1 class="school_name" style="margin:0; font-family: ${schoolNameFont}; color: ${schoolNameColor};">${schoolName}</h1>
            <p style="font-family: ${getCustomization('school_info_font_family', 'verdana')}; font-size: ${getCustomization('school_info_font_size', 13)}px; color: ${getCustomization('school_address_color', '#000')}">${schoolAddress}</p>
            <p class="motto bold" style="font-family: ${schoolMottoFont}; color: ${getCustomization('school_motto_color', schoolMottoColor)}; font-style: italic;">${schoolReg}</p>
            <p class="motto bold" style="font-family: ${schoolMottoFont}; color: ${getCustomization('school_motto_color', schoolMottoColor)}; font-style: italic;">${schoolRegPrimary}</p>
            <p class="motto bold" style="font-family: ${schoolMottoFont}; color: ${getCustomization('school_motto_color', schoolMottoColor)}; font-style: italic;">${schoolUNEBCenterNo}</p>
            <p class="motto bold" style="font-family: ${schoolMottoFont}; color: ${getCustomization('school_motto_color', schoolMottoColor)}; font-style: italic;">${schoolMotto}</p>
            <p style="font-family: ${getCustomization('school_info_font_family', 'verdana')}; font-size: ${getCustomization('school_info_font_size', 13)}px; color: ${getCustomization('school_contact_color', '#000')}">Email:${schoolEmail}</p>
            <p style="font-family: ${getCustomization('school_info_font_family', 'verdana')}; font-size: ${getCustomization('school_info_font_size', 13)}px; color: ${getCustomization('school_contact_color', '#000')}">${schoolContact}</p>
          </div>
          <div class="school-logo" style="">
            <img style="resize: both; overflow: auto;width: ${badgeWidth}px; height: ${badgeHeight}px; margin-right:-30px;" src="http://localhost/drais/public/schoolbadge.png" alt="School Badge" />
          </div>
        </div>
        <!-- First Banner -->
        <div class="blue-banner" style="${firstBannerStyle}; font-weight: ${getCustomization('banner1_font_weight', 'bold')}; font-size: ${getCustomization('banner1_font_size', 16)}px; text-align: ${getCustomization('banner1_text_align', 'center')}; padding: ${getCustomization('banner1_padding', '8px')}">${firstBannerText}</div>
        <div class="student-details">
          ${barcodeHtml}
          <div style="position: relative; display: inline-block;">
            <img 
              style="background-position: center top; background-size: cover; object-fit: cover; object-position: center top;" 
              src="${student.photo_passport || '/public/assets/images/badge.png'}" 
              alt="Student" 
              class="student-photo" 
              data-student-id="${student.student_id}"
              onclick="document.getElementById('photo-upload-${student.student_id}').click();"
              title="Click to upload photo"
            />
            <div class="photo-upload-overlay">Click to Upload</div>
            <input 
              type="file" 
              id="photo-upload-${student.student_id}" 
              accept="image/*" 
              style="display: none;"
              onchange="handlePhotoUpload(event, '${student.student_id}')"
            />
          </div>
          <div>
            <div class="student-info-container" style="font-size: ${getCustomization('student_info_font_size', 18)}px; flex-direction: row; gap:2rem; margin-bottom: 0px; padding-bottom: 0px; border-bottom: 2px dashed #000;">
              <p class="student-info" style="margin: 0; padding: 0;">
                <span class="bold" style="color:${studentLabelColor}">Name:</span> 
                <span class="student-value" style="color:${studentValueColor}; font-style: italic; font-weight: bolder;">${student.firstname} ${student.lastname} ${student.othername}</span>
              </p>
              <p style="margin: 0; padding: 0;">
                <span class="bold student-info" style="color:${studentLabelColor}">Sex:</span> 
                <span class="student-value" style="color:${studentValueColor}; font-style: italic; font-weight: bolder;">${student.gender}</span>
              </p>
              <p style="margin: 0; padding: 0;">
                <span class="bold student-info" style="color:${studentLabelColor}">Class:</span> 
                <span class="student-value" style="color:${studentValueColor}; font-style: italic; font-weight: bolder;">${student.class_name}</span>
              </p>
              <p style="margin: 0; padding: 0;">
                <span class="bold student-info" style="margin-bottom:0;color:${studentLabelColor}">Stream:</span> 
                <span class="student-value" style="color:${studentValueColor}; font-style: italic; font-weight: bolder;">${student.stream_name ? student.stream_name : 'A'}</span>
              </p>
            </div>

            <div class="student-info-container" style="font-size: ${getCustomization('student_info_font_size', 18)}px; flex-direction: row; gap:2rem; margin-bottom: 0px; padding-bottom: 0px; border-bottom: 2px dashed #000;">
              <p style="margin: 0; padding: 0;">
                <span class="bold student-info" style="color:${studentLabelColor}">Student No:</span> 
                <span class="student-value" style="color:${studentValueColor}; font-style: italic; font-weight: bolder;">${formatStudentId(student.student_id, student)}</span>
              </p>
              <p style="margin: 0; padding: 0;">
                <span class="bold student-info" style="color:${studentLabelColor}">Term:</span> 
                <span class="student-value" style="color:${studentValueColor}; font-style: italic; font-weight: bolder;">${student.term} - ${student.year}</span>
              </p>
              <p style="margin: 0; padding: 0;">
                <span class="bold student-info" style="color:${studentLabelColor}">Position:</span> 
                <span class="student-value" style="color:${studentValueColor}; font-style: italic; font-weight: bolder;">${student.term}</span>
              </p>
            </div>
          </div>
        </div>
        <!-- Second Banner -->
        <div class="gray-ribbon" style="${secondBannerStyle}; font-weight: ${getCustomization('banner2_font_weight', 'bold')}; font-size: ${getCustomization('banner2_font_size', 18)}px; max-width: ${getCustomization('banner2_max_width', '70%')}">${secondBannerText}</div>
        <table class="student-table" style="font-weight: bold; border-collapse: collapse; width: 100%;">
          <tr><td colspan="${isNursery ? 5 : 6}" style="text-align:left; font-weight:bold; padding: 6px;">Marks contribute: 100</td></tr>
          <tr style="${tableHeaderStyle}">
            <th style="${tableCellStyle}; background: ${tableHeaderBg}; font-weight: bold;">SUBJECT</th>
            <th style="${tableCellStyle}; background: ${tableHeaderBg}; font-weight: bold;">TOTAL</th>
            <th style="${tableCellStyle}; background: ${tableHeaderBg}; font-weight: bold;">${eotHeader}</th>
            ${isNursery ? '' : `<th style="${tableCellStyle}; background: ${tableHeaderBg}; font-weight: bold;">GRADE</th>`}
            <th style="${tableCellStyle}; background: ${tableHeaderBg}; font-weight: bold;">COMMENT</th>
            <th style="${tableCellStyle}; background: ${tableHeaderBg}; font-weight: bold;">INITIALS</th>
          </tr>
          ${student.results.map(r => `
            <tr style="font-size: ${tableFontSize}px;">
              <td style="${tableCellStyle}">
                ${r.subject}
                <button class="delete-row-btn" onclick="deleteResultRow(this)" title="Delete row">✕</button>
              </td>
              <td 
                class="editable-score" 
                contenteditable="true" 
                style="${tableCellStyle}; background: #fff; cursor: text;"
                data-student-id="${student.student_id}"
                data-result-id="${r.id}"
                data-original-score="100"
                onblur="handleScoreUpdate(this)"
                onkeydown="if(event.key==='Enter'){event.preventDefault();this.blur();}"
              >100</td>
              <td 
                class="editable-score" 
                contenteditable="true" 
                style="${tableCellStyle}; background: #fff; cursor: text;"
                data-student-id="${student.student_id}"
                data-subject-id="${r.subject_id}"
                data-result-id="${r.id}"
                data-original-score="${Math.floor(r.score)}"
                onblur="handleScoreUpdate(this)"
                onkeydown="if(event.key==='Enter'){event.preventDefault();this.blur();}"
              >${Math.floor(r.score)}</td>
              ${isNursery ? '' : `<td class="grade-cell-${r.id}" style="${tableCellStyle}; color:red; font-weight:bold;">${getGrade(Math.floor(r.score))}</td>`}
              <td class="comment-cell-${r.id}" style="${commentCellStyle}">${commentsForGrade(getGrade(Math.floor(r.score))) ?? ''}</td>
              <td style="${tableCellStyle}">${getTeacherInitials(r.subject, student.class_name)}</td>
            </tr>
          `).join('')}


          <tr style="font-weight: bold; font-size: ${tableFontSize}px;">
            <td colspan="2" style="${tableCellStyle}">TOTAL MARKS:</td>
            <td class="total-marks-cell" data-student-id="${student.student_id}" contenteditable="true" style="${tableCellStyle}">${totalMarks}</td>
            ${isNursery ? '' : `<td style="${tableCellStyle}">AVERAGE:</td>`}
            <td class="average-marks-cell" contenteditable="true" data-student-id="${student.student_id}" colspan="${isNursery ? 3 : 2}" style="${tableCellStyle}">${averageMarks}</td>
          </tr>
        </table>
        <!-- Third Banner -->
        ${!isNursery ? `
        <div class="gray-ribbon" style="${thirdBannerStyle}; font-weight: ${getCustomization('banner3_font_weight', 'bold')}; font-size: ${getCustomization('banner3_font_size', 18)}px; max-width: ${getCustomization('banner3_max_width', '70%')}">${thirdBannerText}</div>
        <table class="student-table" style="font-weight: bold;">
          <tr><td colspan="6" style="text-align:left; font-weight:bold;">Marks contribute: 100</td></tr>
          <tr style="${tableHeaderStyle}">
            <th style="border: 1px solid ${tableBorderColor};">SUBJECT</th>
            <th style="border: 1px solid ${tableBorderColor};">TOTAL</th>
            <th style="border: 1px solid ${tableBorderColor};">${eotHeader}</th>
            <th style="border: 1px solid ${tableBorderColor};">GRADE</th>
            <th style="border: 1px solid ${tableBorderColor};">COMMENT</th>
            <th style="border: 1px solid ${tableBorderColor};">INITIALS</th>
          </tr>
          ${student.other_subjects.map(r => `
            <tr style="font-size: ${tableFontSize}px;">
            <td style="${tableCellStyle}">${Math.floor(r.score)}</td>
            <td style="${tableCellStyle}">${r.subject}</td>
              <td style="${tableCellStyle}">100</td>
              <td style="${tableCellStyle}; color:red; font-weight:bold;">${getGrade(r.score)}</td>
              <td style="${commentCellStyle}">${commentsForGrade(getGrade(r.score)) ?? ''}</td>
              <td style="${tableCellStyle}">${r.teacher_name ? r.teacher_name.split(' ').map(n => n[0]).join('') : 'N/A'}</td>
            </tr>
          `).join('')}
        </table>
        ` : ''}
        <table class="student-table" style="margin-top: 20px; font-size: ${tableFontSize}px;">
          <tr>
            <th colspan="2" style="${tableHeaderStyle}">Average Score</th>
            ${isNursery ? '' : `<th colspan="3" style="${tableHeaderStyle}">General Assessment</th>`}
          </tr>
          <tr>
            <td style="${tableCellStyle}">Subject Count</td>
            <td style="${tableCellStyle}">Average %</td>
            ${isNursery ? '' : `
            <td style="${tableCellStyle}">Aggregates</td>
            <td colspan="2" style="${tableCellStyle}">Division</td>
            `}
          </tr>
          <tr>
            <td style="${tableCellStyle}" contenteditable="true">${student.results.length}</td>
            <td style="${tableCellStyle}" contenteditable="true">${averageMarks}</td>
            ${isNursery ? '' : `
            <td style="${tableCellStyle}" id="aggregate">${(() => {
              if (!student.results.length) return '';
              const agg = student.results.reduce((sum, r) => sum + getGradePoint(getGrade(r.score)), 0);
              return agg;
            })()}</td>
            <td colspan="2" style="${tableCellStyle}">${(() => {
              if (!student.results.length) return '';
              const agg = student.results.reduce((sum, r) => sum + getGradePoint(getGrade(r.score)), 0);
              return getDivision(agg);
            })()}</td>
            `}
          </tr>
        </table>
        ${commentsSection(student)}
        
        <!-- Other Subjects Section (matching Next.js structure) -->
        ${student.other_subjects && student.other_subjects.length > 0 ? `
          <div class="gray-ribbon" style="${thirdBannerStyle}; font-weight: bold; font-size: 18px; padding: 4px; text-align: center; margin: 15px auto 10px; max-width: 70%;">
            ${thirdBannerText}
          </div>
          <table class="student-table" style="margin-top: 10px;">
            <thead>
              <tr style="${tableHeaderStyle}">
                <th style="${tableHeaderStyle}">Subject</th>
                <th style="${tableHeaderStyle}">Score</th>
                <th style="${tableHeaderStyle}">Grade</th>
                <th style="${tableHeaderStyle}">Comment</th>
                <th style="${tableHeaderStyle}">Initials</th>
              </tr>
            </thead>
            <tbody>
              ${student.other_subjects.map(r => `
                <tr>
                  <td style="${tableCellStyle}; text-align: left; font-weight: bold;">
                    ${r.subject}
                    <button class="delete-row-btn" onclick="deleteResultRow(this)" title="Delete row">✕</button>
                  </td>
                  <td 
                    class="editable-score" 
                    contenteditable="true" 
                    style="${tableCellStyle}; background: #fff; cursor: text; color: red; font-weight: bold;"
                    data-student-id="${student.student_id}"
                    data-subject-id="${r.subject_id}"
                    data-result-id="${r.id}"
                    data-original-score="${Math.floor(r.score || 0)}"
                    onblur="handleScoreUpdate(this)"
                    onkeydown="if(event.key==='Enter'){event.preventDefault();this.blur();}"
                  >${Math.floor(r.score || 0)}</td>
                  <td class="grade-cell-${r.id}" style="${tableCellStyle}; color: red; font-weight: bold;">${getGrade(Math.floor(r.score))}</td>
                  <td class="comment-cell-${r.id}" style="${commentCellStyle}">${commentsForGrade(getGrade(Math.floor(r.score))) || ''}</td>
                  <td style="${tableCellStyle}">${getTeacherInitials(r.subject, student.class_name)}</td>
                </tr>
              `).join('')}
            </tbody>
          </table>
        ` : ''}
        
        <!-- Promotion Status -->
        ${promotionStatusHtml}
        
        ${gradeTable()}
      </div>`;
    }

    async function renderAllReports() {
      const data = await fetchReports();
      if (!window.reportCustomization || Object.keys(window.reportCustomization).length === 0) {
        window.reportCustomization = data.customization;
      }
      const students = groupResultsByStudent(data.students, data.results);
      window.lastApiStudents = students;
      calculatePositions(students);

      const getDropdownValue = (id, defaultValue) => {
        const element = document.querySelector(id);
        return element ? element.value : defaultValue;
      };

      // Updated comments to be more education-focused
      const classTeacherComments = {
        div1: getDropdownValue('#class_teacher_comment_div1', 'Exceptional academic achievement, keep striving for excellence.'),
        div2: getDropdownValue('#class_teacher_comment_div2', 'Good progress, continue to work hard and aim higher.'),
        div3: getDropdownValue('#class_teacher_comment_div3', 'Steady effort, focus on improving your study habits.'),
        div4: getDropdownValue('#class_teacher_comment_div4', 'Improvement needed, seek help and dedicate more time to learning.'),
        divU: getDropdownValue('#class_teacher_comment_divU', 'Significant support required, let us work together for better results.')
      };

      const headteacherComments = {
        div1: getDropdownValue('#headteacher_comment_div1', 'Your commitment to learning is commendable, keep it up.'),
        div2: getDropdownValue('#headteacher_comment_div2', 'A solid performance, continue to challenge yourself academically.'),
        div3: getDropdownValue('#headteacher_comment_div3', 'Maintain your effort and seek guidance to improve further.'),
        div4: getDropdownValue('#headteacher_comment_div4', 'Let us work together to strengthen your academic foundation.'),
        divU: getDropdownValue('#headteacher_comment_divU', 'Let us focus on building your skills for future success.')
      };

      const dosComments = {
        div1: getDropdownValue('#dos_comment_div1', 'Profound resilience shown in your work!'),
        div2: getDropdownValue('#dos_comment_div2', 'Good effort, keep pushing!'),
        div3: getDropdownValue('#dos_comment_div3', 'You must be resilient in your studies.'),
        div4: getDropdownValue('#dos_comment_div4', 'Significant improvement needed, stay focused.'),
        divU: getDropdownValue('#dos_comment_divU', 'Critical improvement needed, let\'s work together.')
      };

      const root = document.getElementById('reports-root');
      root.innerHTML = students.map(student => {
        const aggregates = student.results.reduce((sum, r) => sum + getGradePoint(getGrade(r.score)), 0);
        let division;
        if (aggregates <= 12) division = 'div1';
        else if (aggregates <= 24) division = 'div2';
        else if (aggregates <= 28) division = 'div3';
        else if (aggregates <= 32) division = 'div4';
        else division = 'divU';

        student.class_teacher_comment = classTeacherComments[division];
        student.headteacher_comment = headteacherComments[division];
        student.dos_comment = dosComments[division];

        return renderReport(student);
      }).join('');
      
      // Render promotion status for all students after reports are rendered
      setTimeout(() => {
        renderPromotionComponents(students);
      }, 100);

      // Initialize barcodes after reports are rendered
      setTimeout(() => {
        initializeBarcodes();
      }, 100);
      
      // Render promotion status for all students after reports are rendered
      setTimeout(() => {
        renderPromotionComponents(students);
      }, 150);
    }
    
    // Function to render promotion components for all students
    function renderPromotionComponents(studentsData) {
      console.log('🎯 Rendering promotion components for', studentsData.length, 'students');
      
      const promotionContainers = document.querySelectorAll('[id^="promotion-container-"]');
      promotionContainers.forEach((container) => {
        const studentId = container.getAttribute('data-student-id');
        const student = studentsData.find(s => s.student_id === studentId);
        
        if (student) {
          const totalMarks = student.results.reduce((sum, r) => sum + Math.floor(r.score || 0), 0);
          const averageMarks = student.results.length ? Math.floor(totalMarks / student.results.length) : 0;
          
          // Calculate promotion status using the PHP promotion engine
          const promotionResult = getPromotionStatus(
            student,
            totalMarks,
            averageMarks,
            (agg) => {
              if (agg <= 12) return 'Division 1';
              if (agg <= 24) return 'Division 2';
              if (agg <= 28) return 'Division 3';
              if (agg <= 32) return 'Division 4';
              return 'Division U';
            }
          );
          
          console.log('📊 Promotion Result for', student.firstname, student.lastname, ':', promotionResult);
          
          // Render the promotion status HTML
          const promotionHtml = renderPromotionStatus(promotionResult.status, promotionResult.text);
          container.innerHTML = promotionHtml;
        }
      });
    }

    // Promotion Engine Functions - Copied from Next.js PromotionEngine.ts
    function normalizeClassName(className) {
      if (!className || typeof className !== 'string') return '';
      
      const classStr = className.toLowerCase().trim();
      const normalized = classStr.replace(/[^a-z0-9]/g, '');
      return normalized;
    }
    
    function getPromotionStatus(student, totalMarks, averageMarks, getDivisionCallback) {
      const classname = normalizeClassName(student.classname || student.class || '');
      
      // Apply default promotion logic
      return applyDefaultPromotionLogic(student, totalMarks, averageMarks, getDivisionCallback);
    }
    
    function applyDefaultPromotionLogic(student, totalMarks, averageMarks, getDivisionCallback) {
      // Calculate aggregates (sum of grade points) for division
      const aggregates = student.results ? student.results.reduce((sum, r) => sum + getGradePoint(getGrade(Math.floor(r.score || 0))), 0) : 0;
      const division = getDivisionCallback ? getDivisionCallback(aggregates) : getDivisionByAggregates(aggregates);
      
      // Get current class and next class
      const currentClass = student.class_name || student.classname || student.class || '';
      const nextClass = getNextClassName(currentClass);
      const classLevel = getClassLevel(normalizeClassName(currentClass));
      
      let status = 'repeat';
      let text = 'REPEAT';
      
      if (classLevel === 'nursery' || classLevel === 'primary_lower') {
        // Nursery to P3: 50% threshold
        if (averageMarks >= 50) {
          status = 'promoted';
          text = `Promoted to ${nextClass}`;
        } else {
          status = 'repeat';
          text = 'Advised to Repeat';
        }
      } else if (classLevel === 'primary_upper') {
        // P4 to P6: 60% threshold (upper primary)
        if (averageMarks >= 60) {
          status = 'promoted';
          text = `Promoted to ${nextClass}`;
        } else {
          status = 'repeat';
          text = 'Advised to Repeat';
        }
      } else if (classLevel === 'primary_seven') {
        // P7: 50% threshold
        if (averageMarks >= 50) {
          status = 'promoted';
          text = `Promoted to ${nextClass}`;
        } else {
          status = 'repeat';
          text = 'Advised to Repeat';
        }
      } else {
        // Senior or unknown: 50% threshold
        if (averageMarks >= 50) {
          status = 'promoted';
          text = `Promoted to ${nextClass}`;
        } else {
          status = 'repeat';
          text = 'Advised to Repeat';
        }
      }
      
      return { status, text, division, averageMarks, totalMarks };
    }
    
    function renderPromotionStatus(status, text) {
      const statusColors = {
        'promoted': '#10B981',
        'probation': '#F59E0B', 
        'repeat': '#EF4444'
      };
      
      const color = statusColors[status] || '#6B7280';
      
      return `
        <div style="
          display: inline-block;
          padding: 4px 12px;
          background-color: ${color};
          color: white;
          border-radius: 9999px;
          font-size: 12px;
          font-weight: 600;
          text-align: center;
          margin: 2px 0;
        ">
          ${text}
        </div>
      `;
    }
    
    // Helper function to calculate division based on aggregates (sum of grade points)
    function getDivisionByAggregates(aggregates) {
      if (aggregates >= 4 && aggregates <= 12) return 'Division 1';
      if (aggregates >= 13 && aggregates <= 24) return 'Division 2';
      if (aggregates >= 25 && aggregates <= 28) return 'Division 3';
      if (aggregates >= 29 && aggregates <= 32) return 'Division 4';
      return 'Division U';
    }
    
    // Helper function to format student ID - Replace XHN with NGS
    function formatStudentId(studentId, student) {
      if (!studentId) return '';
      
      // Replace XHN with NGS (case insensitive)
      let formattedId = studentId.replace(/NGS/gi, 'NGS');
      
      // If it still doesn't start with NGS, format it properly
      if (!formattedId.toUpperCase().startsWith('NGS')) {
        const year = student?.year || new Date().getFullYear();
        formattedId = `NGS/${formattedId}/${year}`;
      }
      
      return formattedId;
    }

    // Add the missing applyFilters function
    function applyFilters() {
      console.log('Applying filters...');
      
      // Get current filter values
      const term = document.getElementById('filter-term').value;
      const class_id = document.getElementById('filter-class').value;
      const results_type = document.getElementById('filter-result-type').value;
      const student_search = document.getElementById('filter-student').value.toLowerCase().trim();

      // Get all report pages
      const reportPages = document.querySelectorAll('.report-page');
      reportPages.forEach(page => page.classList.remove('hidden'));

      // Get all students from window.lastApiStudents if available
      let students = window.lastApiStudents || [];
      
      students.forEach((student, idx) => {
        let show = true;
        
        // Term filter
        if (term && student.term && student.term.toLowerCase() !== term.toLowerCase()) {
          show = false;
        }
        
        // Class filter
        if (class_id) {
          if (isNaN(class_id)) {
            if (student.class_name && student.class_name.toLowerCase() !== class_id.toLowerCase()) {
              show = false;
            }
          } else {
            if (student.class_id && String(student.class_id) !== String(class_id)) {
              show = false;
            }
          }
        }
        
        // Results type filter
        if (results_type && student.results && student.results.length > 0) {
          const hasResultType = student.results.some(r => 
            r.results_type && r.results_type.toLowerCase() === results_type.toLowerCase()
          );
          if (!hasResultType) {
            show = false;
          }
        }
        
        // Student search filter
        if (student_search) {
          const fullName = `${student.firstname || ''} ${student.lastname || ''} ${student.othername || ''}`.toLowerCase();
          const studentId = (student.student_id || '').toLowerCase();
          
          if (!fullName.includes(student_search) && !studentId.includes(student_search)) {
            show = false;
          }
        }
        
        // Hide/show the corresponding report page
        if (!show) {
          if (reportPages[idx]) reportPages[idx].classList.add('hidden');
        } else {
          if (reportPages[idx]) reportPages[idx].classList.remove('hidden');
        }
      });
      
      // Re-render promotion components for visible students
      const visibleStudents = students.filter((student, idx) => {
        const reportElement = reportPages[idx];
        return reportElement && !reportElement.classList.contains('hidden');
      });
      
      setTimeout(() => {
        renderPromotionComponents(visibleStudents);
      }, 50);
      
      console.log('Filters applied');
    }

    // Export functions that work with current filtered view
    function exportReports(type) {
      if (type === 'pdf') {
        window.print();
      } else if (type === 'csv') {
        // Simple CSV export
        let csv = 'Name,Class,Student ID\n';
        const visiblePages = document.querySelectorAll('.report-page:not(.hidden)');
        // Basic CSV export functionality
        const blob = new Blob([csv], { type: 'text/csv' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'filtered-reports.csv';
        a.click();
        URL.revokeObjectURL(url);
      }
    }

    function openCustomizationModal() {
      const modal = new bootstrap.Modal(document.getElementById('customizationModal'));
      modal.show();
    }

    // Expose functions globally
    window.applyFilters = applyFilters;
    window.exportReports = exportReports;
    window.openCustomizationModal = openCustomizationModal;

    // Modal accessibility fix
    const modalElement = document.getElementById('customizationModal');
    modalElement.addEventListener('show.bs.modal', function () {
      document.body.style.overflow = 'hidden';
    });
    modalElement.addEventListener('hidden.bs.modal', function () {
      document.body.style.overflow = '';
    });
    
    // Handle score updates (client-side only for printing purposes)
    function handleScoreUpdate(cell) {
      const newScore = parseInt(cell.textContent.trim());
      const originalScore = parseInt(cell.dataset.originalScore);
      const resultId = cell.dataset.resultId;
      const studentId = cell.dataset.studentId;
      
      if (isNaN(newScore) || newScore < 0 || newScore > 100) {
        alert('Please enter a valid score between 0 and 100');
        cell.textContent = originalScore;
        return;
      }
      
      if (newScore === originalScore) {
        return; // No change
      }
      
      // Update grade and comment cells locally
      const newGrade = getGrade(newScore);
      const gradeCell = document.querySelector(`.grade-cell-${resultId}`);
      const commentCell = document.querySelector(`.comment-cell-${resultId}`);
      
      if (gradeCell) gradeCell.textContent = newGrade;
      if (commentCell) commentCell.textContent = commentsForGrade(newGrade) || '';
      
      cell.dataset.originalScore = newScore;
      cell.style.background = '#d4edda'; // Success green
      setTimeout(() => { cell.style.background = ''; }, 1000);
      
      // Recalculate totals and averages for this student's report
      recalculateTotalsAndAverage(studentId);
    }
    
    // Recalculate total marks and average for a student
    function recalculateTotalsAndAverage(studentId) {
      // Get all editable score cells for this student (exclude TOTAL column cells)
      const scoreCells = document.querySelectorAll(`.editable-score[data-student-id="${studentId}"][data-subject-id]`);
      let total = 0;
      let count = 0;
      
      scoreCells.forEach(cell => {
        const score = parseInt(cell.textContent.trim());
        if (!isNaN(score)) {
          total += score;
          count++;
        }
      });
      
      const average = count > 0 ? (total / count).toFixed(2) : '0.00';
      
      // Update TOTAL MARKS cell
      const totalCell = document.querySelector(`.total-marks-cell[data-student-id="${studentId}"]`);
      if (totalCell) {
        totalCell.textContent = total;
        totalCell.style.background = '#d4edda';
        setTimeout(() => { totalCell.style.background = ''; }, 1000);
      }
      
      // Update AVERAGE cell
      const avgCell = document.querySelector(`.average-marks-cell[data-student-id="${studentId}"]`);
      if (avgCell) {
        avgCell.textContent = average;
        avgCell.style.background = '#d4edda';
        setTimeout(() => { avgCell.style.background = ''; }, 1000);
      }
    }
    
    // Handle photo uploads (client-side preview only for printing purposes)
    function handlePhotoUpload(event, studentId) {
      const file = event.target.files[0];
      if (!file) return;
      
      // Validate file type
      if (!file.type.startsWith('image/')) {
        alert('Please select an image file');
        return;
      }
      
      // Validate file size (max 5MB)
      if (file.size > 5 * 1024 * 1024) {
        alert('Image size must be less than 5MB');
        return;
      }
      
      // Create local preview using FileReader
      const reader = new FileReader();
      const imgElement = document.querySelector(`img[data-student-id="${studentId}"]`);
      
      reader.onload = function(e) {
        imgElement.src = e.target.result;
      };
      
      reader.readAsDataURL(file);
    }
    
    // Delete row functionality (client-side only for printing purposes)
    function deleteResultRow(btn) {
      if (confirm('Delete this subject row? (Changes are temporary for printing only)')) {
        const row = btn.closest('tr');
        row.style.transition = 'opacity 0.3s';
        row.style.opacity = '0';
        setTimeout(() => row.remove(), 300);
      }
    }
    
    // Expose functions globally
    window.handleScoreUpdate = handleScoreUpdate;
    window.handlePhotoUpload = handlePhotoUpload;
    window.deleteResultRow = deleteResultRow;
    
    // Initialize when page loads - Enhanced version with PHP barcode support
    window.onload = function() {
      console.log('Page loaded, initializing reports with PHP barcodes...');
      
      // Remove the test API call - directly proceed with initialization
      proceedWithInitialization();
    };

    function proceedWithInitialization() {
      fetchFilters().then(() => {
        console.log('Filters loaded, rendering reports...');
        renderAllReports().then(() => {
          console.log('Reports rendered successfully');
          
          // Initialize PHP barcodes after reports are rendered
          setTimeout(async () => {
            console.log('Starting PHP barcode generation with student IDs...');
            await initializeBarcodes();
            
            // Additional check after barcode generation
            setTimeout(() => {
              const remainingSvgElements = document.querySelectorAll('.barcode-svg');
              if (remainingSvgElements.length > 0) {
                console.log(`${remainingSvgElements.length} barcodes still need generation, retrying...`);
                generateAllBarcodes();
              } else {
                console.log('All barcodes generated successfully using PHP API with student IDs');
              }
            }, 2000);
            
          }, 500);
          
        }).catch(error => {
          console.error('Error rendering reports:', error);
          document.getElementById('reports-root').innerHTML = '<div style="text-align: center; padding: 50px; color: red;">Error loading reports. Please check the console for details.</div>';
        });
      }).catch(error => {
        console.error('Error loading filters:', error);
        // Still try to render reports even if filters fail
        renderAllReports().catch(renderError => {
          console.error('Error rendering reports:', renderError);
          document.getElementById('reports-root').innerHTML = '<div style="text-align: center; padding: 50px; color: red;">Error loading reports. Please check the console for details.</div>';
        });
      });
    }
  </script>
</body>
</html>
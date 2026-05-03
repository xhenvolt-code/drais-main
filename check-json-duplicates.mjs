#!/usr/bin/env node

import fs from 'fs/promises';
import path from 'path';

const jsonPath = path.join(process.cwd(), 'backup', 'northgate-term1-2026-results.json');
const jsonData = JSON.parse(await fs.readFile(jsonPath, 'utf-8'));

const firstStudent = jsonData.classes[0].students[0];
console.log(`📍 ${firstStudent.name} - Results: ${firstStudent.results.length}`);
console.log('─'.repeat(50));

// Check for duplicates
const subjectCounts = {};
firstStudent.results.forEach(r => {
  const subj = r.subjectName;
  subjectCounts[subj] = (subjectCounts[subj] || 0) + 1;
});

let hasDuplicates = false;
Object.entries(subjectCounts).forEach(([subj, count]) => {
  if (count > 1) {
    hasDuplicates = true;
    console.log(`⚠️  ${subj}: ${count} results`);
  }
});

if (!hasDuplicates) {
  console.log('✅ No duplicates! Each subject appears exactly once');
  console.log('\n📋 Subject list:');
  Object.keys(subjectCounts).forEach(subj => {
    console.log(`  - ${subj}`);
  });
}

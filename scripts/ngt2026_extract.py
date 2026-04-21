#!/usr/bin/env python3
"""
Extract Northgate 2026 student data from NGTDB2026.sql,
map each student to their 2026 class (one level up from 2025),
and output a JSON file for enrollment.
"""
import re, json, sys

SQL_PATH = 'backup/NGTDB2026.sql'
OUT_PATH  = 'northgate_2026_enrollment.json'

sql = open(SQL_PATH).read()

# ── class_id → class_name (from ngtdb classes table)
CLASSES = {
    '1': 'PRIMARY SEVEN', '2': 'BABY CLASS', '3': 'MIDDLE CLASS',
    '4': 'TOP CLASS',     '5': 'PRIMARY ONE', '6': 'PRIMARY TWO',
    '7': 'PRIMARY THREE', '8': 'PRIMARY FOUR', '9': 'PRIMARY FIVE',
    '10': 'PRIMARY SIX',
}

# ── progression from classes_sequence table
PROGRESSION = {
    'BABY CLASS':    'MIDDLE CLASS',
    'MIDDLE CLASS':  'PRIMARY ONE',
    'PRIMARY ONE':   'PRIMARY TWO',
    'PRIMARY TWO':   'PRIMARY THREE',
    'PRIMARY THREE': 'PRIMARY FOUR',
    'PRIMARY FOUR':  'PRIMARY FIVE',
    'PRIMARY FIVE':  'PRIMARY SIX',
    'PRIMARY SIX':   'PRIMARY SEVEN',
    'PRIMARY SEVEN': None,  # graduating
    'TOP CLASS':     None,  # graduating
}

# ── Parse students INSERT
stu_m = re.search(r"INSERT INTO `students` VALUES (.+?);", sql, re.DOTALL)
if not stu_m:
    print("ERROR: no students INSERT found"); sys.exit(1)

raw = stu_m.group(1)

# Each row: (id,'student_id','fn','ln','on','class_id','stream_id',
#            'DOB'or NULL,'gender','section','district','subcounty',
#            'parish','village',NULL_or_str,NULL_or_str,'status',
#            '/path/photo' or NULL, ...)
# We'll use a token-based parser for robustness
def parse_sql_values(raw):
    """Parse MySQL VALUES list into list of tuples."""
    rows = []
    # Strip outer parens per row
    # Use simple state machine
    i = 0
    n = len(raw)
    while i < n:
        if raw[i] == '(':
            # find matching close paren at same depth
            depth = 1
            j = i + 1
            in_str = False
            esc = False
            while j < n and depth > 0:
                c = raw[j]
                if esc:
                    esc = False
                elif c == '\\' and in_str:
                    esc = True
                elif c == "'" and not esc:
                    in_str = not in_str
                elif not in_str:
                    if c == '(':
                        depth += 1
                    elif c == ')':
                        depth -= 1
                j += 1
            row_str = raw[i+1:j-1]
            rows.append(parse_row(row_str))
            i = j
        else:
            i += 1
    return rows

def parse_row(s):
    """Parse a single row string into a list of values."""
    vals = []
    i = 0
    n = len(s)
    while i < n:
        # skip whitespace and commas
        while i < n and s[i] in (' ', '\t', '\n', ','):
            i += 1
        if i >= n:
            break
        if s[i] == "'":
            # string value
            j = i + 1
            buf = []
            while j < n:
                if s[j] == '\\' and j+1 < n:
                    buf.append(s[j+1])
                    j += 2
                elif s[j] == "'":
                    j += 1
                    break
                else:
                    buf.append(s[j])
                    j += 1
            vals.append(''.join(buf))
            i = j
        elif s[i:i+4].upper() == 'NULL':
            vals.append(None)
            i += 4
        else:
            # number or keyword
            j = i
            while j < n and s[j] not in (',', ')'):
                j += 1
            token = s[i:j].strip()
            vals.append(token)
            i = j
    return vals

students_raw = parse_sql_values(raw)
print(f"Parsed {len(students_raw)} student rows")

# Column indices: id(0), student_id(1), firstname(2), lastname(3), othername(4),
#                class_id(5), stream_id(6), DOB(7), gender(8), section(9),
#                district(10), subcounty(11), parish(12), village(13),
#                marital_status(14), contact(15), academic_status(16),
#                photo_passport(17), photo_full(18), ...
students = []
graduating = []
no_class   = []

for row in students_raw:
    if len(row) < 17:
        continue
    student_id = row[1]
    firstname  = row[2].strip().title()
    lastname   = row[3].strip().title()
    othername  = (row[4] or '').strip().title()
    class_id   = row[5]
    dob        = row[7]
    gender     = row[8]
    photo      = row[17]  # photo_passport path from local system

    class_2025 = CLASSES.get(class_id, None)
    if class_2025 is None:
        no_class.append(student_id)
        continue

    class_2026 = PROGRESSION.get(class_2025)

    full_name = f"{firstname} {lastname}"
    if othername:
        full_name += f" {othername}"

    rec = {
        "ngs_id":       student_id,
        "first_name":   firstname,
        "last_name":    lastname,
        "other_name":   othername,
        "full_name":    full_name,
        "gender":       gender,
        "dob":          dob,
        "class_2025":   class_2025,
        "class_2026":   class_2026,
        "photo_local":  photo,
    }

    if class_2026 is None:
        graduating.append(rec)
    else:
        students.append(rec)

print(f"  Enrolling in 2026 class: {len(students)}")
print(f"  Graduating (no next class): {len(graduating)}")
print(f"  No class found: {len(no_class)}")

# Class distribution for 2026
from collections import Counter
dist = Counter(s['class_2026'] for s in students)
print("\n2026 class distribution:")
for cls in sorted(dist):
    print(f"  {cls}: {dist[cls]}")

# Save JSON
output = {
    "generated": "2026-04-21",
    "description": "Northgate 2026 enrollment - students promoted from 2025 class",
    "enrolling": students,
    "graduating_2025": graduating,
}
with open(OUT_PATH, 'w') as f:
    json.dump(output, f, indent=2)
print(f"\nSaved to {OUT_PATH}")

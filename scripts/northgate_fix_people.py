"""
Fix: Create people rows for Northgate students (school_id=6) and link student.person_id.
Source: NorthgateschoolEndofTerm3.sql
"""
import re, pymysql

SQL_PATH = '/home/xhenvolt/Systems/DraisLongTermVersion/database/Database/NorthgateschoolEndofTerm3.sql'
SCHOOL_ID = 6

DB = dict(
    host='gateway01.eu-central-1.prod.aws.tidbcloud.com',
    port=4000,
    user='2Trc8kJebpKLb1Z.root',
    password='QMNAOiP9J1rANv4Z',
    database='drais',
    ssl={'ca': '/etc/ssl/certs/ca-certificates.crt'},
    charset='utf8mb4',
)

# ── 1. Parse student rows from SQL ────────────────────────────────────────────
print("Parsing SQL file …")
with open(SQL_PATH, 'r', encoding='utf-8', errors='replace') as f:
    content = f.read()

# Grab all INSERT INTO `students` blocks
blocks = re.findall(r"INSERT INTO `students`[^;]+;", content, re.DOTALL)
print(f"  Found {len(blocks)} INSERT blocks")

# Column positions (0-indexed): id=0, student_id=1, firstname=2, lastname=3,
#   othername=4, class_id=5, stream_id=6, DOB=7, gender=8
ROW_RE = re.compile(r"\(([^)]+)\)")

students_by_admission = {}  # admission_no -> {firstname, lastname, othername, dob, gender}

for block in blocks:
    # Remove the header line, keep just VALUES part
    values_part = block[block.index('VALUES'):]
    for m in ROW_RE.finditer(values_part):
        raw = m.group(1)
        # Split on commas not inside quotes
        cols = re.split(r",(?=(?:[^']*'[^']*')*[^']*$)", raw)
        if len(cols) < 9:
            continue
        def unquote(s):
            s = s.strip()
            if s.upper() == 'NULL':
                return None
            return s.strip("'")
        admission = unquote(cols[1])
        if not admission or not admission.startswith('NGS/'):
            continue
        fn = unquote(cols[2]) or ''
        ln = unquote(cols[3]) or ''
        on = unquote(cols[4]) or ''
        dob = unquote(cols[7])
        gen = unquote(cols[8])
        students_by_admission[admission] = {
            'first_name': fn.strip().title(),
            'last_name':  ln.strip().title(),
            'other_name': on.strip().title() if on else None,
            'date_of_birth': dob if dob and dob != '0000-00-00' else None,
            'gender': gen,
        }

print(f"  Parsed {len(students_by_admission)} unique students from SQL")

# ── 2. Fetch TiDB students with person_id=0 for school_id=6 ──────────────────
conn = pymysql.connect(**DB)
try:
    cur = conn.cursor()
    cur.execute(
        "SELECT id, admission_no FROM students WHERE school_id=%s AND person_id=0 ORDER BY id",
        (SCHOOL_ID,)
    )
    db_students = cur.fetchall()
    print(f"  TiDB students needing people rows: {len(db_students)}")

    if not db_students:
        print("Nothing to fix — all students already have person_id > 0")
        conn.close()
        exit(0)

    # ── 3. Insert people rows and update students in a transaction ────────────
    conn.begin()
    inserted = 0
    skipped  = 0

    for (student_id, admission_no) in db_students:
        info = students_by_admission.get(admission_no)
        if not info:
            # Fallback: use admission number as name placeholder
            info = {
                'first_name': admission_no,
                'last_name':  'Unknown',
                'other_name': None,
                'date_of_birth': None,
                'gender': None,
            }
            skipped += 1

        cur.execute(
            """INSERT INTO people
               (school_id, first_name, last_name, other_name, gender, date_of_birth)
               VALUES (%s, %s, %s, %s, %s, %s)""",
            (SCHOOL_ID,
             info['first_name'],
             info['last_name'],
             info['other_name'],
             info['gender'],
             info['date_of_birth'])
        )
        person_id = cur.lastrowid

        cur.execute(
            "UPDATE students SET person_id=%s WHERE id=%s",
            (person_id, student_id)
        )
        inserted += 1

        if inserted % 50 == 0:
            print(f"  … {inserted}/{len(db_students)}")

    conn.commit()
    print(f"\n✅ DONE")
    print(f"   People rows created : {inserted}")
    print(f"   Name-unknown (fallback): {skipped}")

finally:
    conn.close()

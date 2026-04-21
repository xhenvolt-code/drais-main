"""
Northgate School (school_id=6, northgateschool@gmail.com)
Historical data insertion: Term II & Term III 2025
"""
import json, pymysql, re, sys

with open('/home/xhenvolt/Systems/DraisLongTermVersion/northgate_term2_term3_2025.json', 'r') as f:
    data = json.load(f)

conn = pymysql.connect(
    host='gateway01.eu-central-1.prod.aws.tidbcloud.com',
    port=4000,
    user='2Trc8kJebpKLb1Z.root',
    password='QMNAOiP9J1rANv4Z',
    database='drais',
    ssl={'ssl_mode': 'REQUIRED'},
    autocommit=False,
    connect_timeout=30,
)

# SQL class_id → TiDB class_id (school_id=6)
CLASS_MAP = {
    '1': 400004,  # PRIMARY SEVEN
    '2': 60005,   # BABY CLASS
    '3': 400006,  # MIDDLE CLASS
    '4': 400007,  # TOP CLASS
    '5': 400008,  # PRIMARY ONE
    '6': 400009,  # PRIMARY TWO
    '7': 400010,  # PRIMARY THREE
    '8': 400011,  # PRIMARY FOUR
    '9': 400012,  # PRIMARY FIVE
    '10': 400013, # PRIMARY SIX
}

SUBJECT_MAP = {
    'MATHEMATICS': 412003,
    'ENGLISH': 412004,
    'SOCIAL STUDIES': 412005,
    'LITERACY I': 412006,
    'RELIGIOUS EDUCATION': 412007,
    'LITERACY II': 412008,
    'NUMBERS': 412009,
    'LANGUAGE DEVELOPMENT I': 412010,
    'SOCIAL DEVELOPMENT': 412011,
    'LANGUAGE DEVELOPMENT II': 412012,
    'HEALTH HABITS': 412013,
    'SCIENCE': 2,
}

TERM_MAP = {
    'Term II 2025': 60004,
    'Term III 2025': 60005,
}

SCHOOL_ID       = 6
ACADEMIC_YEAR_ID = 12001
RESULT_TYPE_ID  = 392005  # END OF TERM

# Read SQL to get class_id per student admission_no
with open('/home/xhenvolt/Systems/DraisLongTermVersion/database/Database/NorthgateschoolEndofTerm3.sql', 'r') as f:
    sql_content = f.read()

student_class_sql = {}
for block in re.findall(r"INSERT INTO `students`[^;]+VALUES(.*?);", sql_content, re.DOTALL):
    for m in re.finditer(r"\(\d+, '([^']+)', '[^']*', '[^']*', '[^']*', '?(\d+)'?,", block):
        student_class_sql[m.group(1)] = m.group(2)

cursor = conn.cursor()
inserted_students = inserted_enrollments = inserted_results = 0
skipped_subjects = set()
errors = []

print(f"Starting insertion for {len(data['students'])} students into school_id={SCHOOL_ID}...")

try:
    conn.begin()

    for i, student in enumerate(data['students'], 1):
        admno   = student['admission_no']
        sql_cls = student_class_sql.get(admno, '1')
        tidb_cls = CLASS_MAP.get(sql_cls, 400004)

        # Insert student
        cursor.execute(
            """INSERT INTO students
               (school_id, person_id, class_id, admission_no, status, created_at)
               VALUES (%s, 0, %s, %s, 'inactive', NOW())""",
            (SCHOOL_ID, tidb_cls, admno)
        )
        stu_id = cursor.lastrowid
        inserted_students += 1

        # Insert one enrollment per term
        for term_label in student.get('enrollment_terms', []):
            tid = TERM_MAP.get(term_label)
            if not tid:
                continue
            cursor.execute(
                """INSERT INTO enrollments
                   (student_id, class_id, academic_year_id, term_id, school_id,
                    status, enrollment_type, enrollment_date)
                   VALUES (%s, %s, %s, %s, %s, 'active', 'historical', '2025-01-01')""",
                (stu_id, tidb_cls, ACADEMIC_YEAR_ID, tid, SCHOOL_ID)
            )
            inserted_enrollments += 1

        # Insert class_results per subject per term
        for term_label, tdata in student.get('results', {}).items():
            tid = TERM_MAP.get(term_label)
            if not tid:
                continue
            for subj in tdata.get('subjects', []):
                sid = SUBJECT_MAP.get(subj['name'])
                if not sid:
                    skipped_subjects.add(subj['name'])
                    continue
                cursor.execute(
                    """INSERT INTO class_results
                       (student_id, class_id, subject_id, term_id, result_type_id,
                        score, grade, academic_year_id)
                       VALUES (%s, %s, %s, %s, %s, %s, %s, %s)""",
                    (stu_id, tidb_cls, sid, tid, RESULT_TYPE_ID,
                     float(subj['score']), subj['grade'], ACADEMIC_YEAR_ID)
                )
                inserted_results += 1

        if i % 50 == 0:
            print(f"  ... processed {i}/{len(data['students'])} students")

    conn.commit()
    print("\n✅ TRANSACTION COMMITTED SUCCESSFULLY")
    print(f"   School:          Northgate (school_id={SCHOOL_ID}, northgateschool@gmail.com)")
    print(f"   Students:        {inserted_students}")
    print(f"   Enrollments:     {inserted_enrollments}")
    print(f"   Class results:   {inserted_results}")
    if skipped_subjects:
        print(f"   Skipped subjects (no TiDB mapping): {skipped_subjects}")
    if errors:
        print(f"   Errors ({len(errors)}):")
        for e in errors[:10]:
            print(f"     - {e}")

except Exception as e:
    conn.rollback()
    print(f"\n❌ TRANSACTION ROLLED BACK: {e}")
    sys.exit(1)
finally:
    cursor.close()
    conn.close()

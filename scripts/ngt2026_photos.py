#!/usr/bin/env python3
"""
Northgate 2026 Photo Upload Script
- Reads northgate_2026_enrollment.json
- Matches photo_local filename to backup/northgate/uploads/
- Resizes images >5MB using Pillow
- Uploads to Cloudinary under northgate/students/
- Updates people.photo in TiDB for each matched student
"""
import json, os, io
import pymysql
import cloudinary
import cloudinary.uploader
from PIL import Image

SCHOOL_ID = 6
UPLOADS_DIR = 'backup/northgate/uploads'
CLOUDINARY_FOLDER = 'northgate/students'

# ── Cloudinary config ─────────────────────────────────────────────────────────
cloudinary.config(
    cloud_name='drg4idqod',
    api_key='827852269286954',
    api_secret='Nd-3GCBEStLoOUZQTWFi2V4xNGo',
)

# ── TiDB connection ───────────────────────────────────────────────────────────
DB = dict(
    host='gateway01.eu-central-1.prod.aws.tidbcloud.com',
    port=4000,
    user='2Trc8kJebpKLb1Z.root',
    password='QMNAOiP9J1rANv4Z',
    database='drais',
    ssl={'ssl_mode': 'REQUIRED'},
    charset='utf8mb4',
    autocommit=True,
)

MAX_BYTES = 5 * 1024 * 1024  # 5MB

def maybe_resize(path):
    """Return bytes to upload — resize if >5MB."""
    size = os.path.getsize(path)
    if size <= MAX_BYTES:
        with open(path, 'rb') as f:
            return f.read(), False

    # Resize: reduce to 1200px wide max, JPEG quality 80
    img = Image.open(path).convert('RGB')
    img.thumbnail((1200, 1200), Image.LANCZOS)
    buf = io.BytesIO()
    img.save(buf, format='JPEG', quality=80)
    data = buf.getvalue()
    # If still too big, lower quality further
    q = 70
    while len(data) > MAX_BYTES and q >= 40:
        buf = io.BytesIO()
        img.save(buf, format='JPEG', quality=q)
        data = buf.getvalue()
        q -= 10
    return data, True

def main():
    data = json.load(open('northgate_2026_enrollment.json'))
    students = data['enrolling']

    available_files = set(os.listdir(UPLOADS_DIR))

    conn = pymysql.connect(**DB)
    cur = conn.cursor()

    uploaded = 0
    skipped_missing = 0
    skipped_no_tidb = 0
    errors = 0

    for i, stu in enumerate(students):
        photo_local = stu.get('photo_local', '')
        if not photo_local:
            continue

        fname = photo_local.split('/')[-1]
        if fname not in available_files:
            skipped_missing += 1
            continue

        fpath = os.path.join(UPLOADS_DIR, fname)
        ngs_id = stu['ngs_id']

        # Find person_id via student → people
        cur.execute(
            "SELECT st.person_id FROM students st WHERE st.school_id=%s AND st.admission_no=%s",
            (SCHOOL_ID, ngs_id)
        )
        row = cur.fetchone()
        if not row:
            skipped_no_tidb += 1
            continue
        person_id = row[0]

        # Upload to Cloudinary
        try:
            img_bytes, resized = maybe_resize(fpath)
            public_id = f"{CLOUDINARY_FOLDER}/{fname.rsplit('.', 1)[0]}"
            result = cloudinary.uploader.upload(
                img_bytes,
                public_id=public_id,
                overwrite=True,
                resource_type='image',
            )
            url = result['secure_url']

            # Update people.photo_url
            cur.execute(
                "UPDATE people SET photo_url=%s WHERE id=%s",
                (url, person_id)
            )
            uploaded += 1
            flag = ' (resized)' if resized else ''
            print(f"[{i+1}/{len(students)}] {ngs_id} → {fname}{flag}")
        except Exception as e:
            errors += 1
            print(f"ERROR {ngs_id} ({fname}): {e}")

    cur.close()
    conn.close()

    print(f"\n=== Done ===")
    print(f"Uploaded & updated : {uploaded}")
    print(f"Missing from disk  : {skipped_missing}")
    print(f"Not in TiDB        : {skipped_no_tidb}")
    print(f"Errors             : {errors}")

if __name__ == '__main__':
    main()

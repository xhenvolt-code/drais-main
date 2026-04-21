-- =============================
-- DEMO SCHOOL INSERT (for testing login & onboarding)
-- =============================

-- 1️⃣ Insert a demo school
INSERT INTO schools (
  name, 
  legal_name, 
  short_code, 
  email, 
  phone, 
  currency, 
  address, 
  logo_url
) VALUES (
  'Albayan Quran Memorization Centre Nursery & Primary School',                   -- name
  'Albayan Quran Memorization Centre Nursery & Primary School Limited',    -- legal_name
  'ALB001',                                -- short_code
  'info@albayan.ac.ug',                    -- email
  '+256700123456',                         -- phone
  'UGX',                                   -- currency
  'Bugumba, Iganga, Uganda',           -- address
  'https://yourcdn.com/logos/albayan.png'  -- logo_url
);

-- 2️⃣ Insert a branch under that school
INSERT INTO branches (
  school_id,
  name,
  phone,
  email,
  address
) VALUES (
  1,                                       -- assumes first school ID = 1
  'Main Campus',
  '+256700123456',
  'main@albayan.ac.ug',
  'Bugumba, Iganga, Uganda'
);

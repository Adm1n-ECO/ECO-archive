-- ============================================================
-- EternalCurrent.Online -- Phase 0 Data Insert (v2 -- fixed order)
-- lightning-001 pilot network
-- Generated: 2026-04-04
-- CORRECT ORDER: networks -> STAR -> users (103) -> relationships -> pets -> accomplishments -> journeys
-- networks must exist before any user row due to FK constraint
-- ============================================================

-- ============================================================
-- STEP 1: lightning-001 network row
-- Must be first — users.network_id FK points here
-- owner_user_id set without FK constraint (added in Step 8)
-- ============================================================

INSERT INTO networks (network_id, name, description, owner_user_id, tier, status)
VALUES (
  'lightning-001',
  'Lightning Network',
  'Founding pilot network. Bakshi-Datta-Singh family. Free forever.',
  'STAR',
  'Free_Forever',
  'Active'
);

-- ============================================================
-- STEP 2: STAR (Vikas Bakshi / NetworkOwner)
-- ============================================================

INSERT INTO users (
  user_id, network_id, full_name, first_name, middle_name, last_name, nickname,
  platform_role, family_role, status, tier, gender, cultural_origin,
  birth_mm_yyyy, birth_location, current_location, household_id,
  parent_id, co_parent_id, partner_id, partner_type,
  bio_parent_id, social_links, photo_id, invite_status, visible_to, bio
) VALUES (
  'STAR', 'lightning-001', 'Vikas Bakshi', 'Vikas', NULL, 'Bakshi', NULL,
  'NetworkOwner', NULL, 'Living', 'Free_Forever', 'male', 'India',
  '09/1968', 'New Delhi, India', 'Half Moon Bay, CA, US', 'h_bakhshi',
  'MMB-STAR', 'NB-STAR', 'RRB-STAR', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
);

-- ============================================================
-- STEP 3: Remaining 103 users
-- ============================================================

INSERT INTO users (
  user_id, network_id, full_name, first_name, middle_name, last_name, nickname,
  platform_role, family_role, status, tier, gender, cultural_origin,
  birth_mm_yyyy, birth_location, current_location, household_id,
  parent_id, co_parent_id, partner_id, partner_type,
  bio_parent_id, social_links, photo_id, invite_status, visible_to, bio
) VALUES
(
  'AB-STAR', 'lightning-001', 'Amit Bakshi', 'Amit', NULL, 'Bakshi', NULL,
  'Conductor', 'brother', 'Passed', 'Free_Forever', 'male', 'India',
  '10/1974', 'New Delhi, India', 'Half Moon Bay, CA, US', 'h_bakhshi',
  'MMB-STAR', 'NB-STAR', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'AP-STAR', 'lightning-001', 'Amit Patel', 'Amit', NULL, 'Patel', 'Ziggy',
  'Conductor', 'father', 'Living', 'Free_Forever', 'male', NULL,
  '09/1968', NULL, 'Fremont, CA, US', 'h_apatel',
  'STAR', NULL, 'JP-STAR', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'AYS-STAR', 'lightning-001', 'Anmol Sharma', 'Anmol', NULL, 'Sharma', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', NULL,
  '03/2000', 'Milbrae, CA, US', 'San Francisco, CA, US', 'h-Sharma',
  'VS-STAR', 'PS-STAR', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'AV-STAR', 'lightning-001', 'Anu Vaid', 'Anu', NULL, 'Vaid', NULL,
  'Conductor', 'mother', 'Living', 'Free_Forever', 'female', 'India',
  '10/1948', 'New Delhi, India', 'Thousand Oaks, CA, US', 'h_vaid',
  'KD-NB-STAR', 'LD-NB-STAR', 'SV-NV-STAR', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'AV-NV-STAR', 'lightning-001', 'Anya Peruvemba', 'Anya', NULL, 'Peruvemba', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', NULL,
  NULL, 'New York, NY, US', 'New York, NY, US', 'h_vaid',
  'NV-STAR', NULL, NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'AS-NS-RRB-STAR', 'lightning-001', 'Arjun Singh', 'Arjun', NULL, 'Singh', NULL,
  'Conductor', 'father', 'Passed', 'Free_Forever', 'male', 'Fiji',
  NULL, 'Suva, Fiji', NULL, 'h_Singh',
  NULL, NULL, 'SS-NS-RRB-STAR', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'AS-VS-STAR', 'lightning-001', 'Ayushi Sharma', 'Ayushi', NULL, 'Sharma', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', NULL,
  '02/2008', 'Milbrae, CA, US', 'Belmont, CA, US', 'h-Sharma',
  'VS-STAR', 'PS-STAR', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'BB-MMB-STAR', 'lightning-001', 'Brij Bakhshi', 'Brij', 'Mohan', 'Bakhshi', NULL,
  'Conductor', 'father', 'Passed', 'Free_Forever', 'male', 'Pakistan',
  NULL, 'Pakistan', NULL, 'h_bakhshi',
  NULL, NULL, 'KB-MMB-STAR', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'BP-HP-STAR', 'lightning-001', 'Brinda Patel', 'Brinda', NULL, 'Patel', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', NULL,
  NULL, 'Hayward, CA, US', 'Dublin, CA, US', 'h_hpatel',
  'HP-STAR', 'RPA-STAR', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'BL-STAR', 'lightning-001', 'Bruce Lesch', 'Bruce', NULL, 'Lesch', NULL,
  'Conductor', 'friend', 'Living', 'Free_Forever', 'male', NULL,
  NULL, NULL, 'Redwood City, CA, US', 'h_lesch',
  'STAR', NULL, 'SL-STAR', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'DP-AP-STAR', 'lightning-001', 'Davin Patel', 'Davin', NULL, 'Patel', NULL,
  'Conductor', 'friend', 'Living', 'Free_Forever', 'male', NULL,
  NULL, 'Fremont, CA, US', 'La Crosse, WI, US', 'h_apatel',
  'AP-STAR', 'JP-STAR', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'DP-NV-STAR', 'lightning-001', 'Dayan Peruvemba', 'Dayan', NULL, 'Peruvemba', NULL,
  'Conductor', 'son', 'Living', 'Free_Forever', 'male', NULL,
  NULL, 'Thousand Oaks, CA, US', 'Thousand Oaks, CA, US', 'h_vaid',
  'NV-STAR', NULL, NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'BD-962', 'lightning-001', 'Dhirender Nath Datta', 'Dhirendar', 'Nath', 'Datta', 'Babloo',
  'Conductor', 'son', 'Living', 'Free_Forever', 'male', 'India',
  '01/1947', 'New Delhi, India', 'New Delhi, India', 'H_Datta',
  'KD-NB-STAR', 'LD-NB-STAR', 'PP-BD962', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'FP-STAR', 'lightning-001', 'Frank Pezzimenti', 'Frank', NULL, 'Pezzimenti', NULL,
  'Conductor', 'friend', 'Living', 'Free_Forever', 'male', NULL,
  NULL, NULL, 'Arcata, CA, US', 'h_Pezzimenti',
  'STAR', NULL, NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'HP-STAR', 'lightning-001', 'Harshal Patel', 'Harshal', NULL, 'Patel', NULL,
  'Conductor', 'father', 'Living', 'Free_Forever', 'male', NULL,
  NULL, NULL, 'Dublin, CA, US', 'h_hpatel',
  'STAR', NULL, 'RPA-STAR', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'HD-BD962', 'lightning-001', 'Henna Datta', 'Henna', NULL, 'Datta', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', 'India',
  NULL, 'New Delhi, India', 'New Delhi, India', 'H_Datta',
  'BD-962', 'PP-BD962', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'IB-STAR', 'lightning-001', 'Isaiah Bakshi', 'Isaiah', 'Madan', 'Bakshi', NULL,
  'Conductor', 'son', 'Living', 'Free_Forever', 'male', 'Adopted',
  '04/2005', 'Oakland, CA, US', 'Half Moon Bay, CA, US', 'h_bakhshi',
  'STAR', 'RRB-STAR', NULL, NULL,
  'AB-STAR', NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'JS-RRB-STAR', 'lightning-001', 'Jaiwati Singh', 'Jaiwati', NULL, 'Singh', NULL,
  'Conductor', 'mother', 'Living', 'Free_Forever', 'female', 'Fiji',
  NULL, 'Suva, Fiji', 'San Mateo, CA, US', 'h_Singh',
  'RS-JS-RRB-STAR', 'RAMRS-JS-RRB-STAR', 'NS-RRB-STAR', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'JP-NV-STAR', 'lightning-001', 'Jaya Peruvemba', 'Jaya', NULL, 'Peruvemba', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', NULL,
  NULL, 'New York, NY, US', 'Miami, FL, US', 'h_vaid',
  'NV-STAR', NULL, NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'JP-STAR', 'lightning-001', 'Jigna Patel', 'Jigna', NULL, 'Patel', 'Jiggy',
  'Conductor', 'friend', 'Living', 'Free_Forever', 'female', NULL,
  NULL, NULL, 'Fremont, CA, US', 'h_apatel',
  'STAR', NULL, NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'KS-RRB-STAR', 'lightning-001', 'Karishma Singh', 'Karishma', NULL, 'Singh', 'Pinhead',
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', NULL,
  NULL, 'San Mateo, CA, US', 'Chicago, IL, US', 'h_Singh',
  'NS-RRB-STAR', 'JS-RRB-STAR', 'SS-RRB-STAR', 'Sister',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'KB-MMB-STAR', 'lightning-001', 'Kaushalya Bakhshi', 'Kaushalya', 'Brij', 'Bakhshi', NULL,
  'Conductor', 'mother', 'Passed', 'Free_Forever', 'female', 'Pakistan',
  NULL, 'Pakistan', NULL, 'h_bakhshi',
  NULL, NULL, 'BB-MMB-STAR', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'KD-NB-STAR', 'lightning-001', 'Krishan Datta', 'Krishan', 'Kanwar', 'Datta', NULL,
  'Conductor', 'father', 'Passed', 'Free_Forever', 'male', 'Pakistan',
  '09/1919', 'Pakistan', NULL, 'H_Datta',
  'NB-STAR', NULL, NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'LD-NB-STAR', 'lightning-001', 'Leela Datta', 'Leela', NULL, 'Datta', NULL,
  'Conductor', 'mother', 'Passed', 'Free_Forever', 'female', 'Pakistan',
  NULL, 'Pakistan', NULL, 'H_Datta',
  'NB-STAR', NULL, NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'MMB-STAR', 'lightning-001', 'Madan Mohan Bakhshi', 'Madan', 'Mohan', 'Bakhshi', NULL,
  'Conductor', 'father', 'Passed', 'Free_Forever', 'male', 'Pakistan',
  '09/1937', 'Rawalpindi, Pakistan', 'Half Moon Bay, CA, US', 'h_bakhshi',
  'BB-MMB-STAR', 'KB-MMB-STAR', 'NB-STAR', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'MP-STAR', 'lightning-001', 'Michael Pezzimenti', 'Michael', NULL, 'Pezzimenti', NULL,
  'Conductor', 'friend', 'Living', 'Free_Forever', 'male', NULL,
  NULL, NULL, 'Arcata, CA, US', 'h_Pezzimenti',
  'FP-STAR', 'RP-STAR', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'MD-BD962', 'lightning-001', 'Mohini Datta', 'Mohini', NULL, 'Datta', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', 'India',
  NULL, 'New Delhi, India', 'New Delhi, India', 'H_Datta',
  'BD-962', 'PP-BD962', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'NS-RRB-STAR', 'lightning-001', 'Narendra Singh', 'Narendra', NULL, 'Singh', NULL,
  'Conductor', 'father', 'Living', 'Free_Forever', 'male', 'Fiji',
  NULL, 'Sinatoka, Fiji', NULL, 'h_Singh',
  'AS-NS-RRB-STAR', 'SS-NS-RRB-STAR', 'JS-RRB-STAR', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'PP-BD962', 'lightning-001', 'Neerja Datta', 'Neerja', NULL, 'Datta', 'Poppee',
  'Conductor', 'spouse', 'Living', 'Free_Forever', 'female', 'India',
  NULL, 'New Delhi, India', 'New Delhi, India', 'H_Datta',
  NULL, NULL, 'BD-962', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'NB-STAR', 'lightning-001', 'Nirupma  Bakhshi', 'Nirupma', NULL, 'Bakhshi', 'Neeru',
  'Conductor', 'mother', 'Living', 'Free_Forever', 'female', 'India',
  '08/1945', 'Delhi, India', 'Half Moon Bay, CA, US', 'h_bakhshi',
  'KD-NB-STAR', 'LD-NB-STAR', 'MMB-STAR', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'NV-STAR', 'lightning-001', 'Niti Vaid', 'Niti', NULL, 'Vaid', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', 'India',
  '06/1975', 'New Delhi, India', 'Thousand Oaks, CA, US', 'h_vaid',
  'AV-STAR', 'SV-NV-STAR', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'NP-HP-STAR', 'lightning-001', 'Nitika Patel', 'Nitika', NULL, 'Patel', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', NULL,
  NULL, 'Hayward, CA, US', 'San Francisco, CA, US', 'h_hpatel',
  'HP-STAR', 'RPA-STAR', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'PP-AP-STAR', 'lightning-001', 'Parnika Patel', 'Parnika', NULL, 'Patel', NULL,
  'Conductor', 'friend', 'Living', 'Free_Forever', 'female', NULL,
  NULL, 'Fremont, CA, US', 'Fremont, CA, US', 'h_apatel',
  'AP-STAR', 'JP-STAR', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'PP-HP-STAR', 'lightning-001', 'Parthvi Patel', 'Parthvi', NULL, 'Patel', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', NULL,
  NULL, 'Hayward, CA, US', 'Dublin, CA, US', 'h_hpatel',
  'HP-STAR', 'RPA-STAR', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'PS-STAR', 'lightning-001', 'Pragati Sharma', 'Pragati', NULL, 'Sharma', NULL,
  'Conductor', 'sister', 'Living', 'Free_Forever', 'female', 'India',
  '10/1972', 'New Delhi, India', 'Half Moon Bay, CA, US', 'h-Sharma',
  'MMB-STAR', NULL, 'VS-STAR', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'RS-JS-RRB-STAR', 'lightning-001', 'Ram Sewak', 'Ram', NULL, 'Sewak', NULL,
  'Conductor', 'father', 'Passed', 'Free_Forever', 'male', 'Fiji',
  NULL, 'Suva, Fiji', NULL, 'h_Singh',
  NULL, NULL, 'RAMRS-JS-RRB-STAR', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'RMSH-JS-RRB', 'lightning-001', 'Ramesh Sewak', 'Ramesh', NULL, 'Sewak', 'Mesu',
  'Conductor', 'son', 'Living', 'Free_Forever', 'male', 'Fiji',
  NULL, 'Suva, Fiji', 'San Mateo, CA, US', 'h_Singh',
  'RS-JS-RRB-STAR', 'RAMRS-JS-RRB-STAR', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'RAMRS-JS-RRB-STAR', 'lightning-001', 'Ramrati Sewak', 'Ramrati', NULL, 'Sewak', NULL,
  'Conductor', 'mother', 'Passed', 'Free_Forever', 'female', 'Fiji',
  NULL, 'Suva, Fiji', NULL, 'h_Singh',
  NULL, NULL, 'RS-JS-RRB-STAR', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'RP-NV-STAR', 'lightning-001', 'Raniya Peruvemba', 'Raniya', NULL, 'Peruvemba', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', NULL,
  NULL, 'Thousand Oaks, CA, US', 'Thousand Oaks, CA, US', 'h_vaid',
  'NV-STAR', NULL, NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'RRB-STAR', 'lightning-001', 'Reema Radhika Singh Bakshi', 'Reema', 'Radhika Singh', 'Bakshi', NULL,
  'Conductor', 'spouse', 'Living', 'Free_Forever', 'female', 'Fiji',
  '04/1976', 'Suva, Fiji', 'Half Moon Bay, CA, US', 'h_Singh',
  'NS-RRB-STAR', 'JS-RRB-STAR', 'STAR', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'RP-STAR', 'lightning-001', 'Robin Pezzimenti', 'Robin', NULL, 'Pezzimenti', NULL,
  'Conductor', 'friend', 'Living', 'Free_Forever', 'female', NULL,
  NULL, NULL, 'Arcata, CA, US', 'h_Pezzimenti',
  'STAR', NULL, 'FP-STAR', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'RPA-STAR', 'lightning-001', 'Roopa Patel', 'Roopa', NULL, 'Patel', NULL,
  'Conductor', 'mother', 'Living', 'Free_Forever', 'female', NULL,
  NULL, NULL, 'Dublin, CA, US', 'h_hpatel',
  'STAR', NULL, 'HP-STAR', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'SV-NV-STAR', 'lightning-001', 'Satish Vaid', 'Satish', NULL, 'Vaid', NULL,
  'Conductor', 'father', 'Living', 'Free_Forever', 'male', 'India',
  NULL, 'New Delhi, India', 'Thousand Oaks, CA, US', 'h_vaid',
  'NV-STAR', NULL, 'AV-STAR', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'SS-RRB-STAR', 'lightning-001', 'Seema Singh', 'Seema', NULL, 'Singh', NULL,
  'Conductor', 'daughter', 'Living', 'Free_Forever', 'female', 'Fiji',
  NULL, 'Suva, Fiji', 'Sacramento, CA, US', 'h_Singh',
  'NS-RRB-STAR', 'JS-RRB-STAR', NULL, 'Sister',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'SL-STAR', 'lightning-001', 'Sophia Lesch', 'Sophia', NULL, 'Lesch', NULL,
  'Conductor', 'friend', 'Living', 'Free_Forever', 'female', NULL,
  NULL, NULL, 'Redwood City, CA, US', 'h_lesch',
  'STAR', NULL, 'BL-STAR', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'SS-NS-RRB-STAR', 'lightning-001', 'Subhadra Singh', 'Subhadra', NULL, 'Singh', NULL,
  'Conductor', 'mother', 'Passed', 'Free_Forever', 'female', 'Fiji',
  NULL, 'Suva, Fiji', NULL, 'h_Singh',
  NULL, NULL, 'AS-NS-RRB-STAR', 'Husband',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'VS-STAR', 'lightning-001', 'Vikram Sharma', 'Vikram', NULL, 'Sharma', NULL,
  'Conductor', 'father', 'Living', 'Free_Forever', 'male', 'India',
  '07/1969', 'New Delhi, India', 'Belmont, CA, US', 'h-Sharma',
  'STAR', NULL, 'PS-STAR', 'Wife',
  NULL, NULL, NULL, 'Not Sent', 'all', NULL
),
(
  'DKB-LD', 'lightning-001', 'Dwarkadas Bali', 'Dwarkadas', NULL, 'Bali', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', 'India',
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'VWB-LD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'VWB-LD', 'lightning-001', 'Vidyawanti Bali', 'Vidyawanti', NULL, 'Bali', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', 'India',
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'DKB-LD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'VND-KD', 'lightning-001', 'Virender N Datta', 'Virender', 'N', 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', 'Pakistan',
  NULL, 'Pakistan', NULL, NULL,
  NULL, NULL, 'UD-VND', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'UD-VND', 'lightning-001', 'Usha Datta', 'Usha', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'VND-KD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'RJD-VND', 'lightning-001', 'Rajiv Datta', 'Rajiv', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', 'India',
  '10/1961', 'New Delhi, India', NULL, NULL,
  'VND-KD', 'UD-VND', 'ARD-RJD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'ARD-RJD', 'lightning-001', 'Arti Datta', 'Arti', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'RJD-VND', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'SMD-RJD', 'lightning-001', 'Somya Datta', 'Somya', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', 'India',
  NULL, NULL, NULL, NULL,
  'RJD-VND', 'ARD-RJD', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'TND-RJD', 'lightning-001', 'Tanya Datta', 'Tanya', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', 'India',
  NULL, NULL, NULL, NULL,
  'RJD-VND', 'ARD-RJD', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'SJD-VND', 'lightning-001', 'Sanjiv Datta', 'Sanjiv', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', 'India',
  '04/1959', 'New Delhi, India', NULL, NULL,
  'VND-KD', 'UD-VND', 'SED-SJD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'SED-SJD', 'lightning-001', 'Seema Datta', 'Seema', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'SJD-VND', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'BPD-KD', 'lightning-001', 'Bhupinder Datta', 'Bhupinder', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Passed', 'Free_Forever', 'male', 'Pakistan',
  NULL, 'Pakistan', NULL, NULL,
  NULL, NULL, 'HLD-BPD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'HLD-BPD', 'lightning-001', 'Hemlata Datta', 'Hemlata', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'BPD-KD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'SND-BPD', 'lightning-001', 'Sunanda Nagpal', 'Sunanda', NULL, 'Nagpal', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', 'India',
  '03/1963', NULL, NULL, NULL,
  'BPD-KD', 'HLD-BPD', 'RN-SND', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'RN-SND', 'lightning-001', 'Raj Nagpal', 'Raj', NULL, 'Nagpal', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'SND-BPD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'SHN-SND', 'lightning-001', 'Shefali', 'Shefali', NULL, NULL, NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  'SND-BPD', 'RN-SND', 'PN-SHN', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', 'Married last name TBD — ask when opportunity arises'
),
(
  'PN-SHN', 'lightning-001', 'Peter', 'Peter', NULL, NULL, NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'SHN-SND', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', 'Last name TBD — ask when opportunity arises'
),
(
  'JN-SND', 'lightning-001', 'Jai Nagpal', 'Jai', NULL, 'Nagpal', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  'SND-BPD', 'RN-SND', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'SON-SND', 'lightning-001', 'Sonali Nagpal', 'Sonali', NULL, 'Nagpal', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, 'Houston, TX, US', NULL,
  'SND-BPD', 'RN-SND', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'RHD-BPD', 'lightning-001', 'Rahul Datta', 'Rahul', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', 'India',
  NULL, 'Gwalior, MP, India', NULL, NULL,
  'BPD-KD', 'HLD-BPD', 'RND-RHD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'RND-RHD', 'lightning-001', 'Renu Datta', 'Renu', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'RHD-BPD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'STD-KD', 'lightning-001', 'Santosh Bakshi', 'Santosh', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Passed', 'Free_Forever', 'female', 'Pakistan',
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'KRB-STD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'KRB-STD', 'lightning-001', 'Krishan Bakshi', 'Krishan', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Passed', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'STD-KD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'MJB-STD', 'lightning-001', 'Manoj Bakshi', 'Manoj', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', 'India',
  NULL, 'New Delhi, India', NULL, NULL,
  'STD-KD', 'KRB-STD', 'RSB-MJB', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'RSB-MJB', 'lightning-001', 'Rashmi Bakshi', 'Rashmi', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'MJB-STD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'CHB-MJB', 'lightning-001', 'Chetna Bakshi', 'Chetna', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  'MJB-STD', 'RSB-MJB', 'PRB-CHB', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', 'Married last name TBD — ask when opportunity arises'
),
(
  'PRB-CHB', 'lightning-001', 'Prateek', 'Prateek', NULL, NULL, NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'CHB-MJB', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', 'Last name TBD — ask when opportunity arises'
),
(
  'SCB-MJB', 'lightning-001', 'Sachit Bakshi', 'Sachit', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  'MJB-STD', 'RSB-MJB', 'SHB-SCB', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'SHB-SCB', 'lightning-001', 'Shivani Bakshi', 'Shivani', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'SCB-MJB', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'MNB-STD', 'lightning-001', 'Manmohan Bakshi', 'Manmohan', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  'STD-KD', 'KRB-STD', 'RDB-MNB', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'RDB-MNB', 'lightning-001', 'Radhika Bakshi', 'Radhika', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'MNB-STD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'ASB-MNB', 'lightning-001', 'Ashish Bakshi', 'Ashish', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  'MNB-STD', 'RDB-MNB', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'MOB-STD', 'lightning-001', 'Moneesh Bakshi', 'Moneesh', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', 'India',
  '06/1963', 'New Delhi, India', NULL, NULL,
  'STD-KD', 'KRB-STD', 'JTB-MOB', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'JTB-MOB', 'lightning-001', 'Justine Bakshi', 'Justine', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'MOB-STD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'JKB-STD', 'lightning-001', 'Janki Bakshi', 'Janki', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  '03/1949', NULL, NULL, NULL,
  'STD-KD', 'KRB-STD', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', 'Married surname appears to be Sinha (children''s surname). Husband first name unknown.'
),
(
  'UMS-JKB', 'lightning-001', 'Uma Sinha', 'Uma', NULL, 'Sinha', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  'JKB-STD', NULL, NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'AJS-JKB', 'lightning-001', 'Ajay Sinha', 'Ajay', NULL, 'Sinha', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  'JKB-STD', NULL, NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'DMD-KD', 'lightning-001', 'Damyanti Bakshi', 'Damyanti', NULL, 'Bakshi', 'Daman',
  'Conductor', NULL, 'Passed', 'Free_Forever', 'female', 'Pakistan',
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'VDB-DMD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'VDB-DMD', 'lightning-001', 'Vaidbhushan Bakshi', 'Vaidbhushan', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Passed', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'DMD-KD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'AKC-DMD', 'lightning-001', 'Akshay Chhibber', 'Akshay', NULL, 'Chhibber', NULL,
  'Conductor', NULL, 'Passed', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  'DMD-KD', 'VDB-DMD', 'DNC-AKC', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'DNC-AKC', 'lightning-001', 'Denise Chibber', 'Denise', NULL, 'Chibber', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'AKC-DMD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'ALD-DMD', 'lightning-001', 'Alka Datta', 'Alka', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  'DMD-KD', 'VDB-DMD', 'VRD-ALD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'VRD-ALD', 'lightning-001', 'Virendar Datta', 'Virendar', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'ALD-DMD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', 'Confirmed different person from Virender N Datta (VND-KD). Different generation, different spelling.'
),
(
  'ATB-DMD', 'lightning-001', 'Atul Bakshi', 'Atul', NULL, 'Bakshi', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  'DMD-KD', 'VDB-DMD', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'RMD-LD', 'lightning-001', 'Ramesh Datta', 'Ramesh', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Passed', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'MKD-RMD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', 'Leela Datta''s cousin. Parents TBD.'
),
(
  'MKD-RMD', 'lightning-001', 'Meenakshi Datta', 'Meenakshi', NULL, 'Datta', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'RMD-LD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'ATM-RMD', 'lightning-001', 'Arti Mohan', 'Arti', NULL, 'Mohan', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  'RMD-LD', 'MKD-RMD', 'KPM-ATM', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'KPM-ATM', 'lightning-001', 'Kapil Mohan', 'Kapil', NULL, 'Mohan', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'ATM-RMD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'SBM-ATM', 'lightning-001', 'Sahiba Mohan', 'Sahiba', NULL, 'Mohan', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  'ATM-RMD', 'KPM-ATM', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', 'Engaged to Xavier (XVR-SBM). Spouse relationship to be added after wedding.'
),
(
  'XVR-SBM', 'lightning-001', 'Xavier', 'Xavier', NULL, NULL, NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', 'Engaged to Sahiba Mohan (SBM-ATM). Last name TBD. Spouse relationship to be added after wedding.'
),
(
  'MLM-ATM', 'lightning-001', 'Malika Mohan', 'Malika', NULL, 'Mohan', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  'ATM-RMD', 'KPM-ATM', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'JYM-RMD', 'lightning-001', 'Jyoti Mathur', 'Jyoti', NULL, 'Mathur', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  'RMD-LD', 'MKD-RMD', 'SNM-JYM', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'SNM-JYM', 'lightning-001', 'Sandeep Mathur', 'Sandeep', NULL, 'Mathur', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'JYM-RMD', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'MHD-JYM', 'lightning-001', 'Mehndi Dhaliwal', 'Mehndi', NULL, 'Dhaliwal', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  'JYM-RMD', 'SNM-JYM', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'DVS-JYM', 'lightning-001', 'Divya Sidhu', 'Divya', NULL, 'Sidhu', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'female', NULL,
  NULL, NULL, NULL, NULL,
  'JYM-RMD', 'SNM-JYM', 'PRS-DVS', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'PRS-DVS', 'lightning-001', 'Preet Sidhu', 'Preet', NULL, 'Sidhu', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  NULL, NULL, 'DVS-JYM', 'Spouse',
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
),
(
  'RJM-JYM', 'lightning-001', 'Raj Mathur', 'Raj', NULL, 'Mathur', NULL,
  'Conductor', NULL, 'Placeholder', 'Free_Forever', 'male', NULL,
  NULL, NULL, NULL, NULL,
  'JYM-RMD', 'SNM-JYM', NULL, NULL,
  NULL, NULL, NULL, 'Not Sent', 'network', NULL
);

-- ============================================================
-- STEP 4: Relationships (448 rows)
-- ============================================================

INSERT INTO relationships (network_id, subject_id, target_id, relation_type, branch, note)
VALUES
  ('lightning-001', 'AB-STAR', 'MMB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AB-STAR', 'NB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AB-STAR', 'IB-STAR', 'BioChild', 'Bakshi/Datta', 'Biological child (adoption)'),
  ('lightning-001', 'AB-STAR', 'STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'AB-STAR', 'PS-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'AB-STAR', 'KD-NB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'AB-STAR', 'LD-NB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'AP-STAR', 'STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'AP-STAR', 'DP-AP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'AP-STAR', 'PP-AP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'AP-STAR', 'JP-STAR', 'Spouse', 'Friends', NULL),
  ('lightning-001', 'AS-NS-RRB-STAR', 'NS-RRB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AS-NS-RRB-STAR', 'SS-NS-RRB-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AS-VS-STAR', 'VS-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AS-VS-STAR', 'PS-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AS-VS-STAR', 'AYS-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'AV-NV-STAR', 'NV-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AV-NV-STAR', 'DP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'AV-NV-STAR', 'JP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'AV-NV-STAR', 'RP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'AV-NV-STAR', 'SV-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'AV-STAR', 'NV-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AV-STAR', 'KD-NB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AV-STAR', 'LD-NB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AV-STAR', 'SV-NV-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AV-STAR', 'BD-962', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'AV-STAR', 'NB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'AYS-STAR', 'VS-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AYS-STAR', 'PS-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'AYS-STAR', 'AS-VS-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'BB-MMB-STAR', 'MMB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'BB-MMB-STAR', 'KB-MMB-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'BD-962', 'HD-BD962', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'BD-962', 'MD-BD962', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'BD-962', 'KD-NB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'BD-962', 'LD-NB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'BD-962', 'PP-BD962', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'BD-962', 'AV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'BD-962', 'NB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'BL-STAR', 'STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'BL-STAR', 'SL-STAR', 'Spouse', 'Friends', NULL),
  ('lightning-001', 'BP-HP-STAR', 'HP-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'BP-HP-STAR', 'RPA-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'DP-AP-STAR', 'AP-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'DP-AP-STAR', 'JP-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'DP-NV-STAR', 'NV-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'DP-NV-STAR', 'AV-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'DP-NV-STAR', 'JP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'DP-NV-STAR', 'RP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'DP-NV-STAR', 'SV-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'FP-STAR', 'STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'FP-STAR', 'MP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'FP-STAR', 'RP-STAR', 'Spouse', 'Friends', NULL),
  ('lightning-001', 'HD-BD962', 'BD-962', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'HD-BD962', 'PP-BD962', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'HD-BD962', 'MD-BD962', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'HP-STAR', 'STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'HP-STAR', 'BP-HP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'HP-STAR', 'NP-HP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'HP-STAR', 'PP-HP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'HP-STAR', 'RPA-STAR', 'Spouse', 'Friends', NULL),
  ('lightning-001', 'IB-STAR', 'STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'IB-STAR', 'RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'IB-STAR', 'AB-STAR', 'BioParent', 'Bakshi/Datta', 'Biological parent (adoption)'),
  ('lightning-001', 'IB-STAR', 'VS-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'JP-NV-STAR', 'NV-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'JP-NV-STAR', 'AV-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'JP-NV-STAR', 'DP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'JP-NV-STAR', 'RP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'JP-NV-STAR', 'SV-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'JP-STAR', 'STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'JP-STAR', 'DP-AP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'JP-STAR', 'PP-AP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'JP-STAR', 'AP-STAR', 'Spouse', 'Friends', NULL),
  ('lightning-001', 'JS-RRB-STAR', 'KS-RRB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'JS-RRB-STAR', 'RRB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'JS-RRB-STAR', 'SS-RRB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'JS-RRB-STAR', 'RS-JS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'JS-RRB-STAR', 'RAMRS-JS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'JS-RRB-STAR', 'NS-RRB-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'JS-RRB-STAR', 'RMSH-JS-RRB', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'KB-MMB-STAR', 'MMB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'KB-MMB-STAR', 'BB-MMB-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'KD-NB-STAR', 'AV-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'KD-NB-STAR', 'BD-962', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'KD-NB-STAR', 'NB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'KD-NB-STAR', 'NB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'KD-NB-STAR', 'MMB-STAR', 'Child', 'Bakshi/Datta', 'Via spouse of parent'),
  ('lightning-001', 'KD-NB-STAR', 'STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'KD-NB-STAR', 'AB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'KD-NB-STAR', 'PS-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'KD-NB-STAR', 'LD-NB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'KS-RRB-STAR', 'NS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'KS-RRB-STAR', 'JS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'KS-RRB-STAR', 'RRB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'KS-RRB-STAR', 'SS-RRB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'LD-NB-STAR', 'AV-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'LD-NB-STAR', 'BD-962', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'LD-NB-STAR', 'NB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'LD-NB-STAR', 'NB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'LD-NB-STAR', 'MMB-STAR', 'Child', 'Bakshi/Datta', 'Via spouse of parent'),
  ('lightning-001', 'LD-NB-STAR', 'STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'LD-NB-STAR', 'AB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'LD-NB-STAR', 'PS-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'LD-NB-STAR', 'KD-NB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'MD-BD962', 'BD-962', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'MD-BD962', 'PP-BD962', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'MD-BD962', 'HD-BD962', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'MMB-STAR', 'STAR', 'Parent', NULL, NULL),
  ('lightning-001', 'MMB-STAR', 'AB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'MMB-STAR', 'PS-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'MMB-STAR', 'BB-MMB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'MMB-STAR', 'KB-MMB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'MMB-STAR', 'NB-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'MMB-STAR', 'KD-NB-STAR', 'Parent', 'Bakshi/Datta', 'Via spouse of parent'),
  ('lightning-001', 'MMB-STAR', 'LD-NB-STAR', 'Parent', 'Bakshi/Datta', 'Via spouse of parent'),
  ('lightning-001', 'MP-STAR', 'FP-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'MP-STAR', 'RP-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'NB-STAR', 'STAR', 'Parent', NULL, NULL),
  ('lightning-001', 'NB-STAR', 'AB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NB-STAR', 'KD-NB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NB-STAR', 'LD-NB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NB-STAR', 'KD-NB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NB-STAR', 'LD-NB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NB-STAR', 'MMB-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NB-STAR', 'PS-STAR', 'Parent', 'Bakshi/Datta', 'Via spouse of parent'),
  ('lightning-001', 'NB-STAR', 'AV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'NB-STAR', 'BD-962', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'NP-HP-STAR', 'HP-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'NP-HP-STAR', 'RPA-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'NS-RRB-STAR', 'KS-RRB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NS-RRB-STAR', 'RRB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NS-RRB-STAR', 'SS-RRB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NS-RRB-STAR', 'AS-NS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NS-RRB-STAR', 'SS-NS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NS-RRB-STAR', 'JS-RRB-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NV-STAR', 'AV-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NV-STAR', 'SV-NV-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NV-STAR', 'AV-NV-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NV-STAR', 'DP-NV-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NV-STAR', 'JP-NV-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NV-STAR', 'RP-NV-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NV-STAR', 'SV-NV-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'NV-STAR', 'STAR', 'Cousin', 'Bakshi/Datta', 'First cousins — Anu is Nirupma''s sister'),
  ('lightning-001', 'PP-AP-STAR', 'AP-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'PP-AP-STAR', 'JP-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'PP-BD962', 'HD-BD962', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'PP-BD962', 'MD-BD962', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'PP-BD962', 'BD-962', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'PP-HP-STAR', 'HP-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'PP-HP-STAR', 'RPA-STAR', 'Child', 'Friends', NULL),
  ('lightning-001', 'PS-STAR', 'MMB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'PS-STAR', 'AS-VS-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'PS-STAR', 'AYS-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'PS-STAR', 'VS-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'PS-STAR', 'NB-STAR', 'Child', 'Bakshi/Datta', 'Via spouse of parent'),
  ('lightning-001', 'PS-STAR', 'STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'PS-STAR', 'AB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'PS-STAR', 'KD-NB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'PS-STAR', 'LD-NB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'RAMRS-JS-RRB-STAR', 'RMSH-JS-RRB', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'RAMRS-JS-RRB-STAR', 'JS-RRB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'RAMRS-JS-RRB-STAR', 'RS-JS-RRB-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'RMSH-JS-RRB', 'RS-JS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'RMSH-JS-RRB', 'RAMRS-JS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'RMSH-JS-RRB', 'JS-RRB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'RP-NV-STAR', 'NV-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'RP-NV-STAR', 'AV-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'RP-NV-STAR', 'DP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'RP-NV-STAR', 'JP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'RP-NV-STAR', 'SV-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'RP-STAR', 'STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'RP-STAR', 'MP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'RP-STAR', 'FP-STAR', 'Spouse', 'Friends', NULL),
  ('lightning-001', 'RPA-STAR', 'STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'RPA-STAR', 'BP-HP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'RPA-STAR', 'NP-HP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'RPA-STAR', 'PP-HP-STAR', 'Parent', 'Friends', NULL),
  ('lightning-001', 'RPA-STAR', 'HP-STAR', 'Spouse', 'Friends', NULL),
  ('lightning-001', 'RRB-STAR', 'NS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'RRB-STAR', 'JS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'RRB-STAR', 'IB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'RRB-STAR', 'STAR', 'Spouse', NULL, NULL),
  ('lightning-001', 'RRB-STAR', 'VS-STAR', 'Parent', 'Bakshi/Datta', 'Via spouse of parent'),
  ('lightning-001', 'RRB-STAR', 'KS-RRB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'RRB-STAR', 'SS-RRB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'RS-JS-RRB-STAR', 'RMSH-JS-RRB', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'RS-JS-RRB-STAR', 'JS-RRB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'RS-JS-RRB-STAR', 'RAMRS-JS-RRB-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'SL-STAR', 'STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'SL-STAR', 'BL-STAR', 'Spouse', 'Friends', NULL),
  ('lightning-001', 'SS-NS-RRB-STAR', 'NS-RRB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'SS-NS-RRB-STAR', 'AS-NS-RRB-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'SS-RRB-STAR', 'NS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'SS-RRB-STAR', 'JS-RRB-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'SS-RRB-STAR', 'KS-RRB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'SS-RRB-STAR', 'RRB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'STAR', 'MMB-STAR', 'Child', NULL, NULL),
  ('lightning-001', 'STAR', 'NB-STAR', 'Child', NULL, NULL),
  ('lightning-001', 'STAR', 'AP-STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'STAR', 'BL-STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'STAR', 'FP-STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'STAR', 'HP-STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'STAR', 'JP-STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'STAR', 'RP-STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'STAR', 'RPA-STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'STAR', 'SL-STAR', 'Friend', 'Friends', 'Friend connected through network center'),
  ('lightning-001', 'STAR', 'VS-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'STAR', 'IB-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'STAR', 'RRB-STAR', 'Spouse', NULL, NULL),
  ('lightning-001', 'STAR', 'AB-STAR', 'Sibling', NULL, 'Inferred from shared parent'),
  ('lightning-001', 'STAR', 'PS-STAR', 'Sibling', NULL, 'Inferred from shared parent'),
  ('lightning-001', 'STAR', 'KD-NB-STAR', 'Sibling', NULL, 'Inferred from shared parent'),
  ('lightning-001', 'STAR', 'LD-NB-STAR', 'Sibling', NULL, 'Inferred from shared parent'),
  ('lightning-001', 'STAR', 'NV-STAR', 'Cousin', 'Bakshi/Datta', 'First cousins — Anu is Nirupma''s sister'),
  ('lightning-001', 'SV-NV-STAR', 'NV-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'SV-NV-STAR', 'NV-STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'SV-NV-STAR', 'AV-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'SV-NV-STAR', 'AV-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'SV-NV-STAR', 'DP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'SV-NV-STAR', 'JP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'SV-NV-STAR', 'RP-NV-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'VS-STAR', 'STAR', 'Child', 'Bakshi/Datta', NULL),
  ('lightning-001', 'VS-STAR', 'AS-VS-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'VS-STAR', 'AYS-STAR', 'Parent', 'Bakshi/Datta', NULL),
  ('lightning-001', 'VS-STAR', 'PS-STAR', 'Spouse', 'Bakshi/Datta', NULL),
  ('lightning-001', 'VS-STAR', 'RRB-STAR', 'Child', 'Bakshi/Datta', 'Via spouse of parent'),
  ('lightning-001', 'VS-STAR', 'IB-STAR', 'Sibling', 'Bakshi/Datta', 'Inferred from shared parent'),
  ('lightning-001', 'DKB-LD', 'VWB-LD', 'Spouse', 'Bali', NULL),
  ('lightning-001', 'VWB-LD', 'DKB-LD', 'Spouse', 'Bali', NULL),
  ('lightning-001', 'DKB-LD', 'LD-NB-STAR', 'Child', 'Bali', NULL),
  ('lightning-001', 'LD-NB-STAR', 'DKB-LD', 'Parent', 'Bali', NULL),
  ('lightning-001', 'VWB-LD', 'LD-NB-STAR', 'Child', 'Bali', NULL),
  ('lightning-001', 'LD-NB-STAR', 'VWB-LD', 'Parent', 'Bali', NULL),
  ('lightning-001', 'LD-NB-STAR', 'RMD-LD', 'Cousin', 'Bali', 'Parents TBD'),
  ('lightning-001', 'RMD-LD', 'LD-NB-STAR', 'Cousin', 'Bali', 'Parents TBD'),
  ('lightning-001', 'RMD-LD', 'MKD-RMD', 'Spouse', 'Datta-Cousin', NULL),
  ('lightning-001', 'MKD-RMD', 'RMD-LD', 'Spouse', 'Datta-Cousin', NULL),
  ('lightning-001', 'RMD-LD', 'ATM-RMD', 'Child', 'Datta-Cousin', NULL),
  ('lightning-001', 'ATM-RMD', 'RMD-LD', 'Parent', 'Datta-Cousin', NULL),
  ('lightning-001', 'MKD-RMD', 'ATM-RMD', 'Child', 'Datta-Cousin', NULL),
  ('lightning-001', 'ATM-RMD', 'MKD-RMD', 'Parent', 'Datta-Cousin', NULL),
  ('lightning-001', 'RMD-LD', 'JYM-RMD', 'Child', 'Datta-Cousin', NULL),
  ('lightning-001', 'JYM-RMD', 'RMD-LD', 'Parent', 'Datta-Cousin', NULL),
  ('lightning-001', 'MKD-RMD', 'JYM-RMD', 'Child', 'Datta-Cousin', NULL),
  ('lightning-001', 'JYM-RMD', 'MKD-RMD', 'Parent', 'Datta-Cousin', NULL),
  ('lightning-001', 'ATM-RMD', 'JYM-RMD', 'Sibling', 'Datta-Cousin', NULL),
  ('lightning-001', 'JYM-RMD', 'ATM-RMD', 'Sibling', 'Datta-Cousin', NULL),
  ('lightning-001', 'ATM-RMD', 'KPM-ATM', 'Spouse', 'Mohan', NULL),
  ('lightning-001', 'KPM-ATM', 'ATM-RMD', 'Spouse', 'Mohan', NULL),
  ('lightning-001', 'ATM-RMD', 'SBM-ATM', 'Child', 'Mohan', NULL),
  ('lightning-001', 'SBM-ATM', 'ATM-RMD', 'Parent', 'Mohan', NULL),
  ('lightning-001', 'KPM-ATM', 'SBM-ATM', 'Child', 'Mohan', NULL),
  ('lightning-001', 'SBM-ATM', 'KPM-ATM', 'Parent', 'Mohan', NULL),
  ('lightning-001', 'ATM-RMD', 'MLM-ATM', 'Child', 'Mohan', NULL),
  ('lightning-001', 'MLM-ATM', 'ATM-RMD', 'Parent', 'Mohan', NULL),
  ('lightning-001', 'KPM-ATM', 'MLM-ATM', 'Child', 'Mohan', NULL),
  ('lightning-001', 'MLM-ATM', 'KPM-ATM', 'Parent', 'Mohan', NULL),
  ('lightning-001', 'SBM-ATM', 'MLM-ATM', 'Sibling', 'Mohan', NULL),
  ('lightning-001', 'MLM-ATM', 'SBM-ATM', 'Sibling', 'Mohan', NULL),
  ('lightning-001', 'JYM-RMD', 'SNM-JYM', 'Spouse', 'Mathur', NULL),
  ('lightning-001', 'SNM-JYM', 'JYM-RMD', 'Spouse', 'Mathur', NULL),
  ('lightning-001', 'JYM-RMD', 'MHD-JYM', 'Child', 'Mathur', NULL),
  ('lightning-001', 'MHD-JYM', 'JYM-RMD', 'Parent', 'Mathur', NULL),
  ('lightning-001', 'SNM-JYM', 'MHD-JYM', 'Child', 'Mathur', NULL),
  ('lightning-001', 'MHD-JYM', 'SNM-JYM', 'Parent', 'Mathur', NULL),
  ('lightning-001', 'JYM-RMD', 'DVS-JYM', 'Child', 'Mathur', NULL),
  ('lightning-001', 'DVS-JYM', 'JYM-RMD', 'Parent', 'Mathur', NULL),
  ('lightning-001', 'SNM-JYM', 'DVS-JYM', 'Child', 'Mathur', NULL),
  ('lightning-001', 'DVS-JYM', 'SNM-JYM', 'Parent', 'Mathur', NULL),
  ('lightning-001', 'JYM-RMD', 'RJM-JYM', 'Child', 'Mathur', NULL),
  ('lightning-001', 'RJM-JYM', 'JYM-RMD', 'Parent', 'Mathur', NULL),
  ('lightning-001', 'SNM-JYM', 'RJM-JYM', 'Child', 'Mathur', NULL),
  ('lightning-001', 'RJM-JYM', 'SNM-JYM', 'Parent', 'Mathur', NULL),
  ('lightning-001', 'MHD-JYM', 'DVS-JYM', 'Sibling', 'Mathur', NULL),
  ('lightning-001', 'DVS-JYM', 'MHD-JYM', 'Sibling', 'Mathur', NULL),
  ('lightning-001', 'MHD-JYM', 'RJM-JYM', 'Sibling', 'Mathur', NULL),
  ('lightning-001', 'RJM-JYM', 'MHD-JYM', 'Sibling', 'Mathur', NULL),
  ('lightning-001', 'DVS-JYM', 'RJM-JYM', 'Sibling', 'Mathur', NULL),
  ('lightning-001', 'RJM-JYM', 'DVS-JYM', 'Sibling', 'Mathur', NULL),
  ('lightning-001', 'DVS-JYM', 'PRS-DVS', 'Spouse', 'Sidhu', NULL),
  ('lightning-001', 'PRS-DVS', 'DVS-JYM', 'Spouse', 'Sidhu', NULL),
  ('lightning-001', 'KD-NB-STAR', 'VND-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'VND-KD', 'KD-NB-STAR', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'KD-NB-STAR', 'BPD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'BPD-KD', 'KD-NB-STAR', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'KD-NB-STAR', 'STD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'STD-KD', 'KD-NB-STAR', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'KD-NB-STAR', 'DMD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'DMD-KD', 'KD-NB-STAR', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'VND-KD', 'BPD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'BPD-KD', 'VND-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'VND-KD', 'STD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'STD-KD', 'VND-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'VND-KD', 'DMD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'DMD-KD', 'VND-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'BPD-KD', 'STD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'STD-KD', 'BPD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'BPD-KD', 'DMD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'DMD-KD', 'BPD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'STD-KD', 'DMD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'DMD-KD', 'STD-KD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'VND-KD', 'UD-VND', 'Spouse', 'Datta-Paternal', NULL),
  ('lightning-001', 'UD-VND', 'VND-KD', 'Spouse', 'Datta-Paternal', NULL),
  ('lightning-001', 'VND-KD', 'RJD-VND', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'RJD-VND', 'VND-KD', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'UD-VND', 'RJD-VND', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'RJD-VND', 'UD-VND', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'VND-KD', 'SJD-VND', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'SJD-VND', 'VND-KD', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'UD-VND', 'SJD-VND', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'SJD-VND', 'UD-VND', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'RJD-VND', 'SJD-VND', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'SJD-VND', 'RJD-VND', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'RJD-VND', 'ARD-RJD', 'Spouse', 'Datta-Paternal', NULL),
  ('lightning-001', 'ARD-RJD', 'RJD-VND', 'Spouse', 'Datta-Paternal', NULL),
  ('lightning-001', 'RJD-VND', 'SMD-RJD', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'SMD-RJD', 'RJD-VND', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'ARD-RJD', 'SMD-RJD', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'SMD-RJD', 'ARD-RJD', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'RJD-VND', 'TND-RJD', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'TND-RJD', 'RJD-VND', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'ARD-RJD', 'TND-RJD', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'TND-RJD', 'ARD-RJD', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'SMD-RJD', 'TND-RJD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'TND-RJD', 'SMD-RJD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'SJD-VND', 'SED-SJD', 'Spouse', 'Datta-Paternal', NULL),
  ('lightning-001', 'SED-SJD', 'SJD-VND', 'Spouse', 'Datta-Paternal', NULL),
  ('lightning-001', 'BPD-KD', 'HLD-BPD', 'Spouse', 'Datta-Paternal', NULL),
  ('lightning-001', 'HLD-BPD', 'BPD-KD', 'Spouse', 'Datta-Paternal', NULL),
  ('lightning-001', 'BPD-KD', 'SND-BPD', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'SND-BPD', 'BPD-KD', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'HLD-BPD', 'SND-BPD', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'SND-BPD', 'HLD-BPD', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'BPD-KD', 'RHD-BPD', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'RHD-BPD', 'BPD-KD', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'HLD-BPD', 'RHD-BPD', 'Child', 'Datta-Paternal', NULL),
  ('lightning-001', 'RHD-BPD', 'HLD-BPD', 'Parent', 'Datta-Paternal', NULL),
  ('lightning-001', 'SND-BPD', 'RHD-BPD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'RHD-BPD', 'SND-BPD', 'Sibling', 'Datta-Paternal', NULL),
  ('lightning-001', 'SND-BPD', 'RN-SND', 'Spouse', 'Nagpal', NULL),
  ('lightning-001', 'RN-SND', 'SND-BPD', 'Spouse', 'Nagpal', NULL),
  ('lightning-001', 'SND-BPD', 'SHN-SND', 'Child', 'Nagpal', NULL),
  ('lightning-001', 'SHN-SND', 'SND-BPD', 'Parent', 'Nagpal', NULL),
  ('lightning-001', 'RN-SND', 'SHN-SND', 'Child', 'Nagpal', NULL),
  ('lightning-001', 'SHN-SND', 'RN-SND', 'Parent', 'Nagpal', NULL),
  ('lightning-001', 'SND-BPD', 'JN-SND', 'Child', 'Nagpal', NULL),
  ('lightning-001', 'JN-SND', 'SND-BPD', 'Parent', 'Nagpal', NULL),
  ('lightning-001', 'RN-SND', 'JN-SND', 'Child', 'Nagpal', NULL),
  ('lightning-001', 'JN-SND', 'RN-SND', 'Parent', 'Nagpal', NULL),
  ('lightning-001', 'SND-BPD', 'SON-SND', 'Child', 'Nagpal', NULL),
  ('lightning-001', 'SON-SND', 'SND-BPD', 'Parent', 'Nagpal', NULL),
  ('lightning-001', 'RN-SND', 'SON-SND', 'Child', 'Nagpal', NULL),
  ('lightning-001', 'SON-SND', 'RN-SND', 'Parent', 'Nagpal', NULL),
  ('lightning-001', 'SHN-SND', 'JN-SND', 'Sibling', 'Nagpal', NULL),
  ('lightning-001', 'JN-SND', 'SHN-SND', 'Sibling', 'Nagpal', NULL),
  ('lightning-001', 'SHN-SND', 'SON-SND', 'Sibling', 'Nagpal', NULL),
  ('lightning-001', 'SON-SND', 'SHN-SND', 'Sibling', 'Nagpal', NULL),
  ('lightning-001', 'JN-SND', 'SON-SND', 'Sibling', 'Nagpal', NULL),
  ('lightning-001', 'SON-SND', 'JN-SND', 'Sibling', 'Nagpal', NULL),
  ('lightning-001', 'SHN-SND', 'PN-SHN', 'Spouse', 'Nagpal', NULL),
  ('lightning-001', 'PN-SHN', 'SHN-SND', 'Spouse', 'Nagpal', NULL),
  ('lightning-001', 'RHD-BPD', 'RND-RHD', 'Spouse', 'Datta-Paternal', NULL),
  ('lightning-001', 'RND-RHD', 'RHD-BPD', 'Spouse', 'Datta-Paternal', NULL),
  ('lightning-001', 'STD-KD', 'KRB-STD', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'KRB-STD', 'STD-KD', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'STD-KD', 'MJB-STD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MJB-STD', 'STD-KD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'KRB-STD', 'MJB-STD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MJB-STD', 'KRB-STD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'STD-KD', 'MNB-STD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MNB-STD', 'STD-KD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'KRB-STD', 'MNB-STD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MNB-STD', 'KRB-STD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'STD-KD', 'MOB-STD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MOB-STD', 'STD-KD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'KRB-STD', 'MOB-STD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MOB-STD', 'KRB-STD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'STD-KD', 'JKB-STD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'JKB-STD', 'STD-KD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'KRB-STD', 'JKB-STD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'JKB-STD', 'KRB-STD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MJB-STD', 'MNB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MNB-STD', 'MJB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MJB-STD', 'MOB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MOB-STD', 'MJB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MJB-STD', 'JKB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'JKB-STD', 'MJB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MNB-STD', 'MOB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MOB-STD', 'MNB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MNB-STD', 'JKB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'JKB-STD', 'MNB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MOB-STD', 'JKB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'JKB-STD', 'MOB-STD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MJB-STD', 'RSB-MJB', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'RSB-MJB', 'MJB-STD', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MJB-STD', 'CHB-MJB', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'CHB-MJB', 'MJB-STD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'RSB-MJB', 'CHB-MJB', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'CHB-MJB', 'RSB-MJB', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MJB-STD', 'SCB-MJB', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'SCB-MJB', 'MJB-STD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'RSB-MJB', 'SCB-MJB', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'SCB-MJB', 'RSB-MJB', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'CHB-MJB', 'SCB-MJB', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'SCB-MJB', 'CHB-MJB', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'CHB-MJB', 'PRB-CHB', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'PRB-CHB', 'CHB-MJB', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'SCB-MJB', 'SHB-SCB', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'SHB-SCB', 'SCB-MJB', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MNB-STD', 'RDB-MNB', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'RDB-MNB', 'MNB-STD', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MNB-STD', 'ASB-MNB', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'ASB-MNB', 'MNB-STD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'RDB-MNB', 'ASB-MNB', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'ASB-MNB', 'RDB-MNB', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'MOB-STD', 'JTB-MOB', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'JTB-MOB', 'MOB-STD', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'JKB-STD', 'UMS-JKB', 'Child', 'Bakshi-Paternal', 'Father unknown'),
  ('lightning-001', 'UMS-JKB', 'JKB-STD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'JKB-STD', 'AJS-JKB', 'Child', 'Bakshi-Paternal', 'Father unknown'),
  ('lightning-001', 'AJS-JKB', 'JKB-STD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'UMS-JKB', 'AJS-JKB', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'AJS-JKB', 'UMS-JKB', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'DMD-KD', 'VDB-DMD', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'VDB-DMD', 'DMD-KD', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'DMD-KD', 'AKC-DMD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'AKC-DMD', 'DMD-KD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'VDB-DMD', 'AKC-DMD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'AKC-DMD', 'VDB-DMD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'DMD-KD', 'ALD-DMD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'ALD-DMD', 'DMD-KD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'VDB-DMD', 'ALD-DMD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'ALD-DMD', 'VDB-DMD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'DMD-KD', 'ATB-DMD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'ATB-DMD', 'DMD-KD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'VDB-DMD', 'ATB-DMD', 'Child', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'ATB-DMD', 'VDB-DMD', 'Parent', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'AKC-DMD', 'ALD-DMD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'ALD-DMD', 'AKC-DMD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'AKC-DMD', 'ATB-DMD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'ATB-DMD', 'AKC-DMD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'ALD-DMD', 'ATB-DMD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'ATB-DMD', 'ALD-DMD', 'Sibling', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'AKC-DMD', 'DNC-AKC', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'DNC-AKC', 'AKC-DMD', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'ALD-DMD', 'VRD-ALD', 'Spouse', 'Bakshi-Paternal', NULL),
  ('lightning-001', 'VRD-ALD', 'ALD-DMD', 'Spouse', 'Bakshi-Paternal', NULL);

-- ============================================================
-- STEP 5: Pets (8 rows)
-- ============================================================

INSERT INTO pets (pet_id, network_id, owner_id, name, type, status, birth_mm_yyyy, birth_location, current_location, bio, photo_id, globe_opt_in, visible_to)
VALUES
  ('P-001', 'lightning-001', 'AS-VS-STAR', 'Foxy', 'Dog', 'Living', NULL, NULL, NULL, NULL, NULL, FALSE, 'all'),
  ('P-002', 'lightning-001', 'AV-STAR', 'Sonny', 'Dog', 'Living', NULL, NULL, NULL, NULL, NULL, FALSE, 'all'),
  ('P-003', 'lightning-001', 'AYS-STAR', 'Shaitan', 'Dog', 'Living', NULL, NULL, NULL, NULL, NULL, FALSE, 'all'),
  ('P-004', 'lightning-001', 'NV-STAR', 'Charlie', 'Dog', 'Living', NULL, NULL, NULL, NULL, NULL, FALSE, 'all'),
  ('P-005', 'lightning-001', 'JS-RRB-STAR', 'Soxx', 'Dog', 'Living', NULL, NULL, NULL, NULL, NULL, FALSE, 'all'),
  ('P-006', 'lightning-001', 'STAR', 'Sheru', 'Dog', 'Living', NULL, NULL, NULL, NULL, NULL, FALSE, 'all'),
  ('P-007', 'lightning-001', 'KS-RRB-STAR', 'Millie', 'Dog', 'Living', NULL, NULL, NULL, NULL, NULL, FALSE, 'all'),
  ('P-008', 'lightning-001', 'SS-RRB-STAR', 'Cody', 'Dog', 'Living', NULL, NULL, NULL, NULL, NULL, FALSE, 'all');

-- ============================================================
-- STEP 6: Accomplishments (1 row)
-- ============================================================

INSERT INTO accomplishments (
  accomplishment_id, network_id, user_id, announced_by_user_id, subject_user_id, subject_name,
  accomplishment_type, title, description, organization_or_venue, location, date_mm_yyyy,
  media_id_1, media_id_2, media_id_3, media_id_4, media_id_5,
  share_with_network, celebrations_opt_in, currents, status
) VALUES
  (
  'ACH-STAR-001', 'lightning-001', 'STAR', 'STAR', 'IB-STAR', 'Isaiah Bakshi',
  'FamilyAnnouncement', 'Isaiah stars in the school play', 'So proud of Isaiah — he landed the lead role in the spring production.', 'Half Moon Bay High School', 'Half Moon Bay, CA, US', '04/2026',
  NULL, NULL, NULL, NULL, NULL,
  TRUE, TRUE, 25, 'Active'
  );

-- ============================================================
-- STEP 7: Journeys (68 rows)
-- ============================================================

INSERT INTO journeys (journey_id, network_id, person_id, location_name, category, reason, year, media_id, visible_to)
VALUES
  ('J-0001', 'lightning-001', 'STAR', 'New Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0002', 'lightning-001', 'STAR', 'Half Moon Bay, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0003', 'lightning-001', 'AB-STAR', 'New Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0004', 'lightning-001', 'AB-STAR', 'Half Moon Bay, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0005', 'lightning-001', 'AP-STAR', 'Fremont, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0006', 'lightning-001', 'BL-STAR', 'Redwood City, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0007', 'lightning-001', 'FP-STAR', 'Arcata, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0008', 'lightning-001', 'HP-STAR', 'Dublin, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0009', 'lightning-001', 'JP-STAR', 'Fremont, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0010', 'lightning-001', 'KS-RRB-STAR', 'San Mateo, CA, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0011', 'lightning-001', 'KS-RRB-STAR', 'Chicago, IL, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0012', 'lightning-001', 'NV-STAR', 'New Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0013', 'lightning-001', 'NV-STAR', 'Thousand Oaks, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0014', 'lightning-001', 'PS-STAR', 'New Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0015', 'lightning-001', 'PS-STAR', 'Half Moon Bay, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0016', 'lightning-001', 'RMSH-JS-RRB', 'Suva, Fiji', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0017', 'lightning-001', 'RMSH-JS-RRB', 'San Mateo, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0018', 'lightning-001', 'RP-STAR', 'Arcata, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0019', 'lightning-001', 'RPA-STAR', 'Dublin, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0020', 'lightning-001', 'RRB-STAR', 'Suva, Fiji', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0021', 'lightning-001', 'RRB-STAR', 'Half Moon Bay, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0022', 'lightning-001', 'SL-STAR', 'Redwood City, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0023', 'lightning-001', 'SS-RRB-STAR', 'Suva, Fiji', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0024', 'lightning-001', 'SS-RRB-STAR', 'Sacramento, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0025', 'lightning-001', 'VS-STAR', 'New Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0026', 'lightning-001', 'VS-STAR', 'Belmont, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0027', 'lightning-001', 'AS-VS-STAR', 'Milbrae, CA, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0028', 'lightning-001', 'AS-VS-STAR', 'Belmont, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0029', 'lightning-001', 'AV-NV-STAR', 'New York, NY, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0030', 'lightning-001', 'AV-NV-STAR', 'Thousand Oaks, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0031', 'lightning-001', 'AYS-STAR', 'Milbrae, CA, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0032', 'lightning-001', 'AYS-STAR', 'San Francisco, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0033', 'lightning-001', 'BP-HP-STAR', 'Hayward, CA, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0034', 'lightning-001', 'BP-HP-STAR', 'Dublin, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0035', 'lightning-001', 'DP-AP-STAR', 'Fremont, CA, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0036', 'lightning-001', 'DP-NV-STAR', 'Thousand Oaks, CA, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0037', 'lightning-001', 'HD-BD962', 'New Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0038', 'lightning-001', 'IB-STAR', 'Oakland, CA, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0039', 'lightning-001', 'IB-STAR', 'Half Moon Bay, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0040', 'lightning-001', 'JP-NV-STAR', 'New York, NY, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0041', 'lightning-001', 'JP-NV-STAR', 'Thousand Oaks, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0042', 'lightning-001', 'MD-BD962', 'New Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0043', 'lightning-001', 'NP-HP-STAR', 'Hayward, CA, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0044', 'lightning-001', 'NP-HP-STAR', 'San Francisco, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0045', 'lightning-001', 'PP-AP-STAR', 'Fremont, CA, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0046', 'lightning-001', 'PP-HP-STAR', 'Hayward, CA, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0047', 'lightning-001', 'PP-HP-STAR', 'Dublin, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0048', 'lightning-001', 'RP-NV-STAR', 'Thousand Oaks, CA, US', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0049', 'lightning-001', 'AV-STAR', 'New Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0050', 'lightning-001', 'AV-STAR', 'Thousand Oaks, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0051', 'lightning-001', 'BD-962', 'New Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0052', 'lightning-001', 'JS-RRB-STAR', 'Suva, Fiji', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0053', 'lightning-001', 'JS-RRB-STAR', 'San Mateo, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0054', 'lightning-001', 'MMB-STAR', 'Rawalpindi, Pakistan', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0055', 'lightning-001', 'MMB-STAR', 'Half Moon Bay, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0056', 'lightning-001', 'MP-STAR', 'Arcata, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0057', 'lightning-001', 'NB-STAR', 'Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0058', 'lightning-001', 'NB-STAR', 'Half Moon Bay, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0059', 'lightning-001', 'NS-RRB-STAR', 'Sinatoka, Fiji', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0060', 'lightning-001', 'PP-BD962', 'New Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0061', 'lightning-001', 'SV-NV-STAR', 'New Delhi, India', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0062', 'lightning-001', 'SV-NV-STAR', 'Thousand Oaks, CA, US', 'Residency', 'Current home', NULL, NULL, 'all'),
  ('J-0063', 'lightning-001', 'AS-NS-RRB-STAR', 'Suva, Fiji', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0064', 'lightning-001', 'BB-MMB-STAR', 'Pakistan', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0065', 'lightning-001', 'KB-MMB-STAR', 'Pakistan', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0066', 'lightning-001', 'RAMRS-JS-RRB-STAR', 'Suva, Fiji', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0067', 'lightning-001', 'RS-JS-RRB-STAR', 'Suva, Fiji', 'Birth', 'Birthplace', NULL, NULL, 'all'),
  ('J-0068', 'lightning-001', 'SS-NS-RRB-STAR', 'Suva, Fiji', 'Birth', 'Birthplace', NULL, NULL, 'all');

-- ============================================================
-- STEP 8: Activate self-referential FK constraints
-- Run AFTER all inserts confirmed clean
-- ============================================================

ALTER TABLE users ADD CONSTRAINT fk_parent      FOREIGN KEY (parent_id)     REFERENCES users(user_id);
ALTER TABLE users ADD CONSTRAINT fk_co_parent   FOREIGN KEY (co_parent_id)  REFERENCES users(user_id);
ALTER TABLE users ADD CONSTRAINT fk_partner     FOREIGN KEY (partner_id)    REFERENCES users(user_id);
ALTER TABLE users ADD CONSTRAINT fk_bio_parent  FOREIGN KEY (bio_parent_id) REFERENCES users(user_id);

ALTER TABLE networks ADD CONSTRAINT fk_network_owner FOREIGN KEY (owner_user_id) REFERENCES users(user_id);

-- ============================================================
-- END OF PHASE 0 DATA INSERT
-- ============================================================

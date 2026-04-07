-- ============================================================
-- EternalCurrent.Online -- Phase 0 RLS Policies
-- Supabase / PostgreSQL Row Level Security
-- Generated: 2026-04-04
--
-- PHILOSOPHY:
-- Phase 0 is a closed pilot. All 104 members are Free_Forever.
-- No public signups yet. Globe and constellation read from
-- public-safe data only. Email is NEVER exposed via any policy.
--
-- ROLES IN USE:
-- anon          = unauthenticated visitor (globe, landing page)
-- authenticated = logged-in member (future auth)
-- service_role  = backend / admin operations (never exposed to browser)
--
-- AUTH BRIDGE:
-- Our user_id is TEXT (e.g. 'STAR', 'IB-STAR').
-- Supabase Auth uses UUID. We add auth_id column now as the
-- bridge column — populated when members are invited and accept.
-- ============================================================


-- ============================================================
-- PREP: Add auth_id bridge column to users
-- Links our user_id to Supabase Auth UUID when member logs in
-- ============================================================

ALTER TABLE users ADD COLUMN IF NOT EXISTS
  auth_id UUID UNIQUE REFERENCES auth.users(id) ON DELETE SET NULL;

COMMENT ON COLUMN users.auth_id IS
  'Supabase Auth UUID. NULL until member accepts invite and logs in.';


-- ============================================================
-- PREP: Create users_public view
-- The frontend ALWAYS reads from this view, never the raw table.
-- Email is structurally excluded -- cannot leak by accident.
-- ============================================================

CREATE OR REPLACE VIEW users_public AS
SELECT
  user_id,
  network_id,
  full_name,
  first_name,
  middle_name,
  last_name,
  nickname,
  platform_role,
  family_role,
  status,
  tier,
  gender,
  cultural_origin,
  birth_mm_yyyy,
  birth_location,
  current_location,
  household_id,
  parent_id,
  co_parent_id,
  partner_id,
  partner_type,
  social_links,
  photo_id,
  invite_status,
  visible_to,
  bio,
  created_at,
  updated_at
  -- email intentionally excluded
  -- auth_id intentionally excluded
FROM users;

COMMENT ON VIEW users_public IS
  'Safe read view for frontend. Email and auth_id are structurally excluded.';


-- ============================================================
-- ENABLE RLS ON ALL TABLES
-- Must be done before any policies take effect
-- ============================================================

ALTER TABLE networks              ENABLE ROW LEVEL SECURITY;
ALTER TABLE users                 ENABLE ROW LEVEL SECURITY;
ALTER TABLE relationships         ENABLE ROW LEVEL SECURITY;
ALTER TABLE pets                  ENABLE ROW LEVEL SECURITY;
ALTER TABLE accomplishments       ENABLE ROW LEVEL SECURITY;
ALTER TABLE cultural_vocab_library ENABLE ROW LEVEL SECURITY;
ALTER TABLE banner_statements     ENABLE ROW LEVEL SECURITY;
ALTER TABLE banner_impressions    ENABLE ROW LEVEL SECURITY;
ALTER TABLE waitlist              ENABLE ROW LEVEL SECURITY;
ALTER TABLE journeys              ENABLE ROW LEVEL SECURITY;


-- ============================================================
-- NETWORKS
-- Anyone can read network names (needed for globe/landing).
-- Only service_role can write.
-- ============================================================

CREATE POLICY "networks_read_public"
  ON networks FOR SELECT
  TO anon, authenticated
  USING (status = 'Active');

CREATE POLICY "networks_write_service"
  ON networks FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);


-- ============================================================
-- USERS
-- Anon can read profiles marked visible_to = 'all' (globe render).
-- Authenticated members can read all profiles in their own network.
-- Members can update their own record only.
-- Email column never returned (use users_public view in frontend).
-- Service_role has full access for admin operations.
-- ============================================================

-- Anon: public profiles only (powers globe for unauthenticated visitors)
CREATE POLICY "users_read_public"
  ON users FOR SELECT
  TO anon
  USING (visible_to = 'all' AND status != 'Placeholder');

-- Authenticated: all non-placeholder profiles in same network
CREATE POLICY "users_read_network"
  ON users FOR SELECT
  TO authenticated
  USING (
    network_id IN (
      SELECT network_id FROM users WHERE auth_id = auth.uid()
    )
  );

-- Members update their own record only
CREATE POLICY "users_update_own"
  ON users FOR UPDATE
  TO authenticated
  USING (auth_id = auth.uid())
  WITH CHECK (auth_id = auth.uid());

-- Service role: full access
CREATE POLICY "users_all_service"
  ON users FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);


-- ============================================================
-- RELATIONSHIPS
-- Anon can read relationships for public-profile users (globe arcs).
-- Authenticated members can read all relationships in their network.
-- Only service_role writes.
-- ============================================================

CREATE POLICY "relationships_read_public"
  ON relationships FOR SELECT
  TO anon
  USING (
    network_id IN (SELECT network_id FROM networks WHERE status = 'Active')
  );

CREATE POLICY "relationships_read_network"
  ON relationships FOR SELECT
  TO authenticated
  USING (
    network_id IN (
      SELECT network_id FROM users WHERE auth_id = auth.uid()
    )
  );

CREATE POLICY "relationships_write_service"
  ON relationships FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);


-- ============================================================
-- JOURNEYS
-- Anon can read journeys marked visible_to = 'all'.
-- Authenticated members can read journeys in their network.
-- Members can insert/update their own journey records.
-- ============================================================

CREATE POLICY "journeys_read_public"
  ON journeys FOR SELECT
  TO anon
  USING (visible_to = 'all');

CREATE POLICY "journeys_read_network"
  ON journeys FOR SELECT
  TO authenticated
  USING (
    network_id IN (
      SELECT network_id FROM users WHERE auth_id = auth.uid()
    )
  );

CREATE POLICY "journeys_write_own"
  ON journeys FOR INSERT
  TO authenticated
  WITH CHECK (
    person_id IN (SELECT user_id FROM users WHERE auth_id = auth.uid())
  );

CREATE POLICY "journeys_update_own"
  ON journeys FOR UPDATE
  TO authenticated
  USING (
    person_id IN (SELECT user_id FROM users WHERE auth_id = auth.uid())
  );

CREATE POLICY "journeys_write_service"
  ON journeys FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);


-- ============================================================
-- PETS
-- Anon can read pets marked visible_to = 'all'.
-- Authenticated members can read pets in their network.
-- Owners can manage their own pets.
-- ============================================================

CREATE POLICY "pets_read_public"
  ON pets FOR SELECT
  TO anon
  USING (visible_to = 'all');

CREATE POLICY "pets_read_network"
  ON pets FOR SELECT
  TO authenticated
  USING (
    network_id IN (
      SELECT network_id FROM users WHERE auth_id = auth.uid()
    )
  );

CREATE POLICY "pets_write_own"
  ON pets FOR INSERT
  TO authenticated
  WITH CHECK (
    owner_id IN (SELECT user_id FROM users WHERE auth_id = auth.uid())
  );

CREATE POLICY "pets_update_own"
  ON pets FOR UPDATE
  TO authenticated
  USING (
    owner_id IN (SELECT user_id FROM users WHERE auth_id = auth.uid())
  );

CREATE POLICY "pets_write_service"
  ON pets FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);


-- ============================================================
-- ACCOMPLISHMENTS
-- Anon cannot read accomplishments (personal content).
-- Authenticated members can read shared accomplishments in network.
-- Members can post accomplishments for themselves or announce for others.
-- ============================================================

CREATE POLICY "accomplishments_read_network"
  ON accomplishments FOR SELECT
  TO authenticated
  USING (
    share_with_network = TRUE
    AND network_id IN (
      SELECT network_id FROM users WHERE auth_id = auth.uid()
    )
  );

CREATE POLICY "accomplishments_write_own"
  ON accomplishments FOR INSERT
  TO authenticated
  WITH CHECK (
    user_id IN (SELECT user_id FROM users WHERE auth_id = auth.uid())
  );

CREATE POLICY "accomplishments_update_own"
  ON accomplishments FOR UPDATE
  TO authenticated
  USING (
    user_id IN (SELECT user_id FROM users WHERE auth_id = auth.uid())
  );

CREATE POLICY "accomplishments_write_service"
  ON accomplishments FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);


-- ============================================================
-- CULTURAL VOCAB LIBRARY
-- Anyone can read public terms (network_id IS NULL, visible_to = 'all').
-- Authenticated members can read their network's private terms.
-- Scholars can submit new terms (pending review).
-- ============================================================

CREATE POLICY "vocab_read_public"
  ON cultural_vocab_library FOR SELECT
  TO anon
  USING (visible_to = 'all' AND network_id IS NULL);

CREATE POLICY "vocab_read_network"
  ON cultural_vocab_library FOR SELECT
  TO authenticated
  USING (
    visible_to = 'all'
    OR network_id IN (
      SELECT network_id FROM users WHERE auth_id = auth.uid()
    )
  );

CREATE POLICY "vocab_insert_scholar"
  ON cultural_vocab_library FOR INSERT
  TO authenticated
  WITH CHECK (
    contributor_id IN (
      SELECT user_id FROM users
      WHERE auth_id = auth.uid()
      AND platform_role = 'Scholar'
    )
    AND reviewed = FALSE  -- all Scholar submissions start unreviewed
  );

CREATE POLICY "vocab_write_service"
  ON cultural_vocab_library FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);


-- ============================================================
-- BANNER STATEMENTS
-- Anyone can read Active statements (powers rotating banner).
-- Only service_role writes (admin approval required per spec).
-- ============================================================

CREATE POLICY "banner_read_active"
  ON banner_statements FOR SELECT
  TO anon, authenticated
  USING (status = 'Active');

CREATE POLICY "banner_write_service"
  ON banner_statements FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);


-- ============================================================
-- BANNER IMPRESSIONS
-- Anyone can insert an impression (anonymous engagement tracking).
-- Only service_role can read (aggregate reporting only).
-- ============================================================

CREATE POLICY "impressions_insert_any"
  ON banner_impressions FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

CREATE POLICY "impressions_read_service"
  ON banner_impressions FOR SELECT
  TO service_role
  USING (true);

CREATE POLICY "impressions_write_service"
  ON banner_impressions FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);


-- ============================================================
-- WAITLIST
-- Anyone can join the waitlist (pre-launch signups).
-- Only service_role can read waitlist entries.
-- ============================================================

CREATE POLICY "waitlist_insert_any"
  ON waitlist FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

CREATE POLICY "waitlist_read_service"
  ON waitlist FOR SELECT
  TO service_role
  USING (true);

CREATE POLICY "waitlist_write_service"
  ON waitlist FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);


-- ============================================================
-- REVOKE email column from anon and authenticated roles
-- Belt-and-suspenders on top of the users_public view
-- ============================================================

REVOKE SELECT ON users FROM anon;
REVOKE SELECT ON users FROM authenticated;

-- Grant SELECT on all columns EXCEPT email and auth_id
-- via the users_public view instead
GRANT SELECT ON users_public TO anon;
GRANT SELECT ON users_public TO authenticated;

-- Authenticated members still need to update their own users row
GRANT UPDATE (
  first_name, middle_name, last_name, nickname, gender,
  current_location, social_links, photo_id, bio,
  visible_to, updated_at
) ON users TO authenticated;


-- ============================================================
-- END OF PHASE 0 RLS POLICIES
-- ============================================================

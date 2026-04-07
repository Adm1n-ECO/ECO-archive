-- ============================================================
-- FindMyTree.Online — SQL 001
-- Initial database schema
-- FMTO · Session 1
-- Run in: Supabase dashboard → SQL Editor
-- Safe to re-run: all statements use IF NOT EXISTS
-- ============================================================

-- ── Extensions ───────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";  -- for fuzzy name search later

-- ============================================================
-- TABLE: users
-- Mirror of auth.users with FMTO-specific profile fields.
-- Linked 1:1 to Supabase auth.users via id.
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
  id                    UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email                 TEXT NOT NULL UNIQUE,
  first_name            TEXT,
  last_name             TEXT,
  display_name          TEXT,
  avatar_url            TEXT,
  bio                   TEXT,
  subscription_tier     TEXT NOT NULL DEFAULT 'free'
                          CHECK (subscription_tier IN ('free', 'personal', 'family')),
  subscription_status   TEXT NOT NULL DEFAULT 'inactive'
                          CHECK (subscription_status IN ('active', 'inactive', 'cancelled', 'past_due', 'trialing')),
  stripe_customer_id    TEXT UNIQUE,
  stripe_subscription_id TEXT UNIQUE,
  theme_preference      TEXT DEFAULT 'system'
                          CHECK (theme_preference IN ('system', 'light', 'dark')),
  onboarding_complete   BOOLEAN DEFAULT false,
  created_at            TIMESTAMPTZ DEFAULT now(),
  updated_at            TIMESTAMPTZ DEFAULT now()
);

-- ── RLS: users ───────────────────────────────────────────────
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "users_select_own" ON users;
CREATE POLICY "users_select_own" ON users
  FOR SELECT USING (
    id = auth.uid()
    OR LOWER(email) = LOWER(auth.jwt()->>'email')
  );

DROP POLICY IF EXISTS "users_insert_own" ON users;
CREATE POLICY "users_insert_own" ON users
  FOR INSERT WITH CHECK (
    id = auth.uid()
  );

DROP POLICY IF EXISTS "users_update_own" ON users;
CREATE POLICY "users_update_own" ON users
  FOR UPDATE USING (
    id = auth.uid()
  );

-- ── Trigger: updated_at ──────────────────────────────────────
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS users_updated_at ON users;
CREATE TRIGGER users_updated_at
  BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================
-- TABLE: households
-- The core node unit of the FMTO network.
-- A household is what appears on the tree — not an individual.
-- ============================================================
CREATE TABLE IF NOT EXISTS households (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id      UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name          TEXT NOT NULL,
  bio           TEXT,
  avatar_url    TEXT,
  address_line  TEXT,
  city          TEXT,
  state         TEXT,
  country       TEXT,                          -- ISO 3166-1 alpha-2 e.g. 'US', 'IN', 'GB'
  lat           NUMERIC(9,6),
  lng           NUMERIC(9,6),
  is_public     BOOLEAN DEFAULT false,         -- Whether visible to non-connected users
  created_at    TIMESTAMPTZ DEFAULT now(),
  updated_at    TIMESTAMPTZ DEFAULT now()
);

-- ── RLS: households ──────────────────────────────────────────
ALTER TABLE households ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "households_select_owner" ON households;
CREATE POLICY "households_select_owner" ON households
  FOR SELECT USING (
    owner_id = auth.uid()
    OR id IN (
      SELECT household_id FROM household_members WHERE user_id = auth.uid()
    )
    OR id IN (
      SELECT household_b FROM connections
        WHERE household_a IN (
          SELECT household_id FROM household_members WHERE user_id = auth.uid()
        ) AND status = 'accepted'
      UNION
      SELECT household_a FROM connections
        WHERE household_b IN (
          SELECT household_id FROM household_members WHERE user_id = auth.uid()
        ) AND status = 'accepted'
    )
  );

DROP POLICY IF EXISTS "households_insert_owner" ON households;
CREATE POLICY "households_insert_owner" ON households
  FOR INSERT WITH CHECK (owner_id = auth.uid());

DROP POLICY IF EXISTS "households_update_owner" ON households;
CREATE POLICY "households_update_owner" ON households
  FOR UPDATE USING (owner_id = auth.uid());

DROP POLICY IF EXISTS "households_delete_owner" ON households;
CREATE POLICY "households_delete_owner" ON households
  FOR DELETE USING (owner_id = auth.uid());

DROP TRIGGER IF EXISTS households_updated_at ON households;
CREATE TRIGGER households_updated_at
  BEFORE UPDATE ON households
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================
-- TABLE: household_members
-- People who belong to a household.
-- Each member has their own user account.
-- ============================================================
CREATE TABLE IF NOT EXISTS household_members (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id        UUID NOT NULL REFERENCES households(id) ON DELETE CASCADE,
  user_id             UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role                TEXT NOT NULL DEFAULT 'member'
                        CHECK (role IN ('owner', 'member')),
  relationship_label  TEXT,                  -- e.g. "Father", "Daughter", "Partner"
  birth_year          INTEGER,               -- Optional — for generational display
  joined_at           TIMESTAMPTZ DEFAULT now(),
  UNIQUE (household_id, user_id)
);

-- ── RLS: household_members ───────────────────────────────────
ALTER TABLE household_members ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "hm_select" ON household_members;
CREATE POLICY "hm_select" ON household_members
  FOR SELECT USING (
    user_id = auth.uid()
    OR household_id IN (
      SELECT id FROM households WHERE owner_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "hm_insert_owner" ON household_members;
CREATE POLICY "hm_insert_owner" ON household_members
  FOR INSERT WITH CHECK (
    household_id IN (
      SELECT id FROM households WHERE owner_id = auth.uid()
    )
    OR user_id = auth.uid()
  );

DROP POLICY IF EXISTS "hm_delete_owner" ON household_members;
CREATE POLICY "hm_delete_owner" ON household_members
  FOR DELETE USING (
    household_id IN (
      SELECT id FROM households WHERE owner_id = auth.uid()
    )
  );


-- ============================================================
-- TABLE: segments
-- Named, colored network layers the user defines.
-- e.g. "Dad's side", "School friends", "UK family"
-- ============================================================
CREATE TABLE IF NOT EXISTS segments (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id    UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name        TEXT NOT NULL,
  color       TEXT DEFAULT '#0E7C6B',         -- Hex color for UI pill
  is_visible  BOOLEAN DEFAULT true,
  sort_order  INTEGER DEFAULT 0,
  created_at  TIMESTAMPTZ DEFAULT now(),
  updated_at  TIMESTAMPTZ DEFAULT now()
);

-- ── RLS: segments ────────────────────────────────────────────
ALTER TABLE segments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "segments_own" ON segments;
CREATE POLICY "segments_own" ON segments
  FOR ALL USING (owner_id = auth.uid());

DROP TRIGGER IF EXISTS segments_updated_at ON segments;
CREATE TRIGGER segments_updated_at
  BEFORE UPDATE ON segments
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================
-- TABLE: connections
-- Links between two households.
-- The edge on the tree/globe graph.
-- ============================================================
CREATE TABLE IF NOT EXISTS connections (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  household_a       UUID NOT NULL REFERENCES households(id) ON DELETE CASCADE,
  household_b       UUID NOT NULL REFERENCES households(id) ON DELETE CASCADE,
  connection_type   TEXT NOT NULL DEFAULT 'family'
                      CHECK (connection_type IN ('family', 'friend', 'school', 'work', 'custom')),
  custom_label      TEXT,                    -- Used when connection_type = 'custom'
  relationship_story TEXT,                  -- "Met at Uncle Ray's 60th..."
  privacy_level     TEXT NOT NULL DEFAULT 'partial'
                      CHECK (privacy_level IN ('full', 'partial', 'minimal', 'hidden')),
  status            TEXT NOT NULL DEFAULT 'pending'
                      CHECK (status IN ('pending', 'accepted', 'declined')),
  initiated_by      UUID REFERENCES users(id),
  created_at        TIMESTAMPTZ DEFAULT now(),
  accepted_at       TIMESTAMPTZ,
  CONSTRAINT no_self_connection CHECK (household_a <> household_b),
  CONSTRAINT unique_pair UNIQUE (
    LEAST(household_a::text, household_b::text),
    GREATEST(household_a::text, household_b::text)
  )
);

-- ── RLS: connections ─────────────────────────────────────────
ALTER TABLE connections ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "connections_select" ON connections;
CREATE POLICY "connections_select" ON connections
  FOR SELECT USING (
    household_a IN (SELECT id FROM households WHERE owner_id = auth.uid())
    OR household_b IN (SELECT id FROM households WHERE owner_id = auth.uid())
    OR household_a IN (SELECT household_id FROM household_members WHERE user_id = auth.uid())
    OR household_b IN (SELECT household_id FROM household_members WHERE user_id = auth.uid())
  );

DROP POLICY IF EXISTS "connections_insert" ON connections;
CREATE POLICY "connections_insert" ON connections
  FOR INSERT WITH CHECK (
    household_a IN (SELECT id FROM households WHERE owner_id = auth.uid())
    OR household_a IN (SELECT household_id FROM household_members WHERE user_id = auth.uid())
  );

DROP POLICY IF EXISTS "connections_update" ON connections;
CREATE POLICY "connections_update" ON connections
  FOR UPDATE USING (
    household_a IN (SELECT id FROM households WHERE owner_id = auth.uid())
    OR household_b IN (SELECT id FROM households WHERE owner_id = auth.uid())
  );

DROP POLICY IF EXISTS "connections_delete" ON connections;
CREATE POLICY "connections_delete" ON connections
  FOR DELETE USING (
    household_a IN (SELECT id FROM households WHERE owner_id = auth.uid())
    OR household_b IN (SELECT id FROM households WHERE owner_id = auth.uid())
  );

DROP TRIGGER IF EXISTS connections_accepted_at ON connections;
CREATE OR REPLACE FUNCTION set_connection_accepted_at()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status = 'accepted' AND OLD.status <> 'accepted' THEN
    NEW.accepted_at = now();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER connections_accepted_at
  BEFORE UPDATE ON connections
  FOR EACH ROW EXECUTE FUNCTION set_connection_accepted_at();


-- ============================================================
-- TABLE: connection_segments
-- Junction table — which connections belong to which segments.
-- One connection can be in multiple segments.
-- ============================================================
CREATE TABLE IF NOT EXISTS connection_segments (
  connection_id   UUID NOT NULL REFERENCES connections(id) ON DELETE CASCADE,
  segment_id      UUID NOT NULL REFERENCES segments(id)    ON DELETE CASCADE,
  assigned_at     TIMESTAMPTZ DEFAULT now(),
  PRIMARY KEY (connection_id, segment_id)
);

-- ── RLS: connection_segments ─────────────────────────────────
ALTER TABLE connection_segments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "conn_segs_own" ON connection_segments;
CREATE POLICY "conn_segs_own" ON connection_segments
  FOR ALL USING (
    segment_id IN (SELECT id FROM segments WHERE owner_id = auth.uid())
  );


-- ============================================================
-- TABLE: invitations
-- Secure token-based invites for joining the network.
-- ============================================================
CREATE TABLE IF NOT EXISTS invitations (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  token           TEXT NOT NULL UNIQUE DEFAULT encode(gen_random_bytes(32), 'hex'),
  invited_by      UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  invited_email   TEXT NOT NULL,
  household_id    UUID REFERENCES households(id) ON DELETE SET NULL,
  connection_id   UUID REFERENCES connections(id) ON DELETE SET NULL,
  message         TEXT,                            -- Personal note from inviter
  status          TEXT NOT NULL DEFAULT 'pending'
                    CHECK (status IN ('pending', 'accepted', 'declined', 'expired')),
  expires_at      TIMESTAMPTZ DEFAULT (now() + INTERVAL '30 days'),
  created_at      TIMESTAMPTZ DEFAULT now(),
  accepted_at     TIMESTAMPTZ
);

-- ── RLS: invitations ─────────────────────────────────────────
ALTER TABLE invitations ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "invitations_select" ON invitations;
CREATE POLICY "invitations_select" ON invitations
  FOR SELECT USING (
    invited_by = auth.uid()
    OR LOWER(invited_email) = LOWER(auth.jwt()->>'email')
  );

DROP POLICY IF EXISTS "invitations_insert" ON invitations;
CREATE POLICY "invitations_insert" ON invitations
  FOR INSERT WITH CHECK (invited_by = auth.uid());

DROP POLICY IF EXISTS "invitations_update" ON invitations;
CREATE POLICY "invitations_update" ON invitations
  FOR UPDATE USING (
    invited_by = auth.uid()
    OR LOWER(invited_email) = LOWER(auth.jwt()->>'email')
  );


-- ============================================================
-- TABLE: life_events
-- Births, weddings, moves, graduations — shared with network.
-- ============================================================
CREATE TABLE IF NOT EXISTS life_events (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id    UUID NOT NULL REFERENCES households(id) ON DELETE CASCADE,
  created_by      UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  event_type      TEXT NOT NULL
                    CHECK (event_type IN ('birth','wedding','move','graduation','death','anniversary','custom')),
  title           TEXT NOT NULL,
  description     TEXT,
  event_date      DATE,
  is_broadcast    BOOLEAN DEFAULT false,           -- Whether to notify connected network
  broadcast_at    TIMESTAMPTZ,
  created_at      TIMESTAMPTZ DEFAULT now(),
  updated_at      TIMESTAMPTZ DEFAULT now()
);

-- ── RLS: life_events ─────────────────────────────────────────
ALTER TABLE life_events ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "events_select" ON life_events;
CREATE POLICY "events_select" ON life_events
  FOR SELECT USING (
    household_id IN (SELECT id FROM households WHERE owner_id = auth.uid())
    OR household_id IN (SELECT household_id FROM household_members WHERE user_id = auth.uid())
    OR (is_broadcast = true AND household_id IN (
      SELECT household_b FROM connections
        WHERE household_a IN (SELECT id FROM households WHERE owner_id = auth.uid())
        AND status = 'accepted'
      UNION
      SELECT household_a FROM connections
        WHERE household_b IN (SELECT id FROM households WHERE owner_id = auth.uid())
        AND status = 'accepted'
    ))
  );

DROP POLICY IF EXISTS "events_insert" ON life_events;
CREATE POLICY "events_insert" ON life_events
  FOR INSERT WITH CHECK (
    household_id IN (SELECT id FROM households WHERE owner_id = auth.uid())
  );

DROP POLICY IF EXISTS "events_update" ON life_events;
CREATE POLICY "events_update" ON life_events
  FOR UPDATE USING (
    household_id IN (SELECT id FROM households WHERE owner_id = auth.uid())
  );

DROP POLICY IF EXISTS "events_delete" ON life_events;
CREATE POLICY "events_delete" ON life_events
  FOR DELETE USING (
    household_id IN (SELECT id FROM households WHERE owner_id = auth.uid())
  );

DROP TRIGGER IF EXISTS events_updated_at ON life_events;
CREATE TRIGGER events_updated_at
  BEFORE UPDATE ON life_events
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================
-- TABLE: admin_superusers
-- FMTO platform admins (Vikas only initially).
-- Pattern inherited from F4F.
-- ============================================================
CREATE TABLE IF NOT EXISTS admin_superusers (
  email       TEXT PRIMARY KEY,
  added_at    TIMESTAMPTZ DEFAULT now()
);

-- ── RLS: admin_superusers ────────────────────────────────────
ALTER TABLE admin_superusers ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "superusers_select" ON admin_superusers;
CREATE POLICY "superusers_select" ON admin_superusers
  FOR SELECT USING (
    LOWER(email) = LOWER(auth.jwt()->>'email')
  );

DROP POLICY IF EXISTS "superusers_all" ON admin_superusers;
CREATE POLICY "superusers_all" ON admin_superusers
  FOR ALL USING (
    LOWER(email) = LOWER(auth.jwt()->>'email')
  );


-- ============================================================
-- TABLE: dev_lessons
-- Hard-won lessons captured during development.
-- Pattern inherited from F4F. Invaluable for long projects.
-- ============================================================
CREATE TABLE IF NOT EXISTS dev_lessons (
  id          SERIAL PRIMARY KEY,
  session     INTEGER,
  category    TEXT,
  mistake     TEXT,
  fix         TEXT,
  tags        TEXT[],
  created_at  TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE dev_lessons ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "dev_lessons_admin" ON dev_lessons;
CREATE POLICY "dev_lessons_admin" ON dev_lessons
  FOR ALL USING (
    LOWER(auth.jwt()->>'email') IN (SELECT LOWER(email) FROM admin_superusers)
  );


-- ============================================================
-- TABLE: dev_changelog
-- Session-by-session changelog for the admin blueprint.
-- ============================================================
CREATE TABLE IF NOT EXISTS dev_changelog (
  id          SERIAL PRIMARY KEY,
  version     TEXT,
  session     INTEGER,
  title       TEXT,
  body        TEXT,
  category    TEXT,
  created_at  TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE dev_changelog ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "changelog_admin" ON dev_changelog;
CREATE POLICY "changelog_admin" ON dev_changelog
  FOR ALL USING (
    LOWER(auth.jwt()->>'email') IN (SELECT LOWER(email) FROM admin_superusers)
  );


-- ============================================================
-- SECURITY DEFINER RPCs
-- These bypass RLS for safe cross-table reads.
-- Grant to anon / authenticated as needed.
-- ============================================================

-- Get household locations for globe view (public — only lat/lng + country)
DROP FUNCTION IF EXISTS get_household_locations();
CREATE OR REPLACE FUNCTION get_household_locations()
RETURNS TABLE (
  id        UUID,
  name      TEXT,
  city      TEXT,
  country   TEXT,
  lat       NUMERIC,
  lng       NUMERIC
)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  RETURN QUERY
  SELECT h.id, h.name, h.city, h.country, h.lat, h.lng
  FROM households h
  WHERE h.lat IS NOT NULL AND h.lng IS NOT NULL;
END;
$$;

GRANT EXECUTE ON FUNCTION get_household_locations() TO authenticated;


-- ============================================================
-- INDEXES for performance
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_households_owner    ON households(owner_id);
CREATE INDEX IF NOT EXISTS idx_hm_household        ON household_members(household_id);
CREATE INDEX IF NOT EXISTS idx_hm_user             ON household_members(user_id);
CREATE INDEX IF NOT EXISTS idx_connections_a       ON connections(household_a);
CREATE INDEX IF NOT EXISTS idx_connections_b       ON connections(household_b);
CREATE INDEX IF NOT EXISTS idx_connections_status  ON connections(status);
CREATE INDEX IF NOT EXISTS idx_segments_owner      ON segments(owner_id);
CREATE INDEX IF NOT EXISTS idx_invitations_token   ON invitations(token);
CREATE INDEX IF NOT EXISTS idx_invitations_email   ON invitations(invited_email);
CREATE INDEX IF NOT EXISTS idx_events_household    ON life_events(household_id);
CREATE INDEX IF NOT EXISTS idx_users_email         ON users(email);
CREATE INDEX IF NOT EXISTS idx_households_country  ON households(country);
CREATE INDEX IF NOT EXISTS idx_households_latlng   ON households(lat, lng)
  WHERE lat IS NOT NULL AND lng IS NOT NULL;


-- ============================================================
-- INITIAL SEED DATA
-- Insert admin superuser — replace with real admin email
-- ============================================================
INSERT INTO admin_superusers (email)
VALUES ('admin@findmytree.online')
ON CONFLICT (email) DO NOTHING;


-- ============================================================
-- END SQL 001
-- Next migration: sql/002_*.sql
-- Run this in Supabase dashboard → SQL Editor
-- ============================================================

-- ============================================================
-- PENDING PROFILES + GHOST NODE SYSTEM
-- Added: 2026-03-19 · Session 1 Update 2
-- ============================================================
-- Ghost node visibility states (Decision 23 — locked):
--   private   → entered in roster, invite NOT yet sent
--               visible as anonymous silhouette to ALL connections (shape only, no name)
--   invited   → invite email dispatched, recipient not yet joined
--               name + relationship now visible to connections as named ghost
--   view_only → recipient joined, chose view-only (no household paid)
--               named node, distinct styling from paid profiles
--   (paid profiles live in the main profiles/household_members tables)
-- ============================================================

CREATE TABLE IF NOT EXISTS pending_profiles (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  created_by      UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  household_id    UUID NOT NULL REFERENCES households(id) ON DELETE CASCADE,

  -- Identity
  display_name    TEXT NOT NULL,
  relationship_to_owner TEXT NOT NULL,  -- 'grandmother', 'aunt', 'cousin', etc.
  is_pet          BOOLEAN NOT NULL DEFAULT FALSE,
  pet_type        TEXT,                  -- free text: 'Golden Retriever', 'Tabby Cat', 'Ball Python'

  -- Cross-relationships (e.g. "also mother of Rajesh Bakshi")
  also_related_to JSONB DEFAULT '[]'::jsonb,
  -- format: [{"name": "Rajesh Bakshi", "relationship": "Mother of"}, ...]

  -- Contact (for invite)
  email           TEXT,
  city            TEXT,
  country         TEXT,

  -- Ghost node visibility state (Decision 23)
  -- private  → no invite sent yet, anonymous silhouette visible to connections
  -- invited  → invite sent, name visible to connections as named ghost
  -- view_only → joined free, visible as named view-only node
  visibility_state TEXT NOT NULL DEFAULT 'private'
    CHECK (visibility_state IN ('private', 'invited', 'view_only')),

  -- Invite tracking
  invite_sent_at  TIMESTAMPTZ,
  invite_token    TEXT UNIQUE,
  invite_accepted_at TIMESTAMPTZ,

  -- Soft delete (Decision 21 — 30-day recovery window)
  deleted_at      TIMESTAMPTZ,
  deletion_scheduled_permanently_at TIMESTAMPTZ,  -- deleted_at + 30 days

  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index for fast ghost node queries on tree view
CREATE INDEX IF NOT EXISTS idx_pending_profiles_household
  ON pending_profiles(household_id)
  WHERE deleted_at IS NULL;

-- Index for invite token lookup (join flow)
CREATE INDEX IF NOT EXISTS idx_pending_profiles_token
  ON pending_profiles(invite_token)
  WHERE invite_token IS NOT NULL;

-- RLS
ALTER TABLE pending_profiles ENABLE ROW LEVEL SECURITY;

-- Owner can see all their pending profiles (all states)
DROP POLICY IF EXISTS "owner_all_pending" ON pending_profiles;
CREATE POLICY "owner_all_pending" ON pending_profiles
  FOR ALL
  USING (created_by = auth.uid());

-- Connections can see:
-- (a) anonymous silhouette for 'private' state — but we return NO name/email, only id + state
-- (b) full ghost (name, relationship) for 'invited' and 'view_only' states
-- This is enforced at the RPC level, not row-level, so connections
-- can query the count of anonymous ghosts without seeing private data.
-- See: get_tree_nodes() RPC below.

-- ============================================================
-- RPC: get_tree_nodes(p_household_id UUID)
-- Returns all nodes for a household's tree view, with
-- correct visibility applied per viewer identity.
-- ============================================================
CREATE OR REPLACE FUNCTION get_tree_nodes(p_household_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_viewer_id UUID := auth.uid();
  v_is_owner  BOOLEAN;
  v_result    JSONB;
BEGIN
  -- Check if viewer owns this household
  SELECT EXISTS(
    SELECT 1 FROM household_members
    WHERE household_id = p_household_id
      AND user_id = v_viewer_id
  ) INTO v_is_owner;

  SELECT jsonb_build_object(
    'paid_profiles', (
      -- Active paid household members — always visible to connections
      SELECT jsonb_agg(jsonb_build_object(
        'id', hm.id,
        'display_name', u.display_name,
        'relationship', hm.relationship_label,
        'city', h.city,
        'is_pet', hm.is_pet,
        'state', 'active'
      ))
      FROM household_members hm
      JOIN users u ON u.id = hm.user_id
      JOIN households h ON h.id = hm.household_id
      WHERE hm.household_id = p_household_id
        AND hm.deleted_at IS NULL
    ),
    'pending_profiles', (
      SELECT jsonb_agg(
        CASE
          -- Owner sees everything
          WHEN v_is_owner THEN jsonb_build_object(
            'id', pp.id,
            'display_name', pp.display_name,
            'relationship', pp.relationship_to_owner,
            'also_related_to', pp.also_related_to,
            'email', pp.email,
            'is_pet', pp.is_pet,
            'pet_type', pp.pet_type,
            'state', pp.visibility_state,
            'invite_sent_at', pp.invite_sent_at
          )
          -- Connections see named ghost if invited or view_only
          WHEN pp.visibility_state IN ('invited', 'view_only') THEN jsonb_build_object(
            'id', pp.id,
            'display_name', pp.display_name,
            'relationship', pp.relationship_to_owner,
            'is_pet', pp.is_pet,
            'state', pp.visibility_state
            -- email intentionally excluded for non-owners
          )
          -- private state: anonymous silhouette — no name, no relationship
          ELSE jsonb_build_object(
            'id', pp.id,
            'display_name', null,
            'relationship', null,
            'is_pet', pp.is_pet,
            'state', 'anonymous'
          )
        END
      )
      FROM pending_profiles pp
      WHERE pp.household_id = p_household_id
        AND pp.deleted_at IS NULL
    )
  ) INTO v_result;

  RETURN v_result;
END;
$$;

-- ============================================================
-- EternalCurrent.Online — Phase 0 Schema
-- Supabase / PostgreSQL
-- Network: lightning-001
-- Generated: 2026-04-04
-- Rule: Birth dates stored as MM/YYYY only — NEVER the day
-- Rule: Email encrypted at rest — NEVER displayed in UI
-- ============================================================


-- ============================================================
-- ENUMS
-- Using TEXT + CHECK CONSTRAINT (not PG ENUM type) for
-- flexibility — easier to ALTER as platform evolves
-- ============================================================


-- ============================================================
-- 1. NETWORKS
-- One row per family network. lightning-001 is the pilot.
-- ============================================================

CREATE TABLE IF NOT EXISTS networks (
  network_id        TEXT PRIMARY KEY,
  name              TEXT NOT NULL,
  description       TEXT,
  owner_user_id     TEXT,                          -- FK added after users table
  tier              TEXT NOT NULL DEFAULT 'Free_Forever',
  status            TEXT NOT NULL DEFAULT 'Active'
                      CHECK (status IN ('Active', 'Frozen', 'Archived')),
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE networks IS 'One row per family network. lightning-001 is the founding pilot.';


-- ============================================================
-- 2. USERS
-- All 104 lightning-001 members. Placeholders included.
-- Self-referential FKs (parent_id, etc.) added after bulk insert.
-- ============================================================

CREATE TABLE IF NOT EXISTS users (
  user_id           TEXT PRIMARY KEY,
  network_id        TEXT NOT NULL REFERENCES networks(network_id),

  -- Identity
  full_name         TEXT NOT NULL,
  first_name        TEXT,
  middle_name       TEXT,
  last_name         TEXT,
  nickname          TEXT,

  -- Platform role — what the user can DO on the platform
  -- Self-referential perspective switching is a frontend/session
  -- feature, not stored here. Whoever logs in becomes focal node.
  platform_role     TEXT NOT NULL DEFAULT 'Conductor'
                      CHECK (platform_role IN (
                        'SuperUser',      -- admin@eternalcurrent.online only
                        'NetworkOwner',   -- created and owns this network
                        'Moderator',      -- permission layer on Conductor
                        'Keeper',         -- permission layer on Conductor
                        'Conductor',      -- standard member
                        'Scholar',        -- SME/researcher, attributed on public pages
                        'Guest'           -- view-only, no account required
                      )),

  -- Family role — how this person relates to others in narrative
  family_role       TEXT,                          -- son, daughter, father, mother, etc.

  -- Status
  status            TEXT NOT NULL DEFAULT 'Placeholder'
                      CHECK (status IN ('Living', 'Passed', 'Placeholder')),

  -- Pricing tier
  tier              TEXT NOT NULL DEFAULT 'Free_Forever'
                      CHECK (tier IN (
                        'Free_Forever',   -- pilot / founding members
                        'Conductor',      -- $5.99/mo
                        'ConductorPro',   -- $8.99/mo
                        'Student',        -- $3/mo, 9-month max
                        'OrgAdmin',       -- $14.99/mo
                        'Placeholder'     -- not yet activated
                      )),

  -- Demographics
  gender            TEXT CHECK (gender IN ('male', 'female', 'other')),
  cultural_origin   TEXT,                          -- India, Fiji, Pakistan, Adopted — drives globe color

  -- Birth — MM/YYYY only, NEVER the day
  birth_mm_yyyy     TEXT,                          -- format: MM/YYYY
  birth_location    TEXT,

  -- Current
  current_location  TEXT,

  -- Relationships (denormalized convenience fields)
  household_id      TEXT,
  parent_id         TEXT,                          -- FK to users(user_id) — added post-insert
  co_parent_id      TEXT,                          -- FK to users(user_id) — added post-insert
  partner_id        TEXT,                          -- FK to users(user_id) — added post-insert
  partner_type      TEXT,                          -- Wife, Husband, Partner, etc.
  bio_parent_id     TEXT,                          -- FK to users(user_id) — Isaiah only, added post-insert

  -- Media & contact
  social_links      TEXT,
  photo_id          TEXT,
  email             TEXT,                          -- encrypted at rest, NEVER displayed in UI

  -- Platform metadata
  invite_status     TEXT NOT NULL DEFAULT 'Not Sent'
                      CHECK (invite_status IN ('Not Sent', 'Sent', 'Accepted', 'Declined')),
  visible_to        TEXT NOT NULL DEFAULT 'all'
                      CHECK (visible_to IN ('all', 'network', 'private')),
  bio               TEXT,

  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE users IS 'All network members including Placeholders. 104 records in lightning-001.';
COMMENT ON COLUMN users.birth_mm_yyyy IS 'MM/YYYY format only. Day is never stored.';
COMMENT ON COLUMN users.email IS 'Encrypted at rest. Never displayed in any UI or shared with any network member.';
COMMENT ON COLUMN users.cultural_origin IS 'Drives globe arc color: India=amber, Fiji=teal, Pakistan=purple.';
COMMENT ON COLUMN users.platform_role IS 'Perspective switching (STAR focal node) is a session/frontend feature, not a stored role.';

-- Deferred self-referential FK constraints (added after bulk insert)
-- ALTER TABLE users ADD CONSTRAINT fk_parent    FOREIGN KEY (parent_id)    REFERENCES users(user_id);
-- ALTER TABLE users ADD CONSTRAINT fk_co_parent FOREIGN KEY (co_parent_id) REFERENCES users(user_id);
-- ALTER TABLE users ADD CONSTRAINT fk_partner   FOREIGN KEY (partner_id)   REFERENCES users(user_id);
-- ALTER TABLE users ADD CONSTRAINT fk_bio_parent FOREIGN KEY (bio_parent_id) REFERENCES users(user_id);

-- Back-fill networks.owner_user_id FK now that users table exists
-- ALTER TABLE networks ADD CONSTRAINT fk_network_owner FOREIGN KEY (owner_user_id) REFERENCES users(user_id);


-- ============================================================
-- 3. RELATIONSHIPS
-- Directed edges between members. 448 rows in lightning-001.
-- ============================================================

CREATE TABLE IF NOT EXISTS relationships (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  network_id        TEXT NOT NULL REFERENCES networks(network_id),
  subject_id        TEXT NOT NULL REFERENCES users(user_id),
  target_id         TEXT NOT NULL REFERENCES users(user_id),
  relation_type     TEXT NOT NULL
                      CHECK (relation_type IN (
                        'BioParent', 'BioChild',
                        'Parent', 'Child',
                        'Sibling',
                        'Spouse',
                        'Cousin',
                        'Friend'
                      )),
  branch            TEXT,                          -- family branch label: Bakshi/Datta, Sidhu, etc.
  note              TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE relationships IS 'Directed relationship edges. subject_id → relation_type → target_id.';


-- ============================================================
-- 4. PETS
-- 8 records in lightning-001. GlobeOptIn all FALSE currently.
-- ============================================================

CREATE TABLE IF NOT EXISTS pets (
  pet_id            TEXT PRIMARY KEY,
  network_id        TEXT NOT NULL REFERENCES networks(network_id),
  owner_id          TEXT NOT NULL REFERENCES users(user_id),
  name              TEXT NOT NULL,
  type              TEXT,                          -- Dog, Cat, etc.
  status            TEXT CHECK (status IN ('Living', 'Passed')),
  birth_mm_yyyy     TEXT,                          -- MM/YYYY only
  birth_location    TEXT,
  current_location  TEXT,
  bio               TEXT,
  photo_id          TEXT,
  globe_opt_in      BOOLEAN NOT NULL DEFAULT FALSE,
  visible_to        TEXT NOT NULL DEFAULT 'all'
                      CHECK (visible_to IN ('all', 'network', 'private')),
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE pets IS 'Pet profiles. Globe appearance gated by globe_opt_in flag.';


-- ============================================================
-- 5. ACCOMPLISHMENTS
-- Announcements / celebrations posted by or on behalf of members.
-- ============================================================

CREATE TABLE IF NOT EXISTS accomplishments (
  accomplishment_id   TEXT PRIMARY KEY,
  network_id          TEXT NOT NULL REFERENCES networks(network_id),
  user_id             TEXT NOT NULL REFERENCES users(user_id),       -- who posted it
  announced_by_user_id TEXT REFERENCES users(user_id),               -- who announced (may differ)
  subject_user_id     TEXT REFERENCES users(user_id),                -- who the accomplishment is about
  subject_name        TEXT,                                          -- free text fallback if not a user

  accomplishment_type TEXT,
  title               TEXT NOT NULL,
  description         TEXT,
  organization_or_venue TEXT,
  location            TEXT,
  date_mm_yyyy        TEXT,                        -- MM/YYYY only

  -- Up to 5 media attachments
  media_id_1          TEXT,
  media_id_2          TEXT,
  media_id_3          TEXT,
  media_id_4          TEXT,
  media_id_5          TEXT,

  share_with_network  BOOLEAN NOT NULL DEFAULT TRUE,
  celebrations_opt_in BOOLEAN NOT NULL DEFAULT TRUE,
  currents            INTEGER NOT NULL DEFAULT 0,  -- engagement score unit

  status              TEXT NOT NULL DEFAULT 'Active'
                        CHECK (status IN ('Active', 'Archived', 'Removed')),

  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE accomplishments IS 'Celebration posts. currents = engagement score unit for the platform.';


-- ============================================================
-- 6. CULTURAL_VOCAB_LIBRARY
-- Kinship terms and cultural vocabulary.
-- Scholars receive attribution here — that is their reciprocity.
-- ============================================================

CREATE TABLE IF NOT EXISTS cultural_vocab_library (
  vocab_id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  term              TEXT NOT NULL,
  language          TEXT NOT NULL,
  cultural_origin   TEXT,                          -- India, Fiji, Pakistan, etc.
  definition        TEXT NOT NULL,
  usage_example     TEXT,
  contributor_id    TEXT REFERENCES users(user_id), -- Scholar attribution
  reviewed          BOOLEAN NOT NULL DEFAULT FALSE,
  visible_to        TEXT NOT NULL DEFAULT 'all'
                      CHECK (visible_to IN ('all', 'network', 'private')),
  network_id        TEXT REFERENCES networks(network_id), -- NULL = global/public term
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE cultural_vocab_library IS 'Public-facing cultural vocabulary. contributor_id = Scholar attribution, not a payment.';


-- ============================================================
-- 7. BANNER_STATEMENTS
-- 15 rotating founding statements on the home page.
-- AI proposal mechanism: max 3/month, admin approval required.
-- Human filter is permanent.
-- ============================================================

CREATE TABLE IF NOT EXISTS banner_statements (
  statement_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  statement_text    TEXT NOT NULL,
  display_order     INTEGER,
  status            TEXT NOT NULL DEFAULT 'Active'
                      CHECK (status IN ('Active', 'Retired', 'Pending')),
  proposed_by       TEXT REFERENCES users(user_id), -- NULL = founding / system
  approved_by       TEXT REFERENCES users(user_id), -- NULL = auto-approved founding
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE banner_statements IS '15 founding rotating banner statements. AI proposals require admin approval. Human filter permanent.';


-- ============================================================
-- 8. BANNER_IMPRESSIONS
-- Engagement tracking per statement per session.
-- ============================================================

CREATE TABLE IF NOT EXISTS banner_impressions (
  impression_id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  statement_id      UUID NOT NULL REFERENCES banner_statements(statement_id),
  user_id           TEXT REFERENCES users(user_id), -- NULL = anonymous visitor
  session_id        TEXT,
  engaged           BOOLEAN NOT NULL DEFAULT FALSE, -- clicked, hovered, interacted
  viewed_at         TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE banner_impressions IS 'Per-impression engagement tracking for banner statements.';


-- ============================================================
-- 9. WAITLIST
-- Pre-launch signups. Email encrypted at rest.
-- ============================================================

CREATE TABLE IF NOT EXISTS waitlist (
  waitlist_id       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email             TEXT NOT NULL,                 -- encrypted at rest
  name              TEXT,
  network_interest  TEXT,                          -- what brought them here
  referral_user_id  TEXT REFERENCES users(user_id),
  status            TEXT NOT NULL DEFAULT 'Pending'
                      CHECK (status IN ('Pending', 'Invited', 'Converted', 'Unsubscribed')),
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE waitlist IS 'Pre-launch interest list. Email encrypted at rest, never displayed.';


-- ============================================================
-- 10. JOURNEYS  (Phase 0 placeholder — full redesign pending)
-- Current data: Birth and Residency records only.
-- Schema intentionally minimal — richer structure coming.
-- ============================================================

CREATE TABLE IF NOT EXISTS journeys (
  journey_id        TEXT PRIMARY KEY,
  network_id        TEXT NOT NULL REFERENCES networks(network_id),
  person_id         TEXT NOT NULL REFERENCES users(user_id),
  location_name     TEXT,
  category          TEXT,                          -- Birth, Residency, Education, Career, etc. (expanding)
  reason            TEXT,
  year              TEXT,                          -- year only, nullable
  media_id          TEXT,
  visible_to        TEXT NOT NULL DEFAULT 'all'
                      CHECK (visible_to IN ('all', 'network', 'private')),
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE journeys IS 'Location/life milestone records. Phase 0 placeholder — full schema redesign pending.';


-- ============================================================
-- INDEXES
-- Core lookup patterns for globe, constellation, directory
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_users_network         ON users(network_id);
CREATE INDEX IF NOT EXISTS idx_users_platform_role   ON users(platform_role);
CREATE INDEX IF NOT EXISTS idx_users_status          ON users(status);
CREATE INDEX IF NOT EXISTS idx_users_cultural_origin ON users(cultural_origin);

CREATE INDEX IF NOT EXISTS idx_relationships_network  ON relationships(network_id);
CREATE INDEX IF NOT EXISTS idx_relationships_subject  ON relationships(subject_id);
CREATE INDEX IF NOT EXISTS idx_relationships_target   ON relationships(target_id);

CREATE INDEX IF NOT EXISTS idx_accomplishments_network ON accomplishments(network_id);
CREATE INDEX IF NOT EXISTS idx_accomplishments_user    ON accomplishments(user_id);

CREATE INDEX IF NOT EXISTS idx_banner_statements_status ON banner_statements(status);
CREATE INDEX IF NOT EXISTS idx_banner_impressions_stmt  ON banner_impressions(statement_id);

CREATE INDEX IF NOT EXISTS idx_vocab_language          ON cultural_vocab_library(language);
CREATE INDEX IF NOT EXISTS idx_vocab_origin            ON cultural_vocab_library(cultural_origin);

CREATE INDEX IF NOT EXISTS idx_journeys_person         ON journeys(person_id);
CREATE INDEX IF NOT EXISTS idx_journeys_network        ON journeys(network_id);

CREATE INDEX IF NOT EXISTS idx_pets_owner              ON pets(owner_id);

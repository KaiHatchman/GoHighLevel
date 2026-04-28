-- ============================================================
-- Universal B2B Outbound Sales Schema Migration
-- Run this in Supabase SQL Editor
-- ============================================================

-- ============================================================
-- STEP 1: Drop tables being removed
-- ============================================================

DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS webhook_events CASCADE;
DROP TABLE IF EXISTS campaign_contacts CASCADE;
DROP TABLE IF EXISTS meetings CASCADE;

-- ============================================================
-- STEP 2: Create companies table
-- ============================================================

CREATE TABLE companies (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  industry text,
  sector text,
  size text,
  website text,
  linkedin_url text,
  city text,
  state text,
  country text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- ============================================================
-- STEP 3: Alter contacts
-- ============================================================

ALTER TABLE contacts
  DROP COLUMN IF EXISTS source,
  DROP COLUMN IF EXISTS source_detail,
  DROP COLUMN IF EXISTS engagement_level,
  DROP COLUMN IF EXISTS next_follow_up_at,
  DROP COLUMN IF EXISTS next_follow_up_notes,
  DROP COLUMN IF EXISTS close_lead_id,
  DROP COLUMN IF EXISTS notes,
  DROP COLUMN IF EXISTS tags,
  DROP COLUMN IF EXISTS assigned_to,
  DROP COLUMN IF EXISTS created_by,
  DROP COLUMN IF EXISTS ghl_synced_at,
  DROP COLUMN IF EXISTS ghl_location_id,
  DROP COLUMN IF EXISTS account_id;

ALTER TABLE contacts
  ADD COLUMN IF NOT EXISTS company_id uuid REFERENCES companies(id);

-- ============================================================
-- STEP 4: Alter campaigns
-- ============================================================

ALTER TABLE campaigns
  DROP COLUMN IF EXISTS description,
  DROP COLUMN IF EXISTS target_geography,
  DROP COLUMN IF EXISTS target_industry,
  DROP COLUMN IF EXISTS target_company_size,
  DROP COLUMN IF EXISTS target_seniority,
  DROP COLUMN IF EXISTS target_segments,
  DROP COLUMN IF EXISTS assigned_to;

-- ============================================================
-- STEP 5: Recreate campaign_contacts
-- ============================================================

CREATE TABLE campaign_contacts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id uuid NOT NULL REFERENCES campaigns(id),
  contact_id uuid NOT NULL REFERENCES contacts(id),
  ghl_opportunity_id text,
  disposition text NOT NULL DEFAULT 'No Contact',
  disposition_changed_at timestamptz,
  enrolled_at timestamptz NOT NULL DEFAULT now(),
  last_contacted_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(campaign_id, contact_id)
);

-- ============================================================
-- STEP 6: Alter call_log
-- ============================================================

ALTER TABLE call_log
  DROP COLUMN IF EXISTS conversation_quality,
  DROP COLUMN IF EXISTS interest_level,
  DROP COLUMN IF EXISTS next_steps,
  DROP COLUMN IF EXISTS objections,
  DROP COLUMN IF EXISTS buying_signals,
  DROP COLUMN IF EXISTS ai_summary,
  DROP COLUMN IF EXISTS ai_summary_text,
  DROP COLUMN IF EXISTS ai_processed_at,
  DROP COLUMN IF EXISTS disposition_reason,
  DROP COLUMN IF EXISTS data_source,
  DROP COLUMN IF EXISTS notes;

-- ============================================================
-- STEP 7: Recreate meetings
-- ============================================================

CREATE TABLE meetings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  contact_id uuid REFERENCES contacts(id),
  campaign_id uuid REFERENCES campaigns(id),
  calendly_event_id text,
  calendly_event_type text,
  scheduled_for timestamptz NOT NULL,
  duration_minutes integer,
  status text NOT NULL DEFAULT 'scheduled',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- ============================================================
-- STEP 8: Add updated_at triggers
-- ============================================================

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS set_updated_at ON companies;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON companies
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

DROP TRIGGER IF EXISTS set_updated_at ON campaign_contacts;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON campaign_contacts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

DROP TRIGGER IF EXISTS set_updated_at ON meetings;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON meetings
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

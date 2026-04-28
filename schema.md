# Database Schema Design

Universal B2B outbound sales schema. No industry-specific assumptions - built to work across any campaign targeting any sector.

---

## contacts

Raw contact data only. Nothing campaign-specific.

| Column | Type | Notes |
|---|---|---|
| `id` | uuid | Primary key |
| `first_name` | text | |
| `last_name` | text | |
| `title` | text | Job title |
| `email` | text | |
| `phone` | text | |
| `normalized_phone` | text | 10-digit, no formatting |
| `linkedin` | text | |
| `city` | text | |
| `state` | text | |
| `country` | text | |
| `company_id` | uuid | FK to companies |
| `ghl_contact_id` | text | GHL sync reference |
| `do_not_contact` | boolean | |
| `created_at` | timestamptz | |
| `updated_at` | timestamptz | |

---

## companies

Company facts only. No operational or campaign data.

| Column | Type | Notes |
|---|---|---|
| `id` | uuid | Primary key |
| `name` | text | |
| `industry` | text | e.g. Staffing & Recruiting |
| `sector` | text | e.g. Legal, Life Sciences, Finance |
| `size` | text | 1-10, 11-50, 51-200, 201-500, 500+ |
| `website` | text | |
| `linkedin_url` | text | |
| `city` | text | |
| `state` | text | |
| `country` | text | |
| `created_at` | timestamptz | |
| `updated_at` | timestamptz | |

---

## campaigns

| Column | Type | Notes |
|---|---|---|
| `id` | uuid | Primary key |
| `name` | text | |
| `status` | text | draft, active, paused, completed |
| `start_date` | date | |
| `end_date` | date | |
| `ghl_location_id` | text | GHL sub-account reference |
| `created_by` | uuid | |
| `created_at` | timestamptz | |
| `updated_at` | timestamptz | |

---

## campaign_contacts

All campaign-specific state for a contact. One row per contact per campaign.

| Column | Type | Notes |
|---|---|---|
| `id` | uuid | Primary key |
| `campaign_id` | uuid | FK to campaigns |
| `contact_id` | uuid | FK to contacts |
| `ghl_opportunity_id` | text | GHL pipeline link |
| `disposition` | text | No Contact, Open, Not Now, Meeting Booked, Closed, Bad Data |
| `disposition_changed_at` | timestamptz | When disposition last changed |
| `enrolled_at` | timestamptz | When contact was added to campaign |
| `last_contacted_at` | timestamptz | Date of last call |
| `created_at` | timestamptz | |
| `updated_at` | timestamptz | |

---

## call_log

One row per call. Disposition is a snapshot taken at call time, updated if BDR changes it after.

| Column | Type | Notes |
|---|---|---|
| `id` | uuid | Primary key |
| `contact_id` | uuid | FK to contacts |
| `campaign_id` | uuid | FK to campaigns |
| `external_call_id` | text | GHL dedup key |
| `caller_user_id` | text | GHL userId of BDR |
| `call_started_at` | timestamptz | |
| `call_ended_at` | timestamptz | |
| `duration_seconds` | integer | |
| `disposition` | text | Snapshot at call time, updated on Pipeline Stage Changed |
| `transcript_raw` | text | |
| `recording_url` | text | |
| `created_at` | timestamptz | |
| `updated_at` | timestamptz | |

---

## meetings

One row per Calendly booking. Matched to contact via phone number.

| Column | Type | Notes |
|---|---|---|
| `id` | uuid | Primary key |
| `contact_id` | uuid | FK to contacts - matched on phone |
| `campaign_id` | uuid | FK to campaigns |
| `calendly_event_id` | text | Calendly sync reference |
| `calendly_event_type` | text | e.g. 30 min intro |
| `scheduled_for` | timestamptz | |
| `duration_minutes` | integer | |
| `status` | text | scheduled, completed, cancelled, no-show |
| `created_at` | timestamptz | |
| `updated_at` | timestamptz | |

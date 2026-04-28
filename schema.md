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

*(in progress)*

---

## campaign_contacts

*(in progress)*

---

## call_log

*(in progress)*

---

## meetings

*(in progress)*

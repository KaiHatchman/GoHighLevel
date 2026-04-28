# GoHighLevel

TypeScript integration for the GoHighLevel API. Covers the tasks used day-to-day: contacts, conversations, calendar, opportunities, and inbound webhooks.

## Setup

```bash
git clone https://github.com/KaiHatchman/GoHighLevel.git
cd GoHighLevel
npm install
cp .env.example .env
```

Fill in `.env` with your credentials (never commit this file).

## Environment Variables

| Variable | Description |
|---|---|
| `GHL_API_KEY` | Bearer token from GHL Settings - API Keys |
| `GHL_LOCATION_ID` | Your GHL location/sub-account ID |
| `PORT` | Webhook server port (default: 3000) |

## Modules

| File | What it does |
|---|---|
| `client.ts` | Shared axios client - base URL + auth headers |
| `contacts.ts` | Get, create, update contacts + add/remove tags |
| `conversations.ts` | Get messages, send SMS/Email/WhatsApp |
| `calendar.ts` | Get events + appointment notes |
| `opportunities.ts` | Search and update pipeline opportunities |
| `webhook-handler.ts` | Inbound GHL webhook router |
| `index.ts` | Express server entry point |

## Usage

```typescript
import { createContact, addTags } from './contacts';
import { getCalendarEvents } from './calendar';
import { searchOpportunity } from './opportunities';

// Create a contact
const contact = await createContact({ firstName: 'Jane', phone: '+15551234567' });

// Tag them
await addTags(contact.id, ['prospect', 'cold-outreach']);

// Pull this week's calendar events
const events = await getCalendarEvents({
  startTime: '2026-04-28T00:00:00Z',
  endTime: '2026-05-04T23:59:59Z',
});
```

## Webhook Server

Run locally:
```bash
npm run dev
```

Point your GHL workflow webhook URL to:
```
https://your-domain.com/webhook/ghl
```

Add your handler logic inside `webhook-handler.ts` for each event type.

## Adding to GitHub Secrets

Go to **Settings - Secrets and variables - Actions** in this repo and add `GHL_API_KEY` and `GHL_LOCATION_ID`.

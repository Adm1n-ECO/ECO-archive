# ECO Billing, Legal & Platform Longevity

---

## PRICING (LOCKED March 2026)

| Tier | Monthly | Annual | Who |
|---|---|---|---|
| Conductor | $5.99 | ~$50/yr (~17% disc) | Every user — founders, moderators, Keepers |
| Pro Conductor | $8.99 | ~$76/yr | Event Windows, expanded media, advanced viz |
| Org Admin | $14.99 | $179.88/yr | Org networks only. 1-3 per org. |
| Student | $3.00 | N/A — monthly only | Academic partner cohorts. 9-month limit. Full access. |
| Free_Forever | $0 | $0 | Lightning-001 grandfathered |

**Student tier notes:**
- Full Conductor feature access — no restrictions
- 9 months maximum at student rate (one academic year)
- Requires cohort access code from faculty partner
- Converts to standard Conductor rate ($5.99) at term end with 30-day notice
- Family members invited by student pay standard Conductor rate from day 61
- No student rate for family members — the student is the acquisition point
- Cohort code provisioned by admin per faculty partner request

Blended individual: ~$6.89/month (70% Conductor × $5.99 + 30% Pro × $8.99)

---

## BILLING MODEL

### No Auto-Renewal
User makes a deliberate choice each period. When period ends, it ends.
No charge appears unless user actively renews.
Platform's responsibility: send honest renewal reminder.
User's trust signal: we are not trying to trap you.

### No Cancellation Fee. Ever.
No early termination fee. No cancellation penalty.
Cancellation must be as easy as signup — same click count.

### Refund Policy
Monthly: non-refundable (1-month commitment)
Annual: non-refundable once period starts (12-month commitment)
No mid-commitment refunds. User knew what they committed to.

### Renewal Reminders
- 14 days before expiry (not 30 — specifically for senior users)
- Secondary notification opt-in: designated family member also notified
  - Opt-in field: "Would you like a family member to receive billing reminders?"
  - Notifier receives: renewal approaching notification ONLY
  - Notifier cannot see network contents
- Rationale: A parent on a cruise, or simply offline, doesn't lose their account

---

## SPONSOR MODEL

Any Conductor can pay for any profile.

### Sponsor Schema
```
People_Master:
  SponsorUserID    text    UserID of billing sponsor; null = self-pay
  HouseholdLabel   text    User-defined billing group name
```

### Household = billing group label only. No structural meaning.
Example billing dashboard:
```
Vikas Bakshi (you — Conductor)   $5.99
Reema Bakshi                     $5.99
Isaiah Bakshi                    $5.99
Madan Bakhshi †                  $0.00  (Passed)
Nirupma Bakhshi                  $5.99
─────────────────────────────────────
Bakshi household                $23.96

Narendra Singh                   $5.99
Jaiwati Singh                    $5.99
─────────────────────────────────────
Singh household                 $11.98

Total monthly                   $35.94
```

Passed profiles cost the same as living — stewardship has value.

---

## INSTITUTIONAL PRICING

### Founding Partner Pricing (First 10 Orgs Nationally)
- Seats 1-100: $3.00/month (50% off $5.99)
- Seats 101-200: $4.49/month (25% off $5.99)
- Seats 201+: regular $5.99
- **Permanent — no 12-month expiry**
- Org Admin seats: $14.99/month, separate from seat tiers

### After First 10 Orgs
Standard pricing from day one of contract.

### Billing Mechanics
- Single invoice to organization monthly
- Org manages seat allocation
- Members receive access, no individual invoices
- Unused seats carry forward

### Sample Revenue
- 200-seat founding partner org: $8,988/year
- 200-seat regular org: $14,376/year

---

## FREEZE NOT DELETE

### Individual Accounts
- Cancelled → 90-day preservation → freeze indefinitely
- Frozen: account suspended, content preserved, visible to network as-was
- Explicit deletion: specific flow, irreversibility confirmed, no refund
- Deletion is permanent and irreversible — and it is always the user's choice.
  If a user wants everything gone completely, that choice is theirs alone.
  No questions. No friction beyond a single irreversibility confirmation.
  Total deletion, on their terms, at any time.

### The freeze default exists to protect users — not to trap them
The default on lapse is freeze, not delete, because data lost in a moment
of financial difficulty should not be permanent. The network waits.
The stories are still there when the user comes back.
But "freeze not delete" is a default, not a cage. Deletion is always
available, always the user's choice, and always complete.

### Network Persistence
- Network never deleted due to any individual's lapse
- If Founder lapses: network continues with existing Moderators
- If last Moderator lapses: network continues, awaiting nomination
- Network inheritance: Founder designates a successor before needed

### Organizational Networks
- Lapsed subscription: 90-day window → freeze indefinitely
- Rechargeable at any time — network reactivates exactly as left
- Explicit deletion: formal written org request only

---

## DATA PORTABILITY

### Export Contents
- **Type A** (user-created): full content — stories, profiles added, photos uploaded
- **Type B** (own profile): full content
- **Type C** (tagged-in by others): reference log only — contributor name, date, no full text

### Export Formats
- GEDCOM (family structure)
- JSON (full structured data)
- Available at any time — not gated behind cancellation

### Access Rules
- /my-data accessible regardless of subscription status
- Payment lapse NEVER locks data access
- Erasure requests completed within 30 days (GDPR)

---

## PARTNER AFFILIATE MODEL

ECO never advertises. Partners never appear on ECO pages.

### Mechanics
- ECO detects context: upcoming milestone, story mention of relevant activity
- ECO prompts in its own voice (never the partner's)
- User clicks → new tab to partner site
- ECO receives referral signal only
- No partner tracking pixels on ECO pages
- No user data shared with partners without explicit consent

### Copy Principle
"You mentioned you have a wedding coming up. Would you like help with planning, photos, or travel? Click to reach our partners."

### Partner Categories
- Wedding/event planning
- Photo albums and print services
- Travel booking
- Cultural heritage tours
- Document digitization

---

## LEGAL REQUIREMENTS (pre-Phase 1 launch)

### Priority 1 — Must fix before any non-family user
- [ ] COPPA age gate on signup
- [ ] Legal docs live (Termly or Legalmattic)
- [ ] Three DPAs signed: Supabase, Vercel, Anthropic
- [ ] data@eternalcurrent.online routing in Cloudflare
- [ ] "Your Current Belongs to You" on landing page
- [ ] Cookie consent banner

### Priority 2 — Must fix before paid launch
- [ ] Stripe billing integration + trial flow
- [ ] My Data page (/my-data) — always accessible
- [ ] Erasure / opt-out flow (30-day completion)
- [ ] Legalmattic TOS + attorney review ($500-2,000)
- [ ] Notification frequency cap
- [ ] Block/mute feature
- [ ] Privacy attorney review before public launch

### Priority 3 — Pre-scale
- [ ] India DPDP Act compliance (deadline May 2027)
- [ ] Server-side graph traversal >200 nodes
- [ ] Media storage (Cloudflare R2 or Supabase Storage)
- [ ] Churn prevention re-engagement email (90-day inactivity)

---

## PLATFORM LONGEVITY PRINCIPLES

1. **Storage is cheap** — freeze costs less than user goodwill lost by deletion
2. **Seven generations principle** — design for what ECO looks like 150 years from now
3. **Data is permanent** — the user's story is theirs; the platform is the container
4. **No account/network evaporates silently** — always preserved unless explicitly deleted
5. **Re-entry cost = renewal only** — returning users find everything exactly as they left it

---

## COMPLIANCE NOTES

### GDPR
- Erasure completed within 30 days
- Data Subject Access Request (DSAR) handled via /my-data
- Data minimization: city-level only, MM/YYYY only, no government IDs

### CCPA
- "Do Not Sell My Information" on landing page (threshold: 100,000+ CA users)
- No sale of personal data — architectural

### COPPA
- Age gate on signup
- No data collection from under-13 without verifiable parental consent

### India DPDP Act (May 2027 deadline)
- Verifiable parental consent for under-18 Indian residents
- Data localization considerations Phase 3

---

## PLATFORM PRIVACY PROMISES (LOCKED — user-facing commitments)

These are stated explicitly to users on the platform and website.
They are permanent commitments, not marketing preferences.

### Email privacy
User email addresses are never visible to any other member of
any network on the platform, regardless of role. Email exists
solely as the mechanism by which the platform contacts the user.
It is not displayed in the network directory, not shared with
other Conductors, not used for any communication other than
platform-originated messages. This is architectural, not a setting.

### No sensitive documents ever required
No DNA sample. No government-issued ID. No birth certificate.
No social security number or equivalent. No passport data.
No medical or financial records of any kind.
The platform builds from stories, names, and what people choose
to share conversationally — nothing else is required or accepted.
This is a permanent commitment that distinguishes ECO from
Ancestry, 23andMe, and any platform that treats genealogical
records as primary data.

### No advertisers. Ever.
No advertiser can pay to reach users through the platform.
No behavioral data is sold, licensed, or made available to
advertising networks or third-party marketers.
No in-platform advertising of any kind.
You are not the product. You never will be.
This commitment survives any ownership change, investment round,
or partnership agreement. It is a permanent and unconditional
platform policy.


# GSD Economical

**Stop burning Opus tokens on boilerplate. Save 50-70% on your GSD builds.**

A plugin for [Get Shit Done](https://github.com/gsd-build/get-shit-done) that automatically classifies your build phases by complexity and routes the cheapest viable model to each one.

```
/gsd:economical
```

One command. Reads your roadmap, classifies every phase, configures the routing, done.

---

## The Problem

GSD defaults to `balanced` profile: Opus for planning, Sonnet for execution. That's smart â€” but it's the same profile whether you're scaffolding a Dockerfile or building a real-time pipeline.

You're running Opus on tasks where Haiku could do the job.

## The Fix

GSD Economical classifies each phase into four complexity tiers and assigns the cheapest model + effort level that can actually handle the work:

| Tier | What It Builds | Model | Effort | Cost vs Opus |
|------|---------------|-------|--------|-------------|
| **1 â€” Scaffolding** | Config, setup, boilerplate | Sonnet | low | ~80% cheaper |
| **2 â€” Standard** | CRUD, components, tests | Sonnet | medium | ~55% cheaper |
| **3 â€” Complex** | Multi-system integration | Opus | high | Baseline |
| **4 â€” Architectural** | System design decisions | Opus | max | ~2x baseline |

**Result:** A 7-phase build that might cost ~$21 on all-Opus runs for ~$8-10 with Economical routing. On Claude Max, that means fewer rate limit hits and longer uninterrupted sessions.

---

## Install

```bash
# Clone into your .claude directory
git clone https://github.com/Shepard-Consulting/gsd-economizer.git /tmp/gsd-economizer

# Copy the plugin files
cp /tmp/gsd-economizer/commands/gsd/economical.md ~/.claude/commands/gsd/
mkdir -p ~/.claude/gsd-economical
cp -r /tmp/gsd-economizer/workflows/economical.md ~/.claude/gsd-economical/
cp -r /tmp/gsd-economizer/references/classification-rules.md ~/.claude/gsd-economical/

# Clean up
rm -rf /tmp/gsd-economizer
```

Or for a single project:

```bash
# From your project root
cp /tmp/gsd-economizer/commands/gsd/economical.md .claude/commands/gsd/
mkdir -p .claude/gsd-economical
cp -r /tmp/gsd-economizer/workflows/economical.md .claude/gsd-economical/
cp -r /tmp/gsd-economizer/references/classification-rules.md .claude/gsd-economical/
```

**Requires:** GSD installed (`npx get-shit-done-cc@latest`)

---

## Usage

### Standard Flow

```bash
# 1. Start your project normally
claude --dangerously-skip-permissions
/gsd:new-project
# [Answer questions, approve roadmap]

# 2. Classify and configure routing
/gsd:economical

# 3. Build with optimized routing
/clear
/model sonnet          # or whatever Phase 1 is assigned
/effort low
/gsd:plan-phase 1
/clear
/gsd:execute-phase 1
# Repeat, switching models per the ECONOMICAL.md assignments
```

### Autonomous Mode

```bash
/gsd:new-project
/gsd:economical --auto   # Skip approval, auto-classify
/clear
/gsd:autonomous           # Runs all phases
```

### What It Creates

| File | Purpose |
|------|---------|
| `.planning/ECONOMICAL.md` | Full classification report with savings estimate |
| `.planning/config.json` | Updated with per-phase model assignments |
| `CLAUDE.md` | Model routing protocol that persists across `/clear` |

---

## How Classification Works

The classifier reads each phase description in `ROADMAP.md` and matches against signal words:

**Tier 1 signals:** setup, scaffold, initialize, configure, Dockerfile, CI/CD, README, seed data

**Tier 2 signals:** CRUD, REST API, components, forms, schema, migrations, tests, styling

**Tier 3 signals:** integration, pipeline, webhook, real-time, state machine, RBAC, caching, multi-tenant

**Tier 4 signals:** architecture, data model design, migration strategy, performance optimization, distributed, security architecture

**Tie-breaking rule:** When uncertain between two tiers, pick the lower one. Save Opus for where it matters.

---

## Real Example

A 7-phase build (similar to a CRM/pipeline dashboard):

```
Phase 1: Foundation (schema, seed data)        â†’ Tier 2 â†’ Sonnet @ medium
Phase 2: Core API (CRUD endpoints)             â†’ Tier 2 â†’ Sonnet @ medium
Phase 3: Pipeline Integration (webhooks, sync)  â†’ Tier 3 â†’ Opus @ high
Phase 4: Dashboard UI (React components)        â†’ Tier 2 â†’ Sonnet @ medium
Phase 5: Real-time Updates (websockets)         â†’ Tier 3 â†’ Opus @ high
Phase 6: Auth & Permissions (RBAC)              â†’ Tier 3 â†’ Opus @ high
Phase 7: Deployment (Railway, Docker)           â†’ Tier 1 â†’ Sonnet @ low

Opus phases: 3/7 (43%)
Sonnet phases: 4/7 (57%)
Estimated savings: ~55% vs all-Opus
```

---

## FAQ

**Does this work with `/gsd:autonomous`?**

Yes, but with a caveat. Autonomous mode spawns subagents that inherit the session model. The CLAUDE.md routing block tells Claude to switch models between phases, which works when running phase-by-phase. In fully autonomous mode, using `claude --model opusplan` as your base gives you the automatic plan=Opus/execute=Sonnet split, which covers most of the savings.

**What if Sonnet can't handle a phase?**

The CLAUDE.md block includes an escalation rule: if a task fails 3 times on Sonnet, it auto-escalates to Opus. You never get stuck.

**Does this change GSD itself?**

No. This is a plugin â€” it adds one slash command and writes config files. GSD core is untouched. When GSD updates, your Economical config stays intact.

**What about Haiku?**

GSD's `budget` profile already uses Haiku for verification. Economical doesn't currently route execution to Haiku because it struggles with multi-file logic. But for truly trivial phases (file renames, copyright updates), you could manually set `/model haiku`.

---

## Built By

**[Shepard Consulting](https://shepardconsulting.ai)** â€” AI automation for businesses that build things.

We help contractors, trades businesses, and real estate operators implement AI systems that save time and money. GSD Economical is how we run our own builds.

Want us to set up your AI development workflow? [Let's talk.](https://shepardconsulting.ai)

---

## License

MIT â€” same as GSD core. Use it, fork it, ship it.


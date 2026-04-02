# Economical Model Routing Workflow

## Pre-flight Check

<step name="validate">
1. Run: `INIT=$(node ./.claude/get-shit-done/bin/gsd-tools.cjs init economical 2>/dev/null || echo '{}')`
2. Check that `.planning/ROADMAP.md` exists. If not, tell the user:
   "Run `/gsd:new-project` first — I need a roadmap to classify."
   Stop here.
3. Read `.planning/ROADMAP.md` completely.
4. Read `.planning/config.json` if it exists.
5. Read the classification rules from `@./.claude/gsd-economical/references/classification-rules.md`
</step>

## Phase Classification

<step name="classify">
For each phase listed in ROADMAP.md:

1. Read the phase title and description
2. Look for signal words from the classification rules
3. Apply the decision tree:
   - Setup/config with no business logic → Tier 1
   - Well-known pattern, single system → Tier 2
   - Multiple systems or edge case handling → Tier 3
   - Wrong = rebuild everything downstream → Tier 4
4. When uncertain between two tiers, pick the LOWER tier
5. Record: phase number, phase name, tier, model, effort, rationale (one sentence)
</step>

## Present Classification for Approval

<step name="present">
Display the classification to the user in this format:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  GSD ECONOMICAL — Phase Classification
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Phase 1: [Name]
  ├── Tier [X] → [Sonnet/Opus] @ [effort]
  └── Why: [one-sentence rationale]

  Phase 2: [Name]
  ├── Tier [X] → [Sonnet/Opus] @ [effort]
  └── Why: [one-sentence rationale]

  [... all phases ...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SUMMARY
  Sonnet phases: [N] of [Total] ([X]%)
  Opus phases:   [N] of [Total] ([X]%)
  Estimated savings vs all-Opus: ~[X]%
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

If `--auto` flag was NOT passed:
  Use AskUserQuestion to ask:
  - header: "Phase Classification"
  - question: "Does this classification look right? You can adjust any phase tier."
  - options: ["Looks good — configure it", "I want to adjust some phases"]

  If the user wants adjustments, ask which phases to change and re-classify.

If `--auto` flag was passed:
  Skip approval and proceed directly.
</step>

## Write Configuration

<step name="configure">
After approval (or --auto):

### 1. Write ECONOMICAL.md

Create `.planning/ECONOMICAL.md` with the full classification report:

```markdown
---
created: [timestamp]
total_phases: [N]
sonnet_phases: [N]
opus_phases: [N]
estimated_savings: [X]%
---

# Economical Model Routing

## Phase Assignments

| Phase | Name | Tier | Model | Effort | Rationale |
|-------|------|------|-------|--------|-----------|
| 1 | [Name] | [X] | [Model] | [Effort] | [Rationale] |
| ... | ... | ... | ... | ... | ... |

## Model Switching Commands

Before each phase, run:
[List the /model and /effort commands for each phase]

## Savings Estimate

- All-Opus baseline: ~$[X] estimated
- Economical routing: ~$[X] estimated
- Savings: ~[X]%
```

### 2. Update config.json

Read the existing `.planning/config.json`. Set the model profile to match the FIRST phase's tier:
- If Phase 1 is Tier 1 or 2: set profile to "budget" or "balanced"
- If Phase 1 is Tier 3 or 4: set profile to "quality"

Add an `economical` key to config.json:

```json
{
  "economical": {
    "enabled": true,
    "phase_assignments": {
      "1": { "tier": 1, "model": "sonnet", "effort": "low" },
      "2": { "tier": 2, "model": "sonnet", "effort": "medium" },
      "3": { "tier": 3, "model": "opus", "effort": "high" }
    }
  }
}
```

Write the updated config.json back.

### 3. Append to CLAUDE.md

Check if `CLAUDE.md` exists in the project root. If not, create it. If it exists, append to it.

Add this block (DO NOT duplicate if it already contains "## Economical Model Routing"):

```markdown

## Economical Model Routing

This project uses GSD Economical to minimize AI model costs without sacrificing quality.

### Before Each Phase

Check `.planning/ECONOMICAL.md` for the assigned model and effort level, then run:
- `/model [assigned_model]` to switch models
- `/effort [assigned_level]` to set thinking depth

### Phase Assignments

[Insert the phase table from ECONOMICAL.md]

### Escalation Rule

If a Sonnet executor fails the same task 3 times, escalate:
1. Stop execution
2. `/model opus`
3. `/effort high`
4. Re-run the failing task
5. After success, switch back to the assigned model for remaining tasks

### Post-Build Quality Check

After all phases complete, run Opus verification on Sonnet-built phases:
```
/model opus
/effort high
/gsd:verify-work [phase_number]
```
```

</step>

## Report and Next Steps

<step name="report">
Tell the user:

```
✅ GSD Economical configured.

Files written:
  .planning/ECONOMICAL.md — Full classification report
  .planning/config.json   — Model routing config
  CLAUDE.md               — Routing protocol (persists across /clear)

Next steps:
  /clear
  /model [first_phase_model]
  /effort [first_phase_effort]
  /gsd:plan-phase 1

Or for autonomous mode:
  /clear
  /gsd:autonomous
  (Note: autonomous mode works best with opusplan as the base model)
```
</step>

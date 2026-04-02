---
allowed-tools: Bash(node:*), Bash(cat:*), Bash(echo:*), Read, Write, Edit
argument-hint: "[--auto]"
---

<objective>
Analyze the current GSD roadmap and automatically configure the most cost-efficient model routing for each phase. Classifies phases by complexity, assigns the cheapest viable model + effort level per phase, writes the routing config, and optionally kicks off the build.

**Requires:** A completed `/gsd:new-project` with ROADMAP.md present.

**Creates/Updates:**
- `.planning/config.json` — model_overrides per phase
- `.planning/ECONOMICAL.md` — phase classification report with savings estimate
- `CLAUDE.md` — model routing protocol block (appended)

**After this command:** Run `/gsd:plan-phase 1` or `/gsd:autonomous` to start building with optimized model routing.
</objective>

<execution_context>
@./.claude/gsd-economical/workflows/economical.md
@./.claude/gsd-economical/references/classification-rules.md
</execution_context>

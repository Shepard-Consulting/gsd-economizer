# Phase Classification Rules

## Complexity Tiers

Each GSD phase is classified into one of four tiers based on what it builds. The tier determines which model runs the phase and at what effort level.

### Tier 1 — Scaffolding (Sonnet @ low effort)

**What it is:** Boilerplate, config, setup. No business logic decisions.

**Signal words in ROADMAP.md:**
- "setup", "scaffold", "initialize", "configure", "boilerplate"
- "Dockerfile", "docker-compose", "CI/CD", "deployment", "env"
- "README", "documentation", "package.json", "tsconfig"
- "directory structure", "project setup", "seed data"
- "linting", "formatting", "prettier", "eslint"

**Examples:**
- Project initialization with file structure
- Environment configuration and .env setup
- CI/CD pipeline (GitHub Actions, Railway, Vercel)
- Docker containerization
- README and documentation generation
- Seed data scripts (when schema is already defined)

---

### Tier 2 — Standard Implementation (Sonnet @ medium effort)

**What it is:** Straightforward features following well-known patterns. One system, one concern.

**Signal words in ROADMAP.md:**
- "CRUD", "REST API", "endpoints", "routes"
- "components", "UI", "pages", "forms", "layout"
- "database schema", "migrations", "models"
- "unit tests", "test suite"
- "basic auth", "login", "signup" (standard patterns)
- "styling", "CSS", "Tailwind", "responsive"

**Examples:**
- Database schema and migrations
- Standard CRUD API endpoints
- React/Next.js page components
- Form handling and validation
- Basic authentication (JWT, session)
- Unit and integration test suites
- Dashboard UI with charts/tables (using libraries)

---

### Tier 3 — Complex Integration (Opus @ high effort)

**What it is:** Multi-system coordination, non-trivial logic, edge case handling. Two or more systems talking to each other.

**Signal words in ROADMAP.md:**
- "integration", "pipeline", "orchestration", "sync"
- "webhook", "event-driven", "queue", "pub/sub"
- "real-time", "websocket", "SSE", "streaming"
- "state machine", "workflow engine"
- "third-party API", "external service"
- "error handling", "retry logic", "circuit breaker"
- "RBAC", "permissions", "role-based", "security hardening"
- "caching strategy", "rate limiting"
- "multi-tenant", "tenant isolation"

**Examples:**
- Webhook handlers that trigger multi-step processes
- Real-time data sync between systems
- Complex permission/authorization systems
- Pipeline orchestration (LeadStrike-style enrichment chains)
- Payment processing with error recovery
- Multi-service API integration layers
- Background job processing with retry logic

---

### Tier 4 — Architectural (Opus @ max effort)

**What it is:** System design decisions that affect everything downstream. Getting this wrong means rebuilding.

**Signal words in ROADMAP.md:**
- "architecture", "design", "foundation"
- "data model", "schema design" (when complex relationships)
- "migration strategy", "refactor"
- "performance optimization", "scaling"
- "concurrency", "race condition", "distributed"
- "security architecture", "encryption", "zero-trust"
- "AI/ML pipeline", "model serving"

**Examples:**
- Core data model with complex entity relationships
- Migration strategy for live production data
- Distributed system architecture decisions
- Performance optimization requiring profiling + restructuring
- Security architecture for sensitive data flows
- AI/ML inference pipeline design

---

## Classification Decision Tree

```
For each phase in ROADMAP.md:

1. Does it involve SETUP/CONFIG with no business logic?
   → Tier 1 (Sonnet @ low)

2. Does it follow a WELL-KNOWN PATTERN with one system?
   → Tier 2 (Sonnet @ medium)

3. Does it coordinate MULTIPLE SYSTEMS or handle EDGE CASES?
   → Tier 3 (Opus @ high)

4. Does getting it WRONG mean rebuilding other phases?
   → Tier 4 (Opus @ max)

When in doubt between two tiers, pick the LOWER one.
Save Opus for where it actually matters.
```

## Effort Level Mapping

| Tier | Model  | Effort | Approx Token Cost | Max Plan Budget |
|------|--------|--------|--------------------|-----------------|
| 1    | Sonnet | low    | ~$0.30/50K tokens  | 30% context     |
| 2    | Sonnet | medium | ~$0.90/50K tokens  | 50% context     |
| 3    | Opus   | high   | ~$1.50/50K tokens  | 60% context     |
| 4    | Opus   | max    | ~$3.00/50K tokens  | 80% context     |

## Savings Calculation

Compare against all-Opus-high baseline:

```
savings_pct = 100 * (1 - (sum_of_phase_costs / (num_phases * opus_high_cost)))
```

Round-trip estimate per phase (planning + execution + verification):
- Tier 1: ~100K tokens → ~$0.60
- Tier 2: ~150K tokens → ~$1.35
- Tier 3: ~200K tokens → ~$3.00
- Tier 4: ~300K tokens → ~$7.50

All-Opus baseline per phase: ~200K tokens → ~$3.00

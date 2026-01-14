# ADR-005: CI/CD Strategy & Evolution

**Status:** Accepted  
**Date:** 2026-01-13  
**Decision Type:** Delivery & Automation Strategy  

## Changelog
- **2026-01-13** — Initial decision recorded; establishes staged CI/CD evolution model

---

## Context

The Order Processing System (OPS) is developed and maintained across **four dedicated repositories**, each with a clearly defined responsibility:

- `order-system-architecture` — Architecture as Code (authoritative source of truth)
- `order-system-docs` — Documentation site and knowledge base
- `order-system-infrastructure` — Infrastructure as Code (Terraform)
- `order-system-services` — Executable backend (modular monolith)

The system needs **consistency, automated builds, validation, and deployment workflows**.

The CI/CD strategy must:

- support the **Architecture-as-Code (AaC)** approach
- preserve **clear ownership boundaries** between repositories
- enable **fast feedback loops** during development
- avoid premature coupling or over-orchestration
- remain **evolvable** toward enterprise-grade automation

---

## Decision

At the current stage of development, OPS will adopt the following CI/CD strategy:

> **One pipeline per repository — coordinated by conventions, not by a master pipeline.**

Each repository owns and maintains its own CI/CD pipeline, aligned with its specific responsibility.
Cross-repository coordination is achieved through shared standards and architectural agreements,
not through centralized orchestration.

A **centralized, system-level orchestrator** is explicitly **deferred** to a later iteration.

---

## Rationale

This decision aligns with the current system maturity and architectural goals:

- Repositories are **logically related but not operationally inseparable**
- Changes in one repository do not always require redeployment of the entire system
- Debugging, iteration speed, and contributor autonomy are critical at this stage
- CI/CD complexity should grow **with the system**, not ahead of it

The chosen approach enables:

- independent validation and feedback per concern (architecture, code, infra, docs)
- simpler pipelines with smaller failure blast radius
- clearer ownership and accountability
- easier local reproduction of CI failures

This is the **minimum viable automation** that satisfies current needs without constraining future evolution.

---

## CI/CD Responsibility Model

| Repository | CI/CD Responsibility |
|-----------|---------------------|
| `order-system-architecture` | Validate ADRs, diagrams, architecture consistency |
| `order-system-docs` | Build and publish documentation |
| `order-system-infrastructure` | Terraform init / validate / plan (apply later) |
| `order-system-services` | Build, test, package, Docker image creation |

All pipelines follow shared conventions for:

- branching model
- naming
- secrets management
- environment separation
- artifact versioning

---

## Alternatives Considered

### 1. Centralized Orchestration (Global Pipeline)

**Description**  
A single “golden pipeline” orchestrates all repositories as one logical system,
executing architecture validation, infrastructure provisioning, application build,
deployment, and documentation publishing in a strict sequence.

**Status:** Deferred

**Pros**
- Strong system-level guarantees
- Explicit ordering and dependencies
- Enterprise-aligned deployment model
- Suitable for large teams and regulated environments

**Cons**
- High initial complexity
- Tight coupling between repositories
- Slower feedback loops
- Larger failure blast radius
- Harder debugging and local reproduction

**Assessment**  
Architecturally valid but **premature** for the current scope and scale of OPS.

---

### 2. Separate CI/CD Repository

**Description**  
A dedicated repository contains all pipeline definitions and orchestrates other repos.

**Status:** Rejected

**Reason**
- Introduces hidden coupling
- Pipelines drift from the code they operate on
- Violates ownership clarity
- Adds operational overhead without immediate benefit

---

## Consequences

### Positive
- Fast and isolated feedback cycles
- Clear ownership per repository
- Lower operational and cognitive load
- CI/CD evolves incrementally with the system

### Trade-offs
- No system-wide deployment guarantees yet
- Cross-repository compatibility relies on discipline and conventions
- Full end-to-end automation deferred

These trade-offs are **explicit and accepted** at this stage.

---

## Evolution Strategy

The CI/CD strategy for the Order Processing System defined by this ADR is intentionally **staged and incremental**,
aligned with the overall architectural maturity of the system.  
This staged approach ensures that architecture is **defined first**, then **automated and deployed**,
and finally **explained and demonstrated**, avoiding premature complexity while preserving a clear
evolution path toward enterprise-grade CI/CD orchestration.

---

## Decision Scope

This ADR applies to:

- CI/CD ownership model
- Pipeline structure and responsibility boundaries
- Automation strategy at the current development stage

It does **not** define:

- specific CI/CD tools or vendors
- cloud provider–specific deployment details
- environment promotion rules

Those concerns will be addressed in future ADRs as the system evolves.

---

## References

- `ADR-001` — Modular Monolith Architecture
- `ADR-003` — Deferred Microservices & Distribution
- Iteration plans — Executable Architecture, Validation, Integration
- Repository READMEs for implementation details

---

**Decision Accepted — CI/CD will evolve incrementally, prioritizing clarity, autonomy, and architectural alignment over premature centralization.**

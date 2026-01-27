# ADR-005: CI/CD Strategy & Evolution

**Status:** Accepted  
**Date:** 2026-01-13  
**Decision Type:** Delivery & Automation Strategy

## Changelog
- **2026-01-13** — Initial decision recorded; staged CI/CD evolution model introduced
- **2026-01-26** — Updated to align with ADR-006 and ADR-007; clarified CI/CD scope, documentation pipelines, and responsibility boundaries

---

## Context

The Order Processing System (OPS) is developed as a demonstration of **Architecture as Code (AaC)**,
with explicit architectural governance and intentional system evolution.

Following **ADR-006: Centralize Architecture and Documentation**, all architecture and architecture-related
documentation for OPS is consolidated into a single authoritative repository:

- `order-system-architecture`

The OPS codebase is maintained across **multiple repositories**, each with a clearly defined responsibility:

- `order-system-architecture` — Architecture as Code, ADRs, diagrams, and documentation (authoritative source of truth)
- `order-system-services` — Executable backend (modular monolith)
- `order-system-infrastructure` — Infrastructure as Code (Terraform)

OPS requires **automated validation, builds, and deployment workflows**, while preserving:

- clear ownership boundaries between concerns,
- architectural intent over tooling convenience,
- fast feedback loops,
- low operational and cognitive overhead,
- an explicit and realistic evolution path toward more advanced CI/CD.

---

## Decision

OPS adopts the following CI/CD strategy:

> **One pipeline per repository — coordinated by architectural conventions, not by centralized orchestration.**

Each repository **owns and maintains its own CI/CD pipeline**, aligned strictly with its responsibility.
Cross-repository coordination is achieved through **architectural agreements and ADRs**, not through a
global or “golden” pipeline.

A **system-level CI/CD orchestrator** is explicitly **deferred** to a later iteration.

---

## CI/CD Scope Clarification

To avoid ambiguity, CI/CD responsibilities are explicitly scoped.

### CI/CD **includes**
- Application build, test, packaging, and deployment
- Documentation build, validation, and publishing
- Architecture validation and consistency checks

### CI/CD **excludes**
- Infrastructure provisioning and destruction
- Terraform apply operations
- Environment lifecycle management
- Runtime orchestration beyond application deployment

Infrastructure remains **manually managed and intentionally controlled** at this stage.

This boundary is **explicit and accepted**.

---

## CI/CD Responsibility Model

| Repository | CI/CD Responsibility |
|-----------|---------------------|
| `order-system-architecture` | Validate ADRs, render diagrams, build and publish architecture documentation |
| `order-system-services` | Build, test, package, containerize, and deploy the Order Service |
| `order-system-infrastructure` | Terraform init / validate / plan (apply deferred and manual) |

Each pipeline operates **independently** and can evolve at its own pace.

---

## Alignment with Architectural Decisions

### Alignment with ADR-006 (Centralized Architecture & Documentation)

- Architecture and documentation CI/CD is owned by `order-system-architecture`.
- Documentation pipelines treat architecture as a **first-class artifact**.
- Application and infrastructure repositories contain **minimal README content** and reference the architecture repository.

CI/CD reinforces the principle that **architecture is authoritative**, not derived from implementation.

---

### Alignment with ADR-007 (Documentation Structure & Diagram Strategy)

- Documentation CI/CD renders content **only from declarative sources**:
    - Markdown
    - Structurizr DSL
    - (Optionally) PlantUML
- CI/CD pipelines **do not introduce new documentation tools or formats**.
- Diagram rendering is deterministic, reproducible, and version-controlled.
- CI/CD does not embed screenshots, manually edited images, or external diagram sources.

Documentation CI/CD is **external to the system runtime** and does not appear in runtime or deployment diagrams.

---

## CI/CD Architecture Perspective

CI/CD pipelines are treated as **external delivery mechanisms**, not runtime components of OPS.

From a C4 perspective:

- CI/CD is an **external system**
- It does not participate in:
    - runtime workflows
    - system interactions
    - deployment topology

This preserves architectural clarity and diagram purity.

---

## Rationale

This strategy:

- aligns automation with architectural intent,
- prevents premature centralization,
- preserves repository autonomy and ownership,
- reduces failure blast radius,
- enables fast, focused feedback loops,
- supports Architecture as Code principles,
- remains compatible with enterprise-grade CI/CD evolution.

CI/CD complexity grows **with the system**, not ahead of it.

---

## Alternatives Considered

### 1. Centralized System-Level Pipeline

**Status:** Deferred

A single pipeline orchestrating architecture validation, infrastructure provisioning,
application build, deployment, and documentation publishing.

**Assessment:**  
Architecturally valid but premature for the current scope and maturity of OPS.

---

### 2. Dedicated CI/CD Repository

**Status:** Rejected

**Reason:**
- Introduces hidden coupling
- Separates pipelines from the code they operate on
- Weakens ownership and accountability
- Adds operational overhead without immediate benefit

---

## Consequences

### Positive
- Clear CI/CD ownership per concern
- Strong alignment with architectural governance
- Independent and fast feedback cycles
- Lower operational complexity
- Clean evolution path toward advanced CI/CD

### Trade-offs
- No system-wide deployment guarantees yet
- Cross-repository compatibility relies on architectural discipline
- Full end-to-end automation is intentionally deferred

These trade-offs are **explicit, documented, and accepted**.

---

## Evolution Strategy

The CI/CD strategy for OPS evolves incrementally:

1. Architecture and documentation defined and validated
2. Application build and deployment automated
3. Infrastructure automation introduced cautiously
4. System-level orchestration evaluated when justified

This ensures **architecture leads automation**, not the other way around.

---

## Decision Scope

This ADR governs:

- CI/CD ownership model
- Pipeline responsibility boundaries
- CI/CD scope at the current system maturity

It explicitly does **not** define:

- specific CI/CD tools or vendors
- cloud-provider-specific deployment mechanics
- environment promotion strategies

Those concerns are addressed in separate ADRs as OPS evolves.

---

**Decision Accepted — CI/CD evolves incrementally, reinforcing architectural clarity, ownership, and intentional system growth.**

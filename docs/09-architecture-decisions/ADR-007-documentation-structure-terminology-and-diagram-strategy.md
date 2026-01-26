# ADR-007: Documentation Structure, Terminology, and Diagram Strategy

## Status

**Status:** Accepted  
**Date:** 2026-01-19  
**Decision Type:** Architecture Documentation & Visualization

## Context

Following **ADR-006: Centralize Architecture and Documentation**, all architectural knowledge for the
Order Processing System (OPS) is consolidated into the `order-system-architecture` repository.

With documentation ownership clarified, the next challenge was to define:

- a **clear and recognizable documentation structure**,
- consistent and human-friendly **diagram naming and terminology**,
- explicit rules for **architectural diagrams**,
- and guardrails that prevent documentation drift or over-tooling.

OPS documentation must serve multiple purposes:

- architectural reasoning and governance,
- onboarding and knowledge transfer,
- communication with non-architect stakeholders,
- preparation and reuse for presentations.

This required explicit decisions on **structure, terminology, diagram rules, and publishing approach**.

---

## Decision

### 1. Documentation Structure Standard

OPS documentation follows a **rough (curated) arc42 structure**, adapted to the system’s scope and goals.

- arc42 provides the **primary documentation backbone**.
- Only relevant sections are included.
- Sections may contain subfolders with detailed documents.
- Each section has a dedicated overview file.

The structure prioritizes **clarity and architectural intent**, not completeness of the arc42 template.

---

### 2. Diagram Naming and Terminology

To avoid confusion and reduce cognitive load, we explicitly separate:

- **human-facing diagram names** (used in documentation and presentations),
- **C4 / Structurizr view names** (used in modeling tools).

Both are valid and intentionally mapped.

#### Diagram Naming Mapping

| Purpose | General Documentation Name | C4 / Structurizr View |
|-------|----------------------------|-----------------------|
| System boundaries and actors | System Context Diagram | System Context View |
| High-level internal structure | Architecture Overview Diagram | Container View |
| Runtime behavior | Runtime Workflow Diagram | Dynamic View |
| Infrastructure & deployment | Infrastructure Diagram | Deployment View |

Rules:
- Documentation and presentations use **diagram** terminology.
- Structurizr DSL and C4 modeling use **view** terminology.
- This mapping is documented and kept stable.

---

### 3. Diagram Strategy (Declarative First)

All architecturally significant diagrams must be:

- **Declarative**
- **Version-controlled**
- **Reproducible**

Approved tools:

- **Structurizr DSL** — authoritative source for structural and runtime diagrams
- **PlantUML** — supporting diagrams when Structurizr is not suitable

Explicitly forbidden:

- Draw.io
- Manually edited images
- Screenshots
- Diagram screenshots embedded in Markdown

---

### 4. Documentation Execution and Rendering

Documentation is developed and validated **locally first**.

- Architects and contributors run documentation locally during authoring.
- Diagrams are rendered locally from source (DSL / Markdown).
- No runtime diagram servers are required.

This ensures fast feedback, deterministic output, and low operational overhead.

---

### 5. Documentation Publishing Model

Documentation is published as a **static site**.

- Deployment targets are intentionally flexible:
  - **GitHub Pages**
  - **AWS S3 (optionally with CloudFront)**
- The final platform choice is **explicitly deferred**.
- The documentation structure and content remain platform-agnostic.

This allows OPS documentation to evolve without being coupled to a specific hosting solution.

---

## Rationale

This approach:

- reduces documentation complexity,
- avoids premature infrastructure decisions,
- enforces architectural discipline,
- aligns with Architecture as Code principles,
- produces documentation suitable for both real systems and public communication.

---

## Consequences

### Positive

- Clear and human-readable documentation structure.
- Stable and explicit diagram naming.
- Strong separation between architecture and implementation.
- Diagrams remain synchronized with the architectural model.
- Documentation can be published to multiple platforms without refactoring.

### Negative / Trade-offs

- Initial effort to define and document naming conventions.
- Requires discipline to keep diagram naming consistent.
- Final hosting decision is postponed and must be addressed later.

---

## Notes

This ADR focuses on **structure, terminology, and rules**, not on detailed content.
Content evolution is expected within these boundaries.

---

**Decision Accepted — documentation structure, diagram naming, and publishing model are governed explicitly and intentionally.**

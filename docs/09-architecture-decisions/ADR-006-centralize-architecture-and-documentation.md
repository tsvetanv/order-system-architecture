# ADR-006: Centralize Architecture and Documentation

## Status

**Status:** Accepted  
**Date:** 2026-01-19  
**Decision Type:** Architecture & Documentation

## Context

The Order Processing System (OPS) is developed as a demonstration of **Architecture as Code (AaC)**.
 Throughout the evolution of the system, multiple repositories were introduced to separate concerns
(application code, infrastructure, documentation).

During Iteration 4 of OPS development, the following challenges emerged:

- Architecture documentation was distributed across multiple repositories.
- README files duplicated or partially overlapped architectural knowledge.
- Mapping documentation between repositories and documentation tools introduced unnecessary complexity.
- Architectural intent risked being diluted by tooling concerns rather than clarified by them.

At the same time, OPS requires:

- a **single source of truth** for architectural knowledge,
- strong traceability between decisions, diagrams, and documentation,

These constraints led to a re-evaluation of the documentation strategy.

---

## Decision

We decided to **centralize all architecture and architecture-related documentation into the `order-system-architecture` repository** and treat it as the **authoritative architectural source of truth**.

Specifically:

- All architectural documentation (arc42 structure, ADRs, architectural rules, requirements, diagrams) resides in `order-system-architecture`.
- Documentation content previously located in the `order-system-services` and `order-system-infrastructure` repositories is migrated and refactored into the architecture repository.
- The former `order-system-docs` repository is deprecated and removed.
- Architecture documentation is authored and maintained using:
    - Markdown for textual content
    - Structurizr DSL for architectural diagrams
    - Version control for traceability and controlled evolution

The architecture repository is designed to be:

- readable independently of application code,
- suitable for architectural reviews and onboarding,
- resilient to future system evolution.

---

## Rationale

This decision was made to:

- Reduce cognitive overhead caused by cross-repository documentation mapping.
- Eliminate duplication and prevent documentation drift.
- Reinforce the principle that **architecture is a primary artifact**, not secondary documentation.
- Enable fast onboarding, architectural analysis, and decision traceability from a single location.
- Align documentation practices with real-world production needs.

---

## Consequences

### Positive

- A single, explicit architectural source of truth.
- Strong alignment between decisions, diagrams, and documentation.
- Clear architectural ownership and governance.
- Simplified documentation maintenance.
- Clear separation between architecture knowledge and implementation repositories.

### Negative / Trade-offs

- The architecture repository becomes more central and requires discipline to maintain.
- Code repositories intentionally contain minimal README content and reference architecture documentation.
- Some implementation details must be summarized or abstracted when promoted to architectural documentation.

---

## Notes

This ADR intentionally focuses on **architectural governance and knowledge management**, not on documentation tooling.
Specific documentation rendering or visualization tools are addressed in separate architectural decisions.

---

**Decision Accepted — architecture documentation is treated as a first-class artifact.**

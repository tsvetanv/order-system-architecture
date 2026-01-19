# Architecture Decision Records (ADR)

This folder contains the **Architecture Decision Records** for the Order Processing System.

ADRs document key architectural decisions, including:
- context & motivation
- explored alternatives
- consequences & trade-offs
- links to requirements and models
- evolution strategy (if applicable)

The ADRs support the Architecture-as-Code workflow by ensuring:
- traceability between requirements → decisions → models → implementation
- historical transparency (decisions are additive, not rewritten)
- reversibility and evolvability of architecture


## Current Decisions (Iteration 1 — Baseline)

| ID | Title | Status | Summary |
|----|--------|---------|----------|
| **ADR-001** | Adopt Modular Monolith with 4 Containers | Accepted | Establishes the baseline architecture style and container boundaries. |
| **ADR-002** | Integration Model & Service Communication Approach | Accepted | Defines synchronous, gateway-based integration strategy for internal/external communication. |
| **ADR-003** | Deferred Microservices & Distribution Strategy | Accepted | Microservices are *deferred*, not rejected; distribution is intentional and NFR-driven. |

> All ADRs relate to the primary NFRs: **Maintainability**, **Time-to-Market**, **Reliability**.

## ADR Workflow (How We Work)

1. **Propose** — new ADR drafted when making a consequential decision.
2. **Discuss** — evaluate alignment with requirements & existing ADRs.
3. **Decide** — mark as `Accepted`, `Deferred`, or `Rejected`.
4. **Evolve** — future ADRs may *amend* or *supersede* older ones.

> ADRs are **append-only** — decisions are not removed, only superseded if invalidated.

## Status Conventions

- `Accepted` — decision is active
- `Deferred` — valid, but not applied yet (waiting for triggers)
- `Superseded` — replaced by a later ADR
- `Rejected` — considered but not adopted

If terminology or rationale changes, the ADR receives an:
**Update Note / Changelog entry** (not rewritten history).

---

## Traceability

ADRs connect with:
- `/requirements/requirements-refined.md`
- `/c4/workspace.dsl`
- Infrastructure (Terraform) in `order-system-infrastructure`
- Application code in `order-system-services`
- Documentation site in `order-system-docs` 

## Related Repositories

- Architecture (source of truth):  
  https://github.com/tsvetanv/order-system-architecture

- Infrastructure as Code:  
  https://github.com/tsvetanv/order-system-infrastructure

- Application code:  
  https://github.com/tsvetanv/order-system-services

- Documentation site:  
  https://github.com/tsvetanv/order-system-docs

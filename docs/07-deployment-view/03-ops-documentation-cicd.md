# OPS Documentation – CI/CD Pipeline

## Purpose

This document describes the **CI/CD pipeline for OPS architecture documentation**.

The goal of this pipeline is to treat **architecture documentation as a first-class, deployable artifact**,
fully aligned with the **Architecture as Code (AaC)** approach adopted by the Order Processing System (OPS).

This pipeline ensures that architectural decisions, diagrams, and documentation are:
- consistent,
- reproducible,
- automatically rendered,
- and publicly accessible.

---

## Scope

### Included
- arc42-based architecture documentation (Markdown)
- Architecture diagrams defined as code:
  - Structurizr DSL (authoritative)
  - PlantUML (supporting, limited use)
- Static site generation
- Publishing via GitHub Pages

### Explicitly Excluded
- Application build and deployment
- Infrastructure provisioning (Terraform)
- Runtime system deployment
- Multi-environment documentation
- Versioned documentation
- Preview environments

This scope is **intentional** and aligned with the current maturity of OPS.

---

## Trigger Model

The documentation CI/CD pipeline is triggered by:

- `push` to the `main` branch of the `order-system-architecture` repository

This reflects the role of the architecture repository as the **authoritative source of architectural knowledge**.

---

## High-Level Pipeline Stages

The pipeline consists of the following conceptual stages:

```
Source Change
      ↓
Validate
      ↓
Render Diagrams
      ↓
Assemble Static Site
      ↓
Publish Documentation
```

Each stage has a **single responsibility** and produces deterministic output.

---

## Stage 1 – Validate Documentation Sources

### Responsibility
Validate documentation inputs before rendering.

### Inputs
- Structurizr DSL workspace (`workspace.dsl`)
- arc42 Markdown documentation (`docs/**`)
- PlantUML source files (if present)

### Outcome
- Fail-fast behavior if sources are invalid
- No rendering or publishing attempted on invalid input

This prevents publishing broken or inconsistent architectural documentation.

---

## Stage 2 – Render Architecture Diagrams (Structurizr)

### Responsibility
Render structural and runtime architecture diagrams from declarative sources.

### Key Characteristics
- Structurizr DSL is the **single source of truth** for:
  - System Context
  - Container View
  - Deployment View
  - Dynamic (Runtime) Views
- Diagrams are rendered **at build time**
- No runtime diagram servers are used

### Important Rule
Rendered diagram binaries (SVG/PNG) are **not stored in version control**.
They exist only in the generated site output.

This strictly follows the **Declarative First** rule defined in ADR-007.

---

## Stage 3 – Render Supporting Diagrams (PlantUML)

### Responsibility
Render diagrams that are not suitable for Structurizr modeling.

### Characteristics
- Used sparingly and intentionally
- Rendered at build time
- Output format: SVG
- Referenced by documentation pages

Structurizr remains the **authoritative tool** for core architectural views.

---

## Stage 4 – Assemble Static Documentation Site

### Responsibility
Assemble a fully static documentation site.

### Output Characteristics
- HTML pages
- Embedded rendered diagrams
- Static assets (CSS, JS)
- No server-side logic
- Deterministic and reproducible output

The generated site is the **deployable artifact**.

---

## Stage 5 – Publish Documentation

### Target Platform
- **GitHub Pages**

### Publishing Model
- Single canonical site
- Previous version overwritten
- No version history exposed
- Public read-only access

This keeps documentation **easy to consume** and **operationally minimal**.

---

## Security Model

- No secrets required
- No cloud credentials
- No authentication for readers
- No runtime services

The attack surface is limited to a static site hosted by GitHub.

---

## Ownership & Responsibilities

| Concern | Owner |
|------|------|
| Documentation content | Architects / contributors |
| Diagram correctness | CI/CD pipeline |
| Rendering | CI/CD pipeline |
| Hosting | GitHub Pages |
| Availability | GitHub |

---

## Relationship to Other CI/CD Pipelines

This pipeline is **independent** of:
- OPS application CI/CD
- Infrastructure provisioning workflows

This separation follows the strategy defined in **ADR-005: CI/CD Strategy & Evolution**.

---

## References

- ADR-005 – CI/CD Strategy & Evolution
- ADR-006 – Centralize Architecture and Documentation
- ADR-007 – Documentation Structure, Terminology, and Diagram Strategy
- OPS Infrastructure Handbook (external)
- OPS CI/CD Handbook (external)

---

## Evolution & Known Limitations

The following improvements are **explicitly deferred**:
- Preview documentation per pull request
- Versioned documentation
- Migration to S3 / CloudFront
- Documentation search

These are documented as **accepted technical debt** and may be addressed in later iterations.

---

## Summary

OPS documentation is authored declaratively, rendered at build time, and published as a static site via GitHub Pages.

This CI/CD pipeline ensures architectural consistency, traceability, and accessibility,
while remaining intentionally simple, secure, and evolvable.

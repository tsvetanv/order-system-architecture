# Rule: Layered Architecture (Order Service)

## Architectural Intent

Derived from:

- **ADR-001** — Maintainable modular structure
- Primary NFR: **Maintainability**

Order Service follows a layered design:

- `api` — HTTP & adapters
- `application` — use cases
- `domain` — business rules
- `infrastructure` — persistence & adapters

---

## Constraints

- Domain layer must not depend on Spring or JPA
- API layer must not access repositories directly
- Infrastructure may depend on application & domain

---

## ADR Traceability

- **ADR-001** — Internal modularity discipline
- **ADR-003** — Supports extraction readiness

---

## Enforcement

- Enforced via **ArchUnit**
- Test class: `LayeringTest`

# Rule: Module Dependency Boundaries

## Architectural Intent

Derived from:

- **ADR-001** — Modular Monolith Architecture
- **ADR-003** — Deferred Microservices Strategy
- C4 Container Model (`workspace.dsl`)

The Order Processing System is a **Modular Monolith**
with **intentional container boundaries**.

```
Customer → Order API → Order Service → Order Database
↓
Integration Service → External Systems
```

---

## Containers

| Container | Responsibility |
|---------|----------------|
| Order API | HTTP routing & API contract |
| Order Service | Domain workflows |
| Order Database | Persistence |
| Integration Service | External coordination |

---

## Constraints

### Allowed Dependencies

- `order-api → order-service`
- `order-service → order-database`
- `order-service → integration-service`

### Forbidden Dependencies

- `order-api → order-database`
- `order-api → integration-service`
- `order-database → any module`
- cyclic dependencies between modules

---

## ADR Traceability

- **ADR-001** — Defines container boundaries
- **ADR-003** — Requires boundaries to remain enforceable
  to support future extraction

---

## Enforcement

- Enforced via **ArchUnit**
- Test class: `ModuleDependencyTest`

# Rule: Integration Service as Anti-Corruption Layer

## Architectural Intent

Derived from:

- **ADR-002** — Integration Model
- **ADR-001** — Modular Monolith

The Integration Service is the **single outbound gateway**.

```
Order Service → Integration Service → External Systems
```

---

## Constraints

- Only Integration Service may depend on:
    - payment
    - inventory
    - notification
    - accounting
- Order Service must not reference external systems directly

---

## ADR Traceability

- **ADR-002** — Centralized outbound gateway
- **ADR-003** — Enables safe future extraction

---

## Enforcement

- Enforced via **ArchUnit**
- Test class: `IntegrationBoundaryTest`

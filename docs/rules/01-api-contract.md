# Rule: OpenAPI as Source of Truth

## Architectural Intent

Derived from:

- **ADR-001** — Modular Monolith Architecture
- API-first assumption in `requirements-refined.md`

The Order API is **contract-first** and **not a runtime application**.

---

## Constraints

- No `@RestController` or `@Controller` in `order-api`
- No Spring Web runtime logic in `order-api`
- OpenAPI specification is the single external contract
- Controllers live in **Order Service**

---

## ADR Traceability

- **ADR-001** — Separation of responsibilities
- **ADR-003** — Prevents accidental microservice-style drift

---

## Enforcement

- Enforced via **ArchUnit**
- Test class: `ApiContractTest`

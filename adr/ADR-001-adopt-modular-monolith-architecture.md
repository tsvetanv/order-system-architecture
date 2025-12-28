# ADR-001: Adopt a Modular Monolith with 4 Containers

**Status:** Accepted  
**Date:** 2025-12-28  
**Decision Type:** Architectural Baseline

---

## 🎯 Context

The Order Processing System (OPS) is the core system responsible for managing
the lifecycle of customer orders. The architecture must support:

- a clear separation of responsibilities
- maintainability and testability
- integration with external systems (Payment, Inventory, Notifications, Accounting)
- incremental delivery and future scaling options
- an Architecture-as-Code approach for traceability and automation

Initial requirements indicate a moderate domain complexity with real-time integration needs,
but no justification for independent deployment or team autonomy per module (yet).

---

## 🧩 Decision

We will structure OPS as **four containers** within a
**Modular Monolith architecture**:

| Container | Responsibility | Tech Stack |
|-----------|----------------|-------------|
| **Order API** | Entry point, request handling, routing | REST API (Spring Boot) |
| **Order Service** | Domain workflows & business logic | Java / Spring Boot |
| **Order Database** | Persistent data storage | PostgreSQL |
| **Integration Service** | Communication with external systems | Java / Spring Boot |

This structure is defined and versioned in `c4/workspace.dsl`.

**Architecture Style Chosen:**
> **Modular Monolith with clear container boundaries**

---

## 💡 Rationale

This structure is chosen because it:

✔ Encourages separation of concerns  
✔ Keeps internal communication simple and fast (in-process)  
✔ Supports incremental modularization if needed later  
✔ Allows local development without heavy infrastructure  
✔ Simplifies the initial learning curve for the demo and the AaC narrative  
✔ Aligns with deployment goals for the demo (single deployment unit)  

Alternative patterns (e.g. microservices or event-driven SOA) were considered but rejected for now.

---

## 🚫 Alternatives Considered (and Rejected)

| Option | Status | Reason for Rejection |
|--------|--------|----------------------|
| **Microservices** | Rejected | Introduces distributed complexity without business or team benefits |
| **Single-layer monolith** | Rejected | Harder to maintain, no modular separation for growth |
| **Event-driven modules** | Deferred | Adds architectural complexity; may be introduced later for scalability or async integration |

---

## 📈 Consequences

### Positive
- Fast feedback cycles in development
- Lower infrastructure cost and overhead
- Clear architectural structure for newcomers
- Strong candidate for Architecture-as-Code automation

### Negative / Trade-offs
- Containers are not independently deployable (by design, for now)
- Future scaling may require container extraction
- Requires discipline to preserve boundaries in code

### Future Opportunities
- Containers may evolve into microservices if needed
- Asynchronous integration (e.g., SNS/SQS) can be introduced in later iterations

---

## 📌 Decision Scope

This ADR applies to:

- Code structure
- Integration approach (synchronous, request-driven)
- Deployment packaging (single application for now)
- C4 Container View

This ADR does *not* define:

- Data model details
- API contracts
- External system responsibilities
- Deployment infrastructure

Those will be addressed in later ADRs.

---

## 🧾 References

- `c4/workspace.dsl`
- `/requirements/*.md`

---

**Decision Accepted — Modular Monolith established as the baseline architecture style.**


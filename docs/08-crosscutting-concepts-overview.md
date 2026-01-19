# Architectural Guardrails

This section documents the **architectural validation rules** enforced via
**ArchUnit tests** as part of the Architecture-as-Code (AaC) workflow.

These rules act as **fitness functions**:
they do not describe the architecture — they **protect decisions already made**
and documented in ADRs.

The purpose of these guardrails is to ensure that the implemented code
continues to comply with the **intentional architectural decisions**
as the system evolves.

---

## Integration Boundary Guardrail

**Related ADRs**
- ADR-002 — Integration Model & Service Communication Approach
- ADR-001 — Modular Monolith Architecture

### Architectural Intent

The Order Processing System uses a **dedicated Integration Service**
as an **Anti-Corruption Layer (ACL)**.

- The **Order Service** expresses *intent* via **integration interfaces**
- The **Integration Service** owns all outbound communication
- External systems and client libraries are isolated behind the Integration Service

The integration interfaces are **internal abstractions**, owned by the system,
and are part of the Modular Monolith.  
They do **not** represent external system coupling.

### What is Allowed

- Order Service → Integration **interfaces**
- In-process calls within the Modular Monolith
- Synchronous, in-JVM collaboration as defined in ADR-002

### What is Forbidden

- Order Service → HTTP clients (Feign, OkHttp, Apache HTTP, etc.)
- Order Service → Cloud or vendor SDKs (AWS SDK, etc.)
- Order Service → Integration **implementation details** or adapters

### Enforcement

This rule is enforced via an **ArchUnit test** in the `order-system-services`
repository.

The test ensures that:
- the Order Service depends only on integration abstractions
- no accidental direct coupling to external systems is introduced

If violated, the build fails immediately.

### Why This Matters

This guardrail:
- preserves architectural integrity
- prevents accidental erosion of boundaries
- enables future extraction of the Integration Service
- keeps the implementation aligned with ADR-002

## Module-Scoped Layering Guardrail

**Related ADRs**
- ADR-001 — Modular Monolith Architecture

### Architectural Intent

Layering rules are defined **per module boundary**, not globally.

The `order-service` module is responsible for:
- API exposure
- Application-level orchestration
- Coordination with Domain (via `order-database`)
- Coordination with Integration (via interfaces)

The **Domain model** is implemented in the `order-database` module  
(e.g. `order.database.domain`, `order.database.entity`).

The **Infrastructure layer** (Terraform, environments) is implemented in a
**separate repository** (`order-system-infrastructure`) and is **not Java code**.

As a result:
- not all architectural layers exist in every module
- layering rules must reflect actual module responsibilities

At this stage, the **Mapping layer collaborates with the Application layer**
for pricing calculations, value object handling, and DTO composition.
This is an **intentional design choice** and is enforced
explicitly by the architectural guardrails.

### Enforcement

The Layering ArchUnit test:
- validates layering **within the `order-service` module only**
- does **not** assume the presence of Domain or Infrastructure code in this module
- enforces correct dependencies between API, application, and internal support layers

This prevents:
- accidental cross-layer dependencies
- misuse of API or mapping layers
- architectural drift inside the module boundary

---

> Architectural rules are derived from **decisions**, not conventions.  
> Guardrails must evolve only when ADRs evolve.

# ADR-002: Integration Model & Service Communication Approach

**Status:** Accepted  
**Date:** 2025-12-28  
**Related:** ADR-001 — Adopt a Modular Monolith with 4 Containers

## Context

The Order Processing System (OPS) interacts with multiple external systems:
- Payment System
- Inventory System
- Notification System
- Accounting System

The architecture must define **how OPS communicates** with those external systems and how internal modules collaborate.

Key drivers:
- Architecture-as-Code as a guiding methodology
- Primary NFRs (from `requirements-refined.md`): 
  - Maintainability
  - Time-to-Market
  - Reliability
- Low-latency operations
- Fast feature delivery for the demo
- Single developer context (initially)

## Decision

We will use a **synchronous request/response integration model** for communication:
- **Internal communication:** In-process function calls (within the Modular Monolith)
- **External communication:** HTTPS REST via **Integration Service**

### Integration Mechanism Summary

| Boundary | Communication Style | Protocol/Technology |
|----------|----------------------|-----------|
| Order API → Order Service | In-process call | Java / Spring |
| Order Service → Database | Stateful | JDBC |
| Integration Service → External Systems | Remote call | HTTPS / REST |

The **Integration Service** acts as the **single outbound gateway** to all external dependencies, centralizing:
- communication patterns  
- error handling  
- retry behavior  
- basic observability hooks

This model defines a clear responsibility separation and aligns with the Modular Monolith chosen in ADR-001.

## Rationale

This decision directly supports the **primary NFRs**:

| NFR | How this decision supports it |
|-----|-------------------------------|
| **Maintainability** | Single communication boundary simplifies refactoring and future evolution. |
| **Time-to-Market** | Minimal infrastructure & cognitive load → faster delivery. |
| **Reliability** | Centralized integration logic enables consistent retry/fallback mechanisms. |

Additional rationale:

- Lower infrastructure complexity (no event brokers, no message queues yet)  
- Easier to test & debug in early stages  
- Faster AWS deployment path (API Gateway → Service → DB)  
- Clear AaC demonstration (tracing decisions → models → validation → code)

##  Alternatives Considered & Rejected

| Option | Status | Reason |
|--------|--------|--------|
| Microservices for each module | ❌ Rejected | Unnecessary distribution & deployment overhead at current scale |
| Event-driven integration (SNS/SQS/Kafka) | ⏳ Postponed | Could be introduced later based on NFR scaling needs |
| Direct module → external system calls | ❌ Rejected | Couples domain services to external systems & breaks separation |


## 📈 Consequences

### Positive
- Faster development and onboarding
- Easier to demonstrate Architecture-as-Code workflows
- Clear evolution path for scaling and distribution
- Compatible with IaC-first deployment on AWS

### Negative / Trade-offs
- Integration Service may become **a bottleneck** at scale
- Limited resilience compared to event-driven design
- Additional effort required to add async patterns later

### Reliability Scope Clarification
This decision satisfies the reliability requirement for **baseline resilience**, meaning:
- failure isolation at the Integration Service
- retry/circuit breaker candidates (not yet implemented)
- no high availability guarantees in this delivery

**High Availability and Scalability are recognized as future NFRs**, not baseline drivers.

## Future Evolution Path

This decision keeps doors open for:
- Extracting Integration Service as a microservice
- Introducing async messaging (SNS/SQS/EventBridge)
- Applying circuit breakers / bulkheads (e.g., Resilience4j)
- Scaling read vs write paths independently (CQRS option)

These directions align with the **secondary NFRs** identified in `requirements-refined.md`:
- Scalability
- High Availability
- Observability

## References

- ADR-001 — Modular Monolith Architecture
- `/requirements/requirements-refined.md`
- `/c4/workspace.dsl` (container relationships)

**Decision Accepted — synchronous integration baseline established.**
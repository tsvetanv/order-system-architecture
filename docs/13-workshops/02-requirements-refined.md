# Requirements (Refined)

This document restructures the initial raw requirements into a formalized architecture input.
It identifies functional scope, architectural drivers, key non-functional requirements,
and constraints influencing architectural decisions.



## Functional Requirements (FRs)

1. **Place Order**
   - Customer can submit an order consisting of one or more products.

2. **Check Inventory**
   - Before confirming an order, the system validates product availability via the Inventory System.

3. **Process Payment**
   - The system requests payment from the Payment System and receives a confirmation or failure response.

4. **Report to Accounting**
   - Confirmed orders are reported to the Accounting System for financial tracking.

5. **Send Order Notifications**
   - Customers receive updates when order status changes (e.g., confirmed, rejected).

---

## Non-Functional Requirements (NFRs)

### Primary Architectural Drivers

| NFR | Description | Impact on Architecture |
|-----|--------------|------------------------|
| **Maintainability** | Architecture must evolve easily and remain understandable and refactorable. | Drives modular monolith & container boundaries. |
| **Time-to-Market** | System must support rapid delivery without infrastructure overhead. | Justifies sync-first & simplified deployment model. |
| **Reliability** | External service failures must not corrupt internal state. | Requires retry/fallback strategy; async may evolve later. |

### Secondary (Future) NFRs

The following requirements were identified in the initial stakeholder input
but are **not primary architectural drivers in the first delivery of Order Processing System**.
They will influence later architectural evolution.

- **Scalability** — The system should scale vertically or horizontally as needed.
- **High Availability** — The system should minimize downtime in future iterations.
- **Observability** — Monitoring and logging requirements will be evaluated once runtime characteristics are known.

These NFRs are acknowledged but **not optimized in the the current architecture of the Order Processing System**.



## Constraints

- System must integrate with external systems using HTTPS REST APIs.
- Initial deployment will be in AWS (ECS/Fargate or EC2 for demo scope).
- Database must be PostgreSQL.
- Architecture must be represented and versioned as code.

## Assumptions

- High transaction throughput is not required initially.
- A single team (or individual) develops and maintains the system.
- External systems are stable but may have intermittent failures.
- No real payment transactions are processed — sandbox environments expected.

## Out of Scope (for the current delivery)

- Fraud detection
- Shopping cart / basket management
- Order cancellations & refunds
- Bulk/Batch order processing
- Multi-currency & tax rules
- Real payment integration

## Architectural Drivers Summary

The architecture is intentionally optimized for the current context:

- **Architecture Style:** Modular Monolith (evolvable structure)
- **Communication Principle:** Sync-first (request/response)
- **Integration Pattern:** Centralized outbound gateway (Integration Service)
- **Evolution Strategy:** Scale by extraction (container → microservice) if justified by future NFRs

This approach satisfies the primary NFRs (Maintainability, Time-to-Market, Reliability)
while acknowledging that future deliveries may introduce:
- asynchronous messaging
- service decomposition
- distributed deployment


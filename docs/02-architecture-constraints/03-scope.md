# System Scope & Boundaries – Order Processing System

This document defines the functional boundaries of the Order Processing System.

Explicit scoping is critical to:
- control complexity
- reduce ambiguity
- keep the demo realistic and time-bounded

---

## In Scope (Core Responsibilities)

The Order Processing System provides the following core capabilities:

1. **Create Order**
   - Accept order requests
   - Validate basic order structure

2. **Process Order**
   - Coordinate with external systems (payment, inventory)
   - Update order status accordingly

3. **Track Order Status**
   - Persist order state transitions
   - Expose order status via APIs

4. **Cancel Order**
   - Allow cancellation of eligible orders
   - Notify dependent external systems

---

## Out of Scope (Explicitly Excluded)

The following concerns are intentionally excluded:

- Payment execution logic
- Inventory reservation and stock management
- Shipment execution
- Pricing and discount calculations
- Customer identity management
- User interface or frontend applications
- Fraud detection or business rule engines

---

## External Dependencies

- Payment System
- Inventory System
- Notification System
- Accounting System

These systems are integrated but not owned by the Order Processing System.

---

## Constraints & Assumptions

- The system is API-first
- The system runs on AWS
- Managed cloud services are preferred
- Architecture and infrastructure are defined as code

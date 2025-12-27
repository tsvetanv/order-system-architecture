# Domain Definition – Order Processing System

## Domain Name

**Order Processing System (OPS)**

The Order Processing System is responsible for managing the lifecycle of customer orders from creation to completion or cancellation, coordinating with external systems such as payment, inventory, and notifications.

---

## Actors

| Actor | Description |
|------|------------|
| Customer | End user placing an order |
| Merchant | Business selling goods or services |
| Order Management Operator | Internal user managing orders |
| Payment System | External system responsible for handling payments |
| Inventory System | External system managing product availability |
| Notification System | External system responsible for sending notifications |
| Accounting System | External system for financial reporting |

---

## Core Domain Concepts

| Term | Description |
|----|------------|
| Order | A customer request to purchase goods or services |
| Order Item | A single product or service within an order |
| Order Status | State of an order (Created, Processing, Completed, Cancelled) |
| Customer | Entity placing the order |
| Payment Reference | Identifier linking an order to a payment |
| Shipment | Representation of order fulfillment |
| Cancellation | Termination of an order before completion |

---

## Relationships

- A **Customer** creates one or more **Orders**
- An **Order** contains one or more **Order Items**
- An **Order** has exactly one **Order Status** at any time
- An **Order** references a **Payment** handled by an external Payment System
- An **Order** may trigger **Notifications**
- An **Order** may result in **Shipments**
- An **Order** may be **Cancelled** before completion

---

## Terminology Rules

- The Order Processing System owns the **order lifecycle**
- Payment, inventory, and notifications are external concerns
- Domain terminology must be used consistently across architecture artifacts

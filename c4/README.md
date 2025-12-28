# C4 Architecture Model – Order Processing System

This folder contains the **C4 architecture models** for the Order Processing System.

The C4 model is used to:
- visualize the system at different levels of abstraction
- align stakeholders and engineers
- keep architecture executable and versioned as code

## Scope of C4 in this Project

The C4 model is based on the following architecture inputs:
- `requirements/domain.md`
- `requirements/scope.md`
- `requirements/requirements-raw.md`

The C4 diagrams **do not redefine requirements** — they interpret them.

## Levels

- **Context**  
  Shows the Order Processing System, its users, and external systems.

- **Container**  
  Shows major runtime containers (services, databases).

Component and Code levels are intentionally excluded from this demo.

## Modeling Approach

- Structurizr DSL is used
- Models are versioned in Git
- Diagrams are generated automatically
- Architecture evolves iteratively

## Non-Goals

- No UI-level details
- No vendor-specific infrastructure in C4
- No implementation classes

C4 diagrams must remain **simple, readable, and presentation-friendly**.


## Run & View the C4 Architecture Model


From the repository root in a **WSL terminal** run:
```bash
./run-structurizr.sh
```
Open in browser:

```code
http://localhost:8080
```
This will render the model defined in `c4/workspace.dsl`.

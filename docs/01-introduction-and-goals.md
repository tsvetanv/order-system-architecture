# Order Processing System – Architecture

This repository is the **authoritative source of truth**
for the architecture of the Order Processing System.

It follows an **Architecture as Code (AaC)** approach:
architecture is structured, versioned, reviewable, and evolvable.

## Contents

- Requirements
- C4 architecture model
- Architecture Decision Records (ADR)
- Architecture diagrams
- Architecture rules and constraints

## Related Repositories

- Services implementation:  
  https://github.com/tsvetanv/order-system-services
- Infrastructure as Code:  
  https://github.com/tsvetanv/order-system-infrastructure



## Getting Started (Architecture as Code)

This repository contains **executable architecture**.
You can render and explore the architecture locally using **Structurizr Lite**.

### Prerequisites

| Requirement | Why |
|-------------|-----|
| Windows 10/11 | Host environment |
| **WSL2 + Ubuntu** | Linux runtime for tooling |
| **Docker in WSL** | Runs Structurizr Lite container |
| VS Code (recommended) | Editing & DSL support |
| Structurizr DSL extension (optional) | Syntax highlighting |

Verify Docker works in WSL:

```bash
docker version
```

### Run the Architecture (WSL Terminal Only)

```bash
# Open Ubuntu in Windows Terminal
wsl

# Navigate to "order-system-architecture" repository that you have cloned from Github

cd /mnt/d/repo/order-system/order-system-architecture

# First time only
chmod +x run-structurizr.sh

# Run Structurizr Lite
./run-structurizr.sh
```
Open in browser:

```code
http://localhost:8080
```

## Development Workflow

```text
1. Update workspace.dsl
2. Save file
3. Refresh Structurizr (browser)
4. Validate changes
5. Commit to version control
```
This ensures the architecture is:
- Executable
- Reviewable
- Testable
- Auditable
- Evolvable


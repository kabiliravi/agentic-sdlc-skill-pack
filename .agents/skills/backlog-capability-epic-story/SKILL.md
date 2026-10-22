---
name: backlog-capability-epic-story
description: Build an import-ready XLSX backlog of capabilities, epics and implementable user stories tied to the roadmap and architecture.
---

# Backlog Capability Epic Story
## Procedure
1. Read signed requirements, business rules, NFRs, roadmap WBS and component catalog. Group customer/business outcomes into `CAP-####`; decompose into bounded `EPIC-####` and independently testable `STORY-####` with parent linkage.
2. Create vertical slices across frontend, API, data, integrations, infra and security. Enabling technical work uses explicit technical stories, not invisible assumptions. Ensure build, test, IaC, observability, remediation, documentation, support and release work are represented.
3. For stories include persona/goal/value or technical outcome, Given/When/Then acceptance criteria, priority, estimate (story points or ideal days identified), dependencies, affected deployable(s), security/privacy conditions, test types, Definition of Ready/Done and target iteration/release. Split oversized stories.
4. Reconcile story capacity against staffing/roadmap; flag stories whose prerequisites are scheduled later, missing dependencies and epics lacking measurable outcomes.
## Outputs
`outputs/product-backlog.xlsx` tabs `Capabilities`, `Epics`, `Stories`, `Dependencies`, `Releases`, `Components`, `Requirement_Trace`, `Definitions`, `Import_Mapping`, `Unresolved`. Also produce `outputs/product-backlog.csv` and `outputs/backlog-coverage.md`. Use stable external IDs for regeneration; spreadsheet columns include `External_ID`, `Parent_External_ID`, `Title`, `Description`, `Acceptance_Criteria`, `Priority`, `Effort`, `Iteration`, `Area_Path`, `Component_ID`, `Requirement_IDs`, `Dependencies`, `Status`. Validate parent IDs, unique IDs and no cycles.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

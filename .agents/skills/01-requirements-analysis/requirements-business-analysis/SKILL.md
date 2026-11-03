---
name: requirements-business-analysis
description: Convert business requirements, diagrams and NFRs into validated requirements, business rules and architectural inputs.
---

# Requirements Business Analysis
## Intake
Read business case/SOW, scope and assumptions; actor/use-case diagrams, activity/BPMN flows, state diagrams, ERDs and sequences; FR/NFR lists; regulations, constraints, integration catalog, SLAs and enterprise standards. Parse diagram exports only when supported; request sources if only a non-readable binary is supplied.
## Steps
1. Identify stakeholders, personas, domain glossary, in/out-of-scope items, data owners, current/future workflows and measurable outcomes.
2. Assign `REQ-0001` IDs; classify as functional, nonfunctional, constraint, compliance or transition. Each requirement needs text, rationale, priority, source reference, validation and acceptance method.
3. Derive use cases, normal/alternate/error flows, state invariants, business rules `BR-####`, data entities, external integrations, assumptions and conflicts. Do not change business logic silently.
4. Translate NFRs into measurable thresholds: availability, latency percentiles/throughput, RTO/RPO, privacy, residency, accessibility, security, retention, capacity, resilience and observability.
5. Facilitate question register and decision log; capture architectural impact and unresolved ambiguities, especially identity, tenant isolation, payment and regulated data boundaries.
6. Establish sign-off checklist for BA lead, product owner, security and solution architecture; mark proposed versus approved.
## Outputs
`outputs/requirements-register.csv` (`requirement_id,type,statement,priority,source,owner,acceptance_method,status`); `business-rules.md`; `use-cases.md`; `process-state-mapping.md`; `nfr-matrix.csv`; `integration-catalog.csv`; `data-classification.md`; `open-questions.md`; `requirements-baseline.md`. Validate every requirement has a source or explicit assumption marker.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

---
name: architecture-detailed-design
description: Create approved component-level solution/security detailed design in editable draw.io XML plus Markdown design specs.
---

# Architecture Detailed Design
## Input
Use HLD, DFDs, context/container designs, ERD, sequences, state/activity diagrams, NFR, security architecture, threat model, ADRs and component catalog. Record unapproved decisions as proposals.
## Per component design
Provide responsibilities, boundaries, interface inventory with OpenAPI/AsyncAPI/protobuf as relevant, request/response/error contracts, sequence/flow/state transitions, entity/schema/migration design, transactional behavior and idempotency, concurrency/cache strategy, retry/backoff/DLQ, dependency/version map, deployment/runtime topology and scaling.
Cover IAM/service identities, least-privilege, zero-trust/trust boundaries, authn/authz, secrets/KMS, encryption/key rotation, audit and privacy/data retention. Include performance budgets, SLO/SLI, telemetry events, tracing/logging/metrics, alert thresholds, feature flags, failure modes, DR/RTO/RPO, rollout/rollback and security controls.
## Draw.io deliverables
Generate well-formed, **editable** `.drawio` mxGraph XML (mxfile/diagram/mxGraphModel/root/cells) for context, container, component, deployment, sequence, data-flow/trust-boundaries, logical data model and state/flow where useful. Use stable element IDs, labels, lanes/grouping, valid edges/source/target, no rasterized diagram substitutes, no invented infrastructure. Check XML parse and that referenced cells exist. Include diagram catalog/legend.
## Written outputs
`outputs/design/DD-COMP-####.md`, `outputs/design/diagrams/*.drawio`, `outputs/design/adr/*.md`, `outputs/design/interface-contracts/`, `outputs/design/security-control-matrix.csv`, `outputs/design/review-register.csv`; each design links REQs, NFRs, stories, tests, owner, version, reviewer, open issues and approval status. Require architecture, security, data and operations review before implementation baseline.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

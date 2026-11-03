---
name: sdlc-master-orchestrator
description: Orchestrate artifact-driven enterprise SDLC from analysis and architecture through delivery, go-live and hypercare.
---

# Sdlc Master Orchestrator
## Trigger and scope
Use when asked to execute the complete SDLC agent chain or coordinate dependent skills. Drive a gated **plan -> backlog -> design -> repositories -> implementation and IaC -> tests -> CI/CD -> release** workflow.
## Workflow
1. Inventory supplied artifacts with source/version/owner/confidence and normalize to `outputs/input-manifest.csv`; distinguish requirements from assumptions.
2. Execute `requirements-business-analysis` to derive business cases, rules, acceptance criteria, nonfunctional constraints and missing decision questions.
3. Execute `roadmap-gantt-budget` and `backlog-capability-epic-story`; freeze baseline after sponsor review.
4. Execute `architecture-detailed-design`, `artifact-naming-standards`, `repo-topology-bootstrap`, and `artifact-publisher` in an approved order.
5. Execute `application-code-unit-tests`, `cloud-iac-generator`, `api-system-test-generator`, and `cicd-pipeline-generator`. Keep work aligned to repo and environment boundaries.
6. During delivery maintain sprint/release forecast, dependency and risk registers, architecture decision records, and traceability; escalate variance from agreed tolerances.
7. Run stage gates: G0 intake; G1 requirements baseline; G2 HLD/security approval; G3 detailed design; G4 build/test readiness; G5 release approval; G6 hypercare exit. Record owner, evidence, outcome, exceptions and timestamp.
## Release lifecycle and handover
Prepare change request, rollback and restore proof, deployment runbook, configuration baseline, SLO dashboard, smoke tests, on-call rota, security sign-off and stakeholder communications. During hypercare monitor incidents, error budget, adoption, defect backlog and transition to BAU support.
## Output
`outputs/orchestration-plan.md`, `outputs/gate-register.csv`, `outputs/traceability.csv`, `outputs/risks.csv`, `outputs/release-readiness.md`, `outputs/hypercare-exit.md`. Do not advance gated actions without evidence.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

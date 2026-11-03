---
name: jira-ado-backlog-sync
description: Map capability epic story spreadsheets to Jira or Azure DevOps and safely prepare or execute idempotent synchronization.
---

# Jira Ado Backlog Sync
<!--
Version: 1.0.0
License: GPL-3.0-only
Author: Nasim Kabiliravi <kabiliravi@gmail.com>
Website: http://kabiliravi.com
LinkedIn: https://www.linkedin.com/in/nasim-kabi-liravi/
-->
## Configuration
Read `config/project.yaml` (`work_tracking.provider` = `jira` or `azure-devops`, project, base URL/organization, hierarchy mappings, custom fields, sprint mapping). Never embed tokens in Markdown, YAML, CSV or logs; use secret environment or authorized connector.
## Jira
Resolve actual project issue types/hierarchy with API first: capability may map to initiative or custom issue type if configured, epic to Epic and story to Story; Jira Cloud may require configured parent relationships, board and custom fields. Do not assume an Initiative type exists. Prepare Jira CSV with required fields and parent references or REST payloads; use resolved field IDs and account IDs.
## Azure DevOps
Resolve project process (Agile/Scrum/CMMI/custom), enabled work item types, `System.Parent` relations, area/iteration paths and state transitions. Map Capability to Feature by default only if chosen/available; Epic to Epic; Story to User Story or Product Backlog Item depending on process. Account for ADO's standard `Epic > Feature > User Story` hierarchy: configure a valid hierarchy (e.g. `Capability -> Epic -> Feature -> Story` as a conceptual mapping with an extra work item level) or explicitly report an impossible mapping; do not create invalid `Feature > Epic` relationships.
## Sync flow
Validate input IDs; retrieve existing work items using external ID custom field/marker; dry-run create/update/skip/conflict diff; store `External_ID` -> remote ID mapping; batch/rate-limit and retry 429/5xx with backoff. Detect manual edits before overwrite. Require user approval for actual writes. Verify remote IDs, parent relationships, iterations, descriptions and links, and produce failures reconciliation. No duplicate items on repeated runs.
## Deliverables
`outputs/tracker-sync/jira-import.csv`, `ado-import.csv`, `mapping.json`, `dry-run.md`, `sync-results.csv`, `field-mapping.md`, `runbook.md`. Import files are only populated for the selected provider; document missing permissions.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

---
name: artifact-naming-standards
description: Generate environment cloud platform code repo artifact and resource naming conventions and an XLSX naming registry.
---

# Artifact Naming Standards
## Method
Ingest company conventions, cloud provider limits and enterprise resource inventory, project/business unit, region, environment, resource type, data sensitivity and uniqueness scope. Specify pattern tokens like `{org}-{product}-{component}-{env}-{region}-{resource}-{nn}`; apply provider-specific length, character-set and global uniqueness restrictions, e.g. storage buckets/accounts and DNS. Distinguish human-friendly logical names from immutable physical IDs and external object display names.
For each category establish pattern, examples, constraints, case, separator, uniqueness scope, ownership, tags/labels, exceptions and rename/migration rules. Cover capability/epic/story IDs, cloud resources, accounts/projects/subscriptions, repos, microservices, frontend/backend packages, DB schemas/tables, queues/topics, endpoints, secrets **names only**, observability metrics, pipelines, environments, branches, container images, artifacts, IaC modules and test suites.
## Outputs
`outputs/naming-conventions.xlsx`: tabs `Token_Dictionary`, `Patterns`, `Registry`, `Cloud_Constraints`, `Exceptions`, `Validation`, `Ownership`, `Examples`; also `outputs/naming-standard.md`, `outputs/naming-registry.csv`. Registry columns: `artifact_id,category,logical_name,physical_name,provider,environment,region,component_id,owner,pattern_id,validation_status`. Workbook must distinguish proposals from confirmed inventory, detect collisions and include validation checks. Do not claim cross-cloud uniqueness when unverified.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

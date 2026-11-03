---
name: cicd-pipeline-generator
description: Generate full gated CI/CD pipelines for Jenkins GitHub Actions GitLab CI Azure Pipelines or selected platform.
---

# Cicd Pipeline Generator
<!--
Version: 1.0.0
License: GPL-3.0-only
Author: Nasim Kabiliravi <kabiliravi@gmail.com>
Website: http://kabiliravi.com
LinkedIn: https://www.linkedin.com/in/nasim-kabi-liravi/
-->
## Inputs
Read `cicd.platform` from project config: `github-actions|jenkins|gitlab-ci|azure-pipelines|other`. Read repository inventory, application/IaC technologies, environments, branching/release model, required approvals and supply-chain security standard.
## Build CI stages
Checkout pinned trusted dependencies -> format/lint -> unit and component tests + coverage -> build/package -> integration/contract/API tests -> SAST/SCA/secret scans/license policy -> SBOM, provenance and artifact signing -> container/IaC scan -> publish immutable versioned artifact. Upload test and vulnerability results to authorized systems. Avoid re-building between approval and production deployment; promote digests.
## Delivery stages
Terraform/IaC validate/plan+policy+approval -> ephemeral env optional -> deploy dev/test/stage -> smoke/integration/e2e -> perf/load/soak and DAST/pentest gate with accountable sign-off -> UAT and release readiness -> production change approval -> canary/blue-green/rolling controlled deployment -> smoke/SLO gates -> automated/manual rollback path -> hypercare monitoring and incident handoff. Penetration testing may be a scheduled human-led gate; do not misrepresent it as fully automated.
Enforce OIDC/federated short-lived credentials, protected environments, minimal permissions, concurrency locks, secret redaction, artifact retention, traceability and audit logs. Prevent untrusted PR code from receiving deploy secrets. Different repos may use build and deploy reusable templates.
## Outputs
`outputs/pipelines/<repo>/` native Jenkinsfile or YAML, reusable workflow/template paths, secrets-and-variables checklist, environment matrix, `pipeline-stage-matrix.csv`, policy gates, promotion/rollback runbook and dry-run report. Validate syntax with platform linters where present; mark all nonexecuted validation as unverified.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

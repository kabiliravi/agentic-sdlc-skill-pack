---
name: cloud-iac-generator
description: Generate secure modular infrastructure-as-code and environment overlays for user-selected GCP AWS or Azure.
---

# Cloud Iac Generator
<!--
Version: 1.0.0
License: GPL-3.0-only
Author: Nasim Kabiliravi <kabiliravi@gmail.com>
Website: http://kabiliravi.com
LinkedIn: https://www.linkedin.com/in/nasim-kabi-liravi/
-->
## Required author choices
Read `config/project.yaml`: `cloud.provider` = `gcp|aws|azure`; `iac.engine` = `terraform|opentofu|pulumi|cloudformation|cdk|bicep` compatible with the chosen platform; account/subscription/project, approved regions, runtime services, security baseline, connectivity and environments. Default is Terraform if no engine is set, but label as an assumption. No real provisioning without approval.
## Steps
Extract network zones/ingress-egress, IAM/workload identities, encryption and key management, compute/containers/serverless, databases, storage, queues, WAF, DNS/certs, backup/DR, auditing, logging/metrics/tracing, alerting, cost labels and environment separation from HLD/DDD/NFR and threat model.
Use versioned shared modules plus separate live environment roots, remote encrypted state with locking, least-privilege execution identity, policy-as-code, secret manager references, provider version pinning and reusable parameter sets. For GCP consider projects/VPC/Cloud Run/GKE/Cloud SQL/Cloud Logging as applicable; AWS accounts/VPC/ECS/EKS/RDS/CloudWatch; Azure subscriptions/VNet/AKS/App Service/Azure SQL/Azure Monitor; choose only what's justified.
Run formatter/linter, validate, security check (Checkov/tfsec or compatible), unit/module tests and non-mutating plan where tools/credentials exist. Store sanitized plan summary, resource inventory and explicit regional cost assumptions. Never run `apply`, destructive operations or use production state before approval. Never assert exact cloud costs without current region/rate quote.
## Outputs
`outputs/iac/modules/`, `outputs/iac/live/<env>/`, `outputs/iac/policies/`, `outputs/iac/README.md`, `outputs/iac/resource-inventory.csv`, `outputs/iac/plan-review.md`, `outputs/iac/security-findings.md`, `outputs/iac/estimated-costs.csv`.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

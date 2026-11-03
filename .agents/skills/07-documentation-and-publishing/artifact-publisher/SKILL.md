---
name: artifact-publisher
description: Selectively publish approved architecture planning and design artifacts to Confluence GitHub GitLab Wiki or SharePoint OneDrive.
---

# Artifact Publisher
<!--
Version: 1.0.0
License: GPL-3.0-only
Author: Nasim Kabiliravi <kabiliravi@gmail.com>
Website: http://kabiliravi.com
LinkedIn: https://www.linkedin.com/in/nasim-kabi-liravi/
-->
## Selection and classification
Read user-selected artifact globs, destination(s), folder/space/project, ACL and classification from `config/project.yaml` and `outputs/publication-manifest.csv`. Default `dry_run: true`. Never upload all content by default or publish secrets, internal credentials, sensitive customer records or unapproved artifacts.
## Transform and publish
1. Compute checksums and publication diff. Validate attachment sizes, supported file formats and site permissions.
2. Confluence: use existing page IDs/space keys, create/update child pages and attachments, respecting editor format; keep source links/backlinks.
3. GitHub/GitLab Wiki: use wiki Git repository or documented API where available; convert relative Markdown links and images, ensure history and protected access.
4. SharePoint/OneDrive: use authorized Microsoft Graph/connector mechanisms with drive/site/item IDs and destination paths; preserve version history, metadata and permissions.
5. Never claim a connector is available; generate `outputs/publish-runbook.md` when API access is absent. Require explicit approval before any upload/update; protect against duplicate pages and accidental ACL broadening.
## Outputs
`outputs/publication-manifest.csv` (`artifact_path,classification,approved,destination,target_path,checksum,remote_id,remote_url,publish_status`), `outputs/publish-dry-run.md`, `outputs/publish-results.md` containing verified link/version/permissions and skipped/errors.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

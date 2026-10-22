---
name: repo-topology-bootstrap
description: Design and optionally create component repositories with centrally governed reusable IaC modules and code libraries.
---

# Repo Topology Bootstrap
## Determine repo topology
Classify building blocks as independently deployable services/frontends/jobs, shared runtime libraries, API contracts, platform IaC modules, environment/live IaC, policy-as-code and tooling. One repo per deployable by default per user request; shared code separate only with clear ownership/versioning/reuse justification. Distinguish Terraform module source repos from environment state/live-stack repos.
## Repo design
For each define repo name, owner, stack, runtime, release cadence, consumers, interface/version policy (SemVer), private visibility, branch protection, CODEOWNERS, license/IP classification, SBOM/provenance, dependency bots, security scans, CI and deploy pipeline, support/runbook and environment strategy. Prevent tight coupling/circular dependencies; avoid placing secrets/state files in Git. Common libraries: API client, auth, errors, logging, tracing, UI design system; cloud-independent abstractions when sensible; do not centralize business domain logic merely to reduce duplication.
## Creation flow
Produce topology graph and `outputs/repositories.csv`; inspect existing repos, validate unique names, dry-run commands and compare before any create. On approval use supported GitHub/GitLab/ADO Git API or CLI with scoped credentials; configure default branches, access control, protections and templates; verify remote IDs/URLs. If unavailable produce reproducible shell scripts with `--dry-run` mindset rather than claim created.
## Artifacts
`outputs/repo-topology.md`, `outputs/repositories.csv`, `outputs/repo-scaffolds/<name>/` (README, `.gitignore`, `.editorconfig`, CODEOWNERS, threat model stub, ADR link, build manifest, tests skeleton), `outputs/repo-create-plan.md`, `outputs/repo-created.csv`. Keep reusable IaC module repos, `infra-live` env stacks and application repos distinct.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

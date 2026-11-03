---
name: application-code-unit-tests
description: Generate production-grade implementation per approved deployable repo with tests from design business flows ERDs and NFRs.
---

# Application Code Unit Tests
<!--
Version: 1.0.0
License: GPL-3.0-only
Author: Nasim Kabiliravi <kabiliravi@gmail.com>
Website: http://kabiliravi.com
LinkedIn: https://www.linkedin.com/in/nasim-kabi-liravi/
-->
## Preflight
Read design baseline and acceptance criteria, language/framework versions, approved enterprise tech stack, interface and data contracts, security requirements, repo template, pipeline rules. Refuse to guess critical ambiguity: record a blocking design question; other work may be scaffolded behind it.
## Implement per repo
Produce idiomatic modular code, typed DTOs, validation, authn/authz with deny by default, data access/migrations, domain services, error handling, retry timeouts/circuit breakers where justified, config/secrets injection, transaction and idempotency controls, metrics/logging/traces and graceful shutdown. No hardcoded credentials or proprietary dependency copying. Use pinned supported dependency ranges and license policy.
## Unit and component testing
Select stack-appropriate runner (JUnit/Mockito, pytest, Jest/Vitest, Go test etc.). For every business rule and story acceptance criteria generate happy/negative/boundary/security tests; mock network/storage only at defined seams; include deterministic test data, clock/timezone, concurrency/failure tests as necessary and mutation-testing targets for critical logic. Cover contract tests and database migration tests separately. Set coverage thresholds from enterprise standard (not a fake universal 100%); report statement/branch gaps, test command/results and exceptions. Never say tests passed unless actually executed.
## Output
Write into `outputs/code/<repo>/` with `src`, `tests`, manifest/lock file, docs, OpenAPI bindings where applicable, Dockerfile with non-root runtime, health/readiness, dev setup and test report. Return `outputs/code-quality-report.md` mapping STORY -> source -> tests, dependency vulnerabilities and static analysis findings. Code generation is not a substitute for peer review.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

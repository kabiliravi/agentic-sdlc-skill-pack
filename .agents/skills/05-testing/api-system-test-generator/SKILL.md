---
name: api-system-test-generator
description: Generate end-to-end API system test suites with configurable Node.js Java Python Ruby or other approved runner.
---

# Api System Test Generator
## Configuration
`system_tests.language` = `nodejs|java|python|ruby|go|other` and framework selected by author (e.g. Playwright API, Jest+Supertest, REST Assured, pytest+httpx, RSpec). Read API specs, domain rules, state workflows, authentication design, test env and synthetic data requirements.
## Test design
Create tests from stories and Gherkin acceptance criteria, OpenAPI/AsyncAPI specs and sequences. Include create/read/update/delete and workflows, negative and boundary inputs, schema/contract assertions, status codes, content types, authn/authz by role/tenant, token expiry, pagination, idempotency, eventual consistency, timeouts/retries, concurrency/race, integration failure and data cleanup. Cover cross-service flows, queues/callbacks if needed. Non-API UI testing belongs to a separate suite.
Build reusable clients, fixtures, synthetic/fake data, secrets via CI secret store, environment config, seed/teardown, isolated test namespaces and JUnit/XML+JSON reports; avoid real PII and destructive production tests. Stub external dependencies only for isolated tests, explicitly label end-to-end cases requiring real integrations.
## Output
`outputs/system-tests/<language>/` complete runnable project, `.env.example` without secret values, `README.md`, suite inventory, requirements coverage, test data lifecycle and sample CI stage. Execute only when a safe endpoint and permission exist; record skipped/unverified otherwise.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

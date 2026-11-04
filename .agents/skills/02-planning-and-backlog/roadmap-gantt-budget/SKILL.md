---
name: roadmap-gantt-budget
description: Generate gated SDLC roadmap, milestone Gantt, staffing plan, infrastructure sizing and cost workbook from SOW/HLD/NFRs.
---

# Roadmap Gantt Budget
<!--
Version: 1.0.0
License: GPL-3.0-only
Author: Nasim Kabiliravi <kabiliravi@gmail.com>
Website: http://kabiliravi.com
LinkedIn: https://www.linkedin.com/in/nasim-kabi-liravi/
-->
## Sizing policy (defaults, not empirical guarantees)
Use T-shirt tiers based on SOW **and** complexity, integrations, risk, environments and compliance: `XS` 3-6 months; `S` 6-12 months; `M` 12-24 months; `L` 24-48 months; `XL` >48 months. Ranges are planning policy, not proof of delivery time. If specified delivery date conflicts with scope, issue alternative scenarios (scope/time/capacity) and feasibility warnings.
## Activities
1. Inventory WBS from deliverable, deployable and executable building blocks; map capabilities and components to value increments/releases. Identify platform/infra components, dependencies, critical path, lead times, procurement and licensing.
2. Plan phases with overlap where reasonable: discovery/requirements; BA; HLD+security design/reviews; DDD/ADRs; infra IaC+app code; CI/CD+observability; unit/integration/contract/e2e/API tests; load/soak/performance; SAST/SCA/DAST/penetration test; defects/triage; UAT; release rehearsals, approvals and go-live; hypercare and handover. Include acceptance gates, holidays and buffers.
3. For each task calculate duration in working days, predecessors (FS/SS with lags), earliest/latest dates, owner, estimate range, team, deliverable, milestone flag and baseline vs forecast. Detect cycles, impossible dependencies and unstaffed critical-path tasks. Gantt can be native Excel stacked bars and a Mermaid Gantt Markdown fallback.
4. Generate role-based capacity per month/sprint: BA, PO, architect, security, UX, backend, frontend, data, cloud/platform/SRE, QA automation, performance tester, AppSec, delivery manager; staff by demand not fixed tier headcount. Respect part-time allocations, utilization, holidays and availability. Explain ramp-up and ramp-down.
5. Budget labor `FTE_months * loaded_monthly_rate`, cloud `quantity * hours_per_month * regional_unit_rate`, third-party licensing, tooling, environments (dev/test/stage/prod), data ingress/egress, support, security audits, contingency and optionally taxes. **Never manufacture cloud price quotes**; enter `RATE_REQUIRED` where rates are absent. Record currency, effective date, region, units, assumptions, P50/P80 sensitivity and one-time vs recurring.
6. Scenario analysis for baseline/accelerated/constrained budget, showing staffing tradeoffs, critical path, reserve, scope cut and confidence ranges. Separate capex/opex if instructed; avoid mixing committed and estimated spend.
## Spreadsheet workbook (real XLSX, not renamed CSV)
Produce `outputs/project-plan.xlsx` with worksheets `Inputs`, `Assumptions`, `WBS`, `Dependencies`, `Timeline_Gantt`, `Milestones`, `Capacity_By_Role`, `Resource_Load`, `Infrastructure`, `Cloud_Rates`, `Budget_Detail`, `Monthly_Cashflow`, `Scenarios`, `Risks`, `Approvals`, `Traceability`. Set formulas, number formats, freeze panes, filters, validation and conditional formatting. Use `openpyxl` or supported spreadsheet tool; preserve live formulas and verify formula references. Add a data dictionary and `project-plan.md` with Mermaid Gantt.
## Quality gates
No cost total with missing essential rates represented as certain; no milestone preceding dependencies; no negative utilization; no empty owner on sign-off milestone; total cost reconciles by category/month/phase; every work package links to requirement or enabling NFR.


## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, financial rates, vendor prices, connectivity, infrastructure inventory, security classification, or test results.
2. Read architecture and business documents including requirement register, use cases, BPMN/activity, state transitions, ERDs, sequences, HLD, security design, NFRs, service boundaries, and standards as applicable. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Use stable IDs and preserve lineage: REQ -> CAP -> EPIC -> STORY -> COMPONENT -> DESIGN -> CODE/TEST -> PIPELINE -> RELEASE. Write a machine-readable mapping plus a Markdown traceability report. Flag unlinked requirements and orphan work items.
4. Write deterministic, version-controlled artifacts under `outputs/` with an input manifest, date, version, approver and source references; avoid overriding hand-curated files unless instructed. Re-run idempotently and report diff.
5. Deliver an execution summary with generated files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a connected system was updated until actual API/tool confirmation.
6. Enforce human approval before publishing, creating external projects/repos/work items, spending money, provisioning cloud resources, merging protected branches or deploying production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
7. Use platform tools/APIs only if available and authorized; otherwise generate importable files and a tested command plan. Do not fabricate live URLs, keys, cloud SKUs, issue IDs, or approval records.

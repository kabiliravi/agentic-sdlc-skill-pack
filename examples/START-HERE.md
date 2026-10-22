# Sample agent requests

**Master orchestration:** "Use the `sdlc-master-orchestrator` skill. Read `config/project.yaml` and all `inputs/`. Produce a dry-run, gap analysis and all phase-gate artifacts; do not write to cloud or trackers."

**Planning:** "Use `roadmap-gantt-budget` for a medium project (12–24 months). Build `outputs/project-plan.xlsx` with a formula-backed Gantt, resource-loaded staffing by role/month, cloud/infrastructure budget by environment, milestones and P50/P80 options. Mark all missing rates."

**Backlog:** "Use `backlog-capability-epic-story` to produce `product-backlog.xlsx`, then use `jira-ado-backlog-sync` to generate a Jira import preview and mapping. Do not create issues yet."

**Cloud:** "Use `cloud-iac-generator` for GCP + Terraform from approved component diagrams. Generate files, tests and a sanitized plan, but never apply."

**App + tests:** "Use `application-code-unit-tests` for COMP-0003 according to approved Java/Spring standards; implement all linked rules with executable unit tests and a coverage report."

**Release:** "Use `cicd-pipeline-generator` for GitHub Actions with approval gates, supply-chain checks, test reports, IaC checks and canary rollback."

**Approval:** "Review the dry-run manifest and execute only the named approved action, keeping all other external writes disabled."

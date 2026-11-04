# Agentic SDLC Skill Pack — Copilot / Codex / Claude
<!-- Version: 1.0.0 | License: GPL-3.0-only | Author: Nasim Kabiliravi <kabiliravi@gmail.com> | Website: http://kabiliravi.com | LinkedIn: https://www.linkedin.com/in/nasim-kabi-liravi/ -->

This is a **reusable, project-configurable agent skill library**, not precomputed plans, real cloud quotes, deployed systems or preconfigured live integrations. Each independently invokable skill is a Markdown `SKILL.md` with YAML frontmatter. Source and output contracts live in `config/` and `schemas/`.

## Install

- **Recommended shared canonical location:** copy the skill folders and the `config`, `schemas`, and `examples` folders into your repository. OpenAI Codex discovers `.agents/skills`; GitHub Copilot also documents `.agents/skills` as a project skill location. Verify discovery for your installed tool version.
- **GitHub Copilot preferred alternative:** copy the skill folders into `.github/skills/`.
- **Claude Code:** copy the skill folders into `.claude/skills/` (or `~/.claude/skills/` for personal use).
- The ZIP includes a **single canonical copy** of all skills under `.agents/skills/`, grouped into SDLC phase folders (see Inventory). Most agents discover skills only one level deep (`skills/<skill-name>/SKILL.md`), so when installing, copy each `<phase>/<skill-name>` folder **flat** into the target skills directory (e.g. `cp -r .agents/skills/*/* .claude/skills/`). Skill names are unique, so flattening causes no collisions. For Claude Code, copy rather than just assume `.agents/skills` is discovered.
- Run agents from project root so relative paths (`config/...`, `inputs/...`, `outputs/...`) resolve.

## Set up

1. Edit `config/project.yaml` and `config/enterprise-standards.yaml` for project, SOW, roles/rates, stack, geography, cloud, ALM platform, test and CI engine.
2. Put source artifacts in `inputs/requirements`, `inputs/business-analysis`, `inputs/architecture`, `inputs/security`, `inputs/design`, `inputs/nfr` (empty directories are not included in ZIP; create as necessary).
3. Invoke individual skill by name (examples in `examples/START-HERE.md`) or orchestrator. Agent skill discovery varies; explicitly refer to named skill if needed.
4. Verify spreadsheets are real `.xlsx` with formulas and validation, and diagrams are editable `.drawio` XML; a Markdown skill itself **instructs** a capable agent to generate these files—it cannot guarantee tools are installed.
5. Review gates and the diff report. External writes, cost-incurring actions and production changes require explicit approvals.

## Inventory (grouped by SDLC phase)

Skills live under `.agents/skills/<phase>/<skill-name>/SKILL.md`.

| Phase folder | Skill | Primary outputs |
| --- | --- | --- |
| `00-orchestration` | `sdlc-master-orchestrator` | unified gated workflow and release/hypercare evidence |
| `01-requirements-analysis` | `requirements-business-analysis` | requirements, business rules, NFR matrix |
| `02-planning-and-backlog` | `roadmap-gantt-budget` | `project-plan.xlsx`, milestone Gantt, resource loading, budget |
| `02-planning-and-backlog` | `backlog-capability-epic-story` | `product-backlog.xlsx` capability/epic/story breakdown |
| `02-planning-and-backlog` | `jira-ado-backlog-sync` | Jira/ADO import sheets, mapping, dry-run synchronization |
| `03-architecture-and-design` | `architecture-detailed-design` | `.drawio` editable diagrams and component Markdown specs |
| `03-architecture-and-design` | `artifact-naming-standards` | `naming-conventions.xlsx` with naming constraints and registry |
| `04-development` | `repo-topology-bootstrap` | GitHub/GitLab/ADO repo topology, templates and creation plan |
| `04-development` | `application-code-unit-tests` | deployable app sources + unit/component tests |
| `05-testing` | `api-system-test-generator` | stack-selectable API system tests |
| `06-deployment-and-infrastructure` | `cloud-iac-generator` | GCP/AWS/Azure modular IaC and safe plan preview |
| `06-deployment-and-infrastructure` | `cicd-pipeline-generator` | Jenkins/GitHub/GitLab/ADO CI/CD with gates |
| `07-documentation-and-publishing` | `artifact-publisher` | Confluence/Wiki/SharePoint/OneDrive selective upload manifest |

## Boundary and assumptions

The user controls access and approvals. ALM issue hierarchies, providers' resource restrictions, prices, APIs, regions and security requirements must be validated for the actual project. If tools, credentials or prices are absent, produce offline scaffolds/imports and flag the gaps. The skills intentionally do not embed credentials or assume real API integrations.

## Current primary references

- https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills
- https://developers.openai.com/api/docs/guides/tools-skills
- https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview

# Inter-skill artifact contract

## Artifact metadata

For artifacts that are part of this skill pack, include version `1.0.0`, license `GPL-3.0-only`, and author/contact metadata for Nasim Kabiliravi (`kabiliravi@gmail.com`, `http://kabiliravi.com`, `https://www.linkedin.com/in/nasim-kabi-liravi/`) at the start of the file using that format's comment syntax. Use HTML comments for Markdown/HTML/XML, `#` for shell/YAML/Python/Terraform, `//` for JavaScript/TypeScript, and `--` for SQL. Keep comments before content but after required format declarations (such as an XML declaration or interpreter shebang).

Do not break machine-readable formats by inserting comments. For CSV and JSON, store the same metadata in the associated artifact manifest; for XLSX, put it in document properties and a `Metadata` worksheet. These fields identify the skill pack and its license; they do not assign the pack's copyright or license to project-specific deliverables. Preserve any project-specific ownership and licensing instructions.

Canonical IDs: `REQ-0001`, `NFR-0001`, `BR-0001`, `CAP-0001`, `EPIC-0001`, `STORY-0001`, `COMP-0001`, `TASK-0001`, `MILE-0001`, `TEST-0001`, `ADR-0001`.

## Minimum artifacts and columns

| Path | Minimum fields |
| --- | --- |
| `outputs/input-manifest.csv` | source_id,path,document_type,version,owner,approval_status,checksum |
| `outputs/requirements-register.csv` | requirement_id,type,statement,source,priority,owner,acceptance_method,status |
| `outputs/component-catalog.csv` | component_id,name,type,repo_id,deployable,technology,cloud,owner,related_requirement_ids |
| `outputs/traceability.csv` | requirement_id,capability_id,epic_id,story_id,component_id,design_ref,test_id,release_id |
| `outputs/risks.csv` | risk_id,description,likelihood,impact,owner,mitigation,due_date,status |
| `outputs/approvals.csv` | gate_id,artifact_ref,reviewer,decision,timestamp,evidence_ref,exceptions |

A source reference should be a path+section or authenticated record ID; do not claim approval because a document says 'final'. Empty or unresolved relationships must be explicitly reported. Every skill must leave output manifests with `generated_at`, source hashes, assumptions and a dry-run/execution label.

## Workflow ownership

Requirement baseline -> sizing plan/WBS -> CAP/EPIC/STORY backlog -> tracker import -> detailed design -> repos -> code/IaC/tests -> pipelines -> go-live/hypercare. Iterate and version a baseline when change requests are approved; never silently regenerate and destroy prior work.

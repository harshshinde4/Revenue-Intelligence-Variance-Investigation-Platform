# Revenue Intelligence & Variance Investigation Platform

A Python-first enterprise decision-support product for finance teams. It turns governed revenue data and approved business documents into traceable forecast, anomaly, variance-driver, and investigation evidence—without allowing an AI workflow to change financial systems.

## Implemented capabilities

- Revenue semantic model, variance decomposition, robust anomaly screening, and rolling-origin forecast baseline evaluation.
- Citation-first hybrid document retrieval (BM25-style lexical plus token-vector similarity).
- Bounded Supervisor → Data → Forecast → Knowledge → Investigation workflow.
- Strict allow-listed read-only MCP tool contracts, RBAC, audit events, traces, and HITL approval queue.
- Retrieval/forecast regression gate, unit tests, Docker, GitHub Actions CI, and AWS infrastructure seed.

## Run locally

Python 3.10+ is required; runtime code uses only the standard library.

```powershell
cd 'D:\PROJECT\Revenue Intelligence & Variance Investigation Platform'
python -m unittest discover -s tests -v
python src\server.py
```

Open <http://127.0.0.1:8000>. The dashboard uses development identity `X-User: analyst`; production uses OIDC/JWT.

## API

All `/api/*` routes except `/api/health` require `X-User: analyst`, `reviewer`, or `admin` in this self-contained MVP.

| Route | Purpose |
| --- | --- |
| `/api/summary`, `/api/drivers`, `/api/forecast-quality` | Certified analytical views |
| `/api/investigation` | Driver, outlier, and evidence review queue |
| `/api/documents?q=pricing` | Hybrid retrieval with citations |
| `/api/agents/investigate?q=...` | Guardrailed agent investigation |
| `/api/mcp/tools` | Read-only MCP contracts |
| `/api/approvals` | POST investigation to HITL review |
| `/api/audit`, `/api/traces`, `/api/evaluations` | Controlled operations and quality views |

```powershell
Invoke-RestMethod http://127.0.0.1:8000/api/approvals -Method POST -Headers @{'X-User'='analyst'} -ContentType application/json -Body '{"question":"Explain EMEA pricing variance"}'
```

## Notebook and blueprint

[revenue_intelligence_demo.ipynb](notebooks/revenue_intelligence_demo.ipynb) is the companion Python notebook and imports the production `src/` modules. The interview-ready system design is [engineering-blueprint.md](docs/engineering-blueprint.md); project language standards are in [engineering-principles.md](docs/engineering-principles.md). Use the detailed [runbook](docs/runbook.md) for VS Code, notebook, API, HITL, container, and product-flow commands. Review [deployment.md](docs/deployment.md) before an AWS release.

## Boundary

This repository uses synthetic data only. It is decision support, not an autonomous financial actor: tools are read-only, evidence is source-labeled, and a finance reviewer must approve an investigation release.

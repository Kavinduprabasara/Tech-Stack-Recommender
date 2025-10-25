# Tech Stack Advisor

A small tech-stack recommendation project using a Prolog knowledge base and a Python wrapper/CLI.

This repository contains a Prolog knowledge base with rules to recommend frontend/backend/database stacks and a Python interface to interact with it.

## Contents

- `advisor/knowledge_base.pl` — The Prolog knowledge base (50 rules) used to derive recommendations.
- `advisor/main.py` — Python entrypoint / wrapper to interact with the knowledge base (CLI or programmatic use).
- `bin/` — Included virtual environment and helper executables (a local Python interpreter is available here).

## Quick summary

The knowledge base encodes domain rules (e.g., e-commerce, analytics, mobile, microservices) and exposes helpers such as `best_recommendation/5` and `ask_recommendation/0` for interactive use.

## Prerequisites

- Python (the project includes a virtual environment at `./bin/`). If you prefer using the bundled interpreter use `./bin/python`.
- SWI-Prolog if you plan to run the `.pl` file directly.
- Common Python packages used to integrate with Prolog (if not already present): `pyswip` or other chosen bridge.

Note: This workspace already includes a `bin/` directory with a Python environment. If you want to activate it locally (macOS / zsh):

```bash
source ./bin/activate
```

Or run the bundled interpreter directly:

# Tech Stack Recommender

A small expert-system that recommends frontend / backend / database stacks based on project requirements. The recommendation engine is implemented as a Prolog knowledge base and the UI is a Streamlit app that calls Prolog through the `pyswip` bridge.

This README documents the actual repository layout and how to run the app locally.

## Repository layout

- `knowledge_base.pl` — Prolog knowledge base with rules and predicates used to derive recommendations.
- `main.py` — Streamlit-based UI and Python glue code that asserts facts into Prolog and queries recommendations.
- `requirements.txt` — Python dependencies (e.g. `pyswip`, `streamlit==1.50.0`, `experta`).
- `tech_env/` — included virtual environment (optional) with Python and helper executables.

## What it does

1. The Streamlit UI (`main.py`) collects answers to a set of questions about your project (project type, team size, realtime needs, etc.).
2. It converts those answers into Prolog facts using `pyswip` and queries the `recommend_stack/5` predicate (or the rules in `knowledge_base.pl`) to get ranked recommendations.
3. The app shows results in the browser and provides a downloadable JSON report of the recommendations.

## Prerequisites

- Python 3.8+ (the repo includes a `tech_env` venv you can use).
- SWI-Prolog installed and available on PATH (pyswip requires a working SWI-Prolog binary).

macOS quick install (if needed):

```bash
# install SWI-Prolog via Homebrew
brew install swi-prolog
```

## Install Python dependencies

Activate the included virtualenv (recommended):

```bash
source tech_env/bin/activate
pip install -r requirements.txt
```

Or install directly using the venv's pip (no activate):

```bash
./tech_env/bin/pip install -r requirements.txt
```

Note: `requirements.txt` currently pins `streamlit==1.50.0`.

## Run the app (Streamlit)

From the repository root (after installing dependencies):

```bash
streamlit run main.py
```

If you use the bundled venv without activating:

```bash
./tech_env/bin/streamlit run main.py
```

The app will open in your browser. Answer the questions in the UI and click "Analyze My Project" to get recommendations. You can download the full JSON report from the UI.

## Troubleshooting

- If `main.py` fails to initialize Prolog, ensure SWI-Prolog is installed and the `swipl` binary is on your PATH. On macOS, `brew install swi-prolog` is the usual approach.
- Ensure `knowledge_base.pl` is in the same directory as `main.py` (it is by default in this repository). `main.py` calls `prolog.consult("knowledge_base.pl")`.
- If pyswip raises type errors when asserting facts, verify the facts you assert match how predicates are expected in the `.pl` file. The Streamlit UI filters/normalizes values before asserting.

## Development & Contributing

- To update rules, edit `knowledge_base.pl` and keep the predicate names used by `main.py` (e.g. `recommend_stack/5`).
- To change the UI, edit `main.py`. The code already includes helpful comments and small debug print statements.

## License

Add a `LICENSE` file if you want a specific license. Otherwise the repo has no explicit license.

---

If you'd like, I can also:

- Pin a version for `experta` in `requirements.txt`.
- Run the install inside the included `tech_env` and confirm that Streamlit and pyswip are available.
- Add a small example script that demonstrates a programmatic (non-UI) query to the Prolog KB.

Tell me which of those you'd like next.

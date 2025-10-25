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

```bash
./bin/python advisor/main.py
```

## Run options

1) Run via the Python wrapper/CLI

- Activate venv (optional):

```bash
source ./bin/activate
```

- Run the Python entrypoint (assuming `advisor/main.py` is the CLI):

```bash
python advisor/main.py
```

Or use the bundled interpreter without activating:

```bash
./bin/python advisor/main.py
```

2) Run the Prolog interactive helper directly (if you have SWI-Prolog installed)

```bash
swipl -s advisor/knowledge_base.pl -g "ask_recommendation." -t halt
```

This will start the question sequence defined in the knowledge base and print a recommendation.

## Files of interest

- `advisor/knowledge_base.pl` — contains 50 rules with helper predicates `best_recommendation/5`, `all_recommendations/1`, and `ask_recommendation/0`.
- `advisor/main.py` — Python script to interact with the knowledge base (the exact interface depends on how it's implemented; the `main.py` file is the place to run or inspect for programmatic usage).

## Example

A simple run (assuming the Python wrapper calls into the Prolog KB) should prompt questions or print a recommended stack with a confidence score and reason. If you run Prolog directly, `ask_recommendation/0` gathers answers from the user and prints the chosen stack.

## Contributing

- Add or refine rules inside `advisor/knowledge_base.pl`.
- If you change rule names or API, update `advisor/main.py` accordingly.

## License

This repository does not include a license file; add `LICENSE` if you want to set one.

---

If you'd like, I can:
- Inspect `advisor/main.py` and update the README with exact Python usage examples and flags.
- Add a minimal `requirements.txt` or `pyproject.toml` for external dependencies.
- Add a small example script that demonstrates querying the Prolog KB programmatically from Python.

Tell me which of those you'd like next.

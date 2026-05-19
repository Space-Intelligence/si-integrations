# To use this, install just (`brew install just`), then run e.g. `just test`
check: lint test
clean:
    find . -type d -name __pycache__ -delete
    find . -type f -name "*.pyc" -delete
    rm -rf .pytest_cache .ruff_cache .coverage coverage.xml
fix FILES=".":
    uv run ruff format {{FILES}}
    uv run ruff check {{FILES}} --fix
lint FILES=".":
    uv run ruff format {{FILES}} --check
    uv run ruff check {{FILES}}
setup:
    uv sync --all-groups --locked
test:
    uv run pytest -vv

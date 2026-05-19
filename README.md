# SI Integrations
Monorepo for Space Intelligence integrations.
## Structure
```
integrations/   <- individual integrations
  earthmover/   <- Earthmover integration
tests/          <- shared tests
justfile        <- task runner
pyproject.toml  <- project definition and tooling config
```
## Setup
```bash
just setup
```
## Development
```bash
just check    # lint + test
just fix      # auto-fix lint issues
just test     # run tests
```

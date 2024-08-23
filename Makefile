#!make

help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; \
		{printf "%-15s %s\n", $$1, $$2}' | \
		sort

bash-all: bash-fmt bash-check bash-lint ## Run all bash tests

bash-fmt: ## Format bash code
	@git ls-files | xargs grep -E '^#!/usr/bin/env bash' -l | xargs shfmt -i 2 -w

bash-check: ## Check format bash code
	@git ls-files | xargs grep -E '^#!/usr/bin/env bash' -l | xargs shfmt -i 2 -d

bash-lint: ## Check lint bash code
	@git ls-files | xargs grep -E '^#!/usr/bin/env bash' -l | xargs shellcheck -o all

doc-changelog: ## Write CHANGELOG.md
	@git cliff -o CHANGELOG.md

js-fmt: ## Format javascript code
	@git ls-files | xargs grep -E '^#!/usr/bin/env node' -l | xargs npx @biomejs/biome format

js-fmt-fix: ## Format fix javascript code
	@git ls-files | xargs grep -E '^#!/usr/bin/env node' -l | xargs npx @biomejs/biome format --write

js-lint: ## Lint javascript code
	@git ls-files | xargs grep -E '^#!/usr/bin/env node' -l | xargs npx @biomejs/biome lint

js-lint-fix: ## Fix lint javascript code
	@git ls-files | xargs grep -E '^#!/usr/bin/env node' -l | xargs npx @biomejs/biome lint --apply

.PHONY: help
.PHONY: bash-all
.PHONY: bash-check
.PHONY: bash-fmt
.PHONY: bash-lint
.PHONY: js-fmt
.PHONY: js-fmt-fix
.PHONY: js-lint
.PHONY: js-lint-fix
.PHONY: doc-changelog

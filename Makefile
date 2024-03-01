#!make

help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; \
		{printf "%-15s %s\n", $$1, $$2}' | \
		sort

changelog: ## Write CHANGELOG.md
	@git cliff -o CHANGELOG.md

bash-all: bash-fmt bash-check bash-lint ## Run all bash tests

bash-fmt: ## Format bash code
	@git ls-files | xargs grep -E '^#!/usr/bin/env bash' -l | xargs shfmt -i 2 -w

bash-check: ## Check format bash code
	@git ls-files | xargs grep -E '^#!/usr/bin/env bash' -l | xargs shfmt -i 2 -d

bash-lint: ## Check lint bash code
	@git ls-files | xargs grep -E '^#!/usr/bin/env bash' -l | xargs shellcheck -o all

.PHONY: help
.PHONY: bash-all
.PHONY: bash-check
.PHONY: bash-fmt
.PHONY: bash-lint
.PHONY: changelog

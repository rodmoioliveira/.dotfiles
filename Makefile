#!make

help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		sed -E 's/:.+## /@/g' | \
		LC_ALL=C sort -t@ -k1,1 | \
		column -s@ -t

bash-all: bash-fmt bash-check bash-lint ## Run all bash tests

bash-check: ## Check format bash code
	@git ls-files | xargs grep -E '^#!/usr/bin/env bash' -l | xargs shfmt -i 2 -d

bash-deps: ## Install bash dependencies
	@sudo apt-get install -y moreutils

bash-fmt: ## Format bash code
	@git ls-files | xargs grep -E '^#!/usr/bin/env bash' -l | xargs shfmt -i 2 -w

bash-lint: ## Check lint bash code
	@git ls-files | xargs grep -E '^#!/usr/bin/env bash' -l | xargs shellcheck -o all

doc-changelog: ## Write CHANGELOG.md
	@git cliff -o CHANGELOG.md

doc-readme: ## Write README.md
	@./.dev/doc-readme.sh

dprint-check: ## Dprint check
	@git ls-files | xargs dprint check

dprint-fmt: ## Dprint format
	@git ls-files | xargs dprint fmt

makefile-descriptions: ## Check if all Makefile rules have descriptions
	@./.dev/makefile-descriptions.sh

typos: ## Check typos
	@git ls-files | xargs typos

typos-fix: ## Fix typos
	@git ls-files | xargs typos -w

.PHONY: bash-all
.PHONY: bash-check
.PHONY: bash-deps
.PHONY: bash-fmt
.PHONY: bash-lint
.PHONY: doc-changelog
.PHONY: doc-readme
.PHONY: dprint-check
.PHONY: dprint-fmt
.PHONY: help
.PHONY: makefile-descriptions
.PHONY: typos
.PHONY: typos-fix

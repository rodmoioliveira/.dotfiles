#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

makefile-descriptions() {
  if ! diff <(cat Makefile | grep -E ':.+##' | grep -E '^\w' | sed -E 's/:.+//g' | sort) <(cat Makefile | grep '.PHONY' | sed 's/.PHONY: //g' | sort); then
    printf 1>&2 'There are values in [.PHONY: rule] without description [rule: ## description].\n'
    exit 1
  fi

  printf 1>&2 'All the values in [.PHONY: rule] have description [rule: ## description].\n'
}

main() {
  makefile-descriptions
}

main

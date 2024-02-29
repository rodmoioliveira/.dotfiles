#!/usr/bin/env bash

clean_ssh_agent() {
  if [[ -n "${SSH_AUTH_SOCK}" ]] ; then
    eval "$(ssh-agent -k)"
  fi
}

main() {
  clean_ssh_agent
}

main

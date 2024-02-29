#!/usr/bin/env bash

# https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
clean_ssh_agent() {
  if [[ -n "${SSH_AUTH_SOCK}" ]]; then
    eval "$(ssh-agent -k)"
  fi
}

main() {
  clean_ssh_agent
}

main

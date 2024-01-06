#!/usr/bin/env bash

sources_dotfiles() {
  source "${HOME}/.aliases"
  source "${HOME}/.exports"
  source "${HOME}/.fns"
}

sources_fzf() {
  # shellcheck source=/dev/null
  [[ -f "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.zsh"

  # shellcheck source=/dev/null
  [[ -f /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh
}

sources_envman() {
  # Generated for envman. Do not edit.
  # shellcheck source=/dev/null
  [[ -s "${HOME}/.config/envman/load.sh" ]] && source "${HOME}/.config/envman/load.sh"
}

zsh_compinit() {
  # Use modern completion system
  autoload -Uz compinit
  compinit
}

zsh_options() {
  # Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
  # shellcheck disable=SC2034
  HISTSIZE=1000

  # shellcheck disable=SC2034
  SAVEHIST=1000

  # shellcheck disable=SC2034
  HISTFILE=~/.zsh_history

  # Set name of the theme to load. Optionally, if you set this to "random"
  # it'll load a random theme each time that oh-my-zsh is loaded.
  # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
  # shellcheck disable=SC2034
  ZSH_THEME=random

  # Set list of themes to load
  # Setting this variable when ZSH_THEME=random
  # cause zsh load theme from this variable instead of
  # looking in ~/.oh-my-zsh/themes/
  # An empty array have no effect
  # ZSH_THEME_RANDOM_CANDIDATES=( "bira" "gnzh" "philips" )

  # Uncomment the following line to use case-sensitive completion.
  # shellcheck disable=SC2034
  CASE_SENSITIVE="true"

  # Uncomment the following line to use hyphen-insensitive completion. Case
  # sensitive completion must be off. _ and - will be interchangeable.
  # shellcheck disable=SC2034
  HYPHEN_INSENSITIVE="true"

  # Uncomment one of the following lines to change the auto-update behavior
  # zstyle ':omz:update' mode disabled  # disable automatic updates
  # zstyle ':omz:update' mode auto      # update automatically without asking
  zstyle ':omz:update' mode reminder # just remind me to update when it's time

  # Uncomment the following line to change how often to auto-update (in days).
  zstyle ':omz:update' frequency 13

  # Uncomment the following line if pasting URLs and other text is messed up.
  # shellcheck disable=SC2034
  DISABLE_MAGIC_FUNCTIONS="true"

  # Uncomment the following line to disable colors in ls.
  # shellcheck disable=SC2034
  DISABLE_LS_COLORS="false"

  # Uncomment the following line to disable auto-setting terminal title.
  # shellcheck disable=SC2034
  DISABLE_AUTO_TITLE="false"

  # Uncomment the following line to enable command auto-correction.
  # shellcheck disable=SC2034
  ENABLE_CORRECTION="false"

  # Uncomment the following line to display red dots whilst waiting for completion.
  # shellcheck disable=SC2034
  COMPLETION_WAITING_DOTS="true"

  # Uncomment the following line if you want to disable marking untracked files
  # under VCS as dirty. This makes repository status check for large repositories
  # much, much faster.
  # DISABLE_UNTRACKED_FILES_DIRTY="true"

  # Uncomment the following line if you want to change the command execution time
  # stamp shown in the history command output.
  # The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
  # shellcheck disable=SC2034
  HIST_STAMPS="yyyy-mm-dd"

  # Would you like to use another custom folder than $ZSH/custom?
  # ZSH_CUSTOM=/path/to/new-custom-folder

  # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
  # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  # Add wisely, as too many plugins slow down shell startup.
  # plugins=()
}

sources_zsh() {
  # shellcheck source=/dev/null
  source "${ZSH}/oh-my-zsh.sh"

  # shellcheck source=/dev/null
  source "${ZSH_SYNTAX_HIGHLIGHTING}/zsh-syntax-highlighting.zsh"
}

eval_z() {
  eval "$(zoxide init zsh)"
}

main() {
  sources_dotfiles
  sources_fzf
  sources_envman
  zsh_compinit
  zsh_options
  sources_zsh
  eval_z
}

main

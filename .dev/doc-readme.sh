#!/usr/bin/env bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o noclobber
set -o pipefail
shopt -s inherit_errexit

clean-tempdir() {
  rm -rf "${TMP_DIR}"
}

mktempdir() {
  if ! TMP_DIR=$(mktemp -d -t rmo-dotfiles-XXXXXXXXXX); then
    printf 1>&2 "Couldn't create %s\n" "${TMP_DIR}"
    exit 1
  fi
}

# It's better to clean up using a trap on exit:
# http://redsymbol.net/articles/bash-exit-traps/
trap clean-tempdir EXIT

index() {
  mktempdir

  paste -d "" \
    <(
      grep -E '^#{1,} [A-Z0-9]' README.md |
        sed 's/^ {1,}//g' |
        sed -E 's/(^#{1,}) (.+)/\1\[\2]/g' |
        sed 's/#/  /g' |
        sed -E 's/\[/- [/g'
    ) \
    <(
      grep -E '^#{1,} [A-Z0-9]' README.md |
        sed 's/#//g' |
        sed -E 's/^ {1,}//g' |
        # https://www.gnu.org/software/grep/manual/html_node/Character-Classes-and-Bracket-Expressions.html
        sed -E "s1[][!#$%&'()*+,./:;<=>?@\\^_\`{|}~]11g" |
        sed -E 's/"//g' |
        sed 's/[A-Z]/\L&/g' |
        sed 's/ /-/g' |
        sed -E 's@(.+)@(#\1)@g'
    ) >"${TMP_DIR}/index.md"

  index_text=$(
    sed -E ':a;N;$!ba;s/\n/\\n/g;' "${TMP_DIR}/index.md" |
      sed -E 's@\[@\\[@g' |
      sed -E 's@\]@\\]@g' |
      sed -E 's@\(@\\(@g' |
      sed -E 's@\)@\\)@g'
  )
  sed -i -E "s/INDEX/${index_text}/g" README.md
}

backlink() {
  sed -i -E '/^#{1,} [A-Z]/a\\n\[back^\](#index)' README.md
}

doc-readme() {
  cat <<EOF >|README.md
# .dotfiles

[![builds.sr.ht status](https://builds.sr.ht/~rodmoi.svg)](https://builds.sr.ht/~rodmoi?)

# index

INDEX

# Setup

Setting up a new machine is [quite easy](https://drewdevault.com/2019/12/30/dotfiles.html).
After the installation, run the following commands:

\`\`\`
cd ~
git init
git remote add origin git@github.com:rodmoioliveira/.dotfiles.git
git fetch
git checkout -f main
\`\`\`

# Utilities
$(
    # shellcheck disable=SC2016
    git ls-files |
      xargs grep -rE CMD_NAME -l |
      grep doc-readme -v |
      grep README -v |
      sort |
      xargs -I{} bash -c '
      echo {} |
        sed "s@.local/bin/@@g" |
        sed -E "s@(.+)@\n## Command: \1\n@g";
        echo \`\`\`;
        {} 2>&1 --help;
        echo \`\`\`;'
  )

# Make Recipes

\`\`\`
$(make help)
\`\`\`

# How to Release

$(cat RELEASE.md)
EOF

  sed -i -E '/^make\[[0-9]/d' README.md
  backlink
  dprint fmt README.md CHANGELOG.md
}

main() {
  doc-readme
  index
  dprint fmt README.md CHANGELOG.md
}

main

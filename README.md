# .dotfiles

# index

- [Setup](#setup)
- [Utilities](#utilities)
  - [Command: b2c](#command-b2c)
  - [Command: bfs](#command-bfs)
  - [Command: dfs](#command-dfs)
  - [Command: di](#command-di)
  - [Command: git-basic](#command-git-basic)
  - [Command: git-bump](#command-git-bump)
  - [Command: git-deploy](#command-git-deploy)
  - [Command: git-loc](#command-git-loc)
  - [Command: git-release](#command-git-release)
  - [Command: git-sync](#command-git-sync)
  - [Command: j2b](#command-j2b)
  - [Command: lpath](#command-lpath)
  - [Command: md-index](#command-md-index)
  - [Command: t2b](#command-t2b)
  - [Command: y2b](#command-y2b)
- [Make Recipes](#make-recipes)
- [How to Release](#how-to-release)

# Setup

[back^](#index)

Setting up a new machine is [quite easy](https://drewdevault.com/2019/12/30/dotfiles.html).
After the installation, run the following commands:

```
cd ~
git init
git remote add origin git@github.com:rodmoioliveira/.dotfiles.git
git fetch
git checkout -f main
```

# Utilities

[back^](#index)

## Command: b2c

[back^](#index)

```
Display tab separated output in columns.

Usage:
  cat file.tab | b2c

Options:
  -h, --help
          Print help information (see a summary with '-h')

Examples:
  bfs --file example.json | b2c
```

## Command: bfs

[back^](#index)

```
Flatten json file with breadth-first search.

Usage:
  bfs [OPTIONS]

Options:
  -f, --file <FILE>
          Path to a json file

  -h, --help
          Print help information (see a summary with '-h')

Examples:
  bfs --file example.json
```

## Command: dfs

[back^](#index)

```
Flatten json file with depth-first search.

Usage:
  dfs [OPTIONS]

Options:
  -f, --file <FILE>
          Path to a json file

  -h, --help
          Print help information (see a summary with '-h')

Examples:
  dfs --file example.json
```

## Command: di

[back^](#index)

```
Display the interval of days between two dates.

Usage:
  di <DATETIME:OLDER> <DATETIME:NEWER> [OPTIONS]

Options:
  -h, --help
          Print help information (see a summary with '-h')

Examples:
  di 2024-05-10T17:18:52Z 2024-05-17T17:18:52Z

Input:
  2024-05-10T17:18:52Z 2024-05-17T17:18:52Z

Output:
  7.00
```

## Command: git-basic

[back^](#index)

```
Shows if your git repository has some basic files.

Usage:
  git-basic [OPTIONS]

Options:
      --path <PATH>
          Use to run as if git-basic was started in <PATH> instead of the
          current working directory
          [default: $(pwd)]

  -h, --help
          Print help information (see a summary with '-h')

Examples:
  # Basic usage:
  git-basic

  # With pretty output
  git-basic | b2c

  # More fancy usage with [mlr](https://miller.readthedocs.io/):
  find "${HOME}/dir" -regex '.*git$' -type d |
    sed -E 's@/\.git$@@g' |
    xargs -n1 git-basic --path |
    grep '^KEY' -v |
    cut -f1,3 |
    awk -v step=14 -v start=1 'line<step{print start"\t"$0; line+=1} line==step{line=0;start+=1}' |
    sed '1i n\tkey\tvalue' |
    mlr --no-color --t2p reshape -s key,value |
    sed -E '1 s/(.*)/\U\1/g'
```

## Command: git-bump

[back^](#index)

```
Bump the current tag version to the next version according to the SemVer spec.

Usage:
  git-bump [OPTIONS] --level <RELEASE_LEVEL>

Arguments:
  -l, --level <RELEASE_LEVEL>
          The release level to bump tag [possible values: patch, minor, major]

Options:
  -m, --message <MESSAGE>
          Optional tag message

  -d, --dry-run
          Prints the next version without committing anything

  -h, --help
          Print help information (use '-h' for a summary)

Examples:
  git-bump -l patch -m "version %T"
  git-bump -l minor -d
  git-bump -l major
```

## Command: git-deploy

[back^](#index)

```
Generate the deploy info to publish in the Slack channel.

Usage:
  git-deploy [OPTIONS]

Options:
      --commit <HASH>
          Use a specific commit to generate the deploy info

      --path <PATH>
          Use to run as if git-deploy was started in <PATH> instead of the
          current working directory
          [default: $(pwd)]

      --since <STRING>
          Days to subtract from TODAY. Ex: --since '-5 days'

      --slack <URL>
          Slack channel URL to publish deploy info

      --ci
          Run script inside CI environment

      --quiet
          Don't print debug info

  -h, --help
          Print help information (see a summary with '-h')

Examples:
  # Use '--path' to run as if git was started in <PATH> instead
  # of the current working directory.
  git-deploy --path ./your/repo

  # Use '--commit' to use a specific commit to generate the deploy info
  git-deploy --path ./your/repo --commit 775351a41b7f4ec455f7880647a497da6bae802e
```

## Command: git-loc

[back^](#index)

```
Prints the number of lines of code added and deleted per commit.

Usage:
  git-loc [OPTIONS]

Options:
      --path <PATH>
          Use to run as if git-loc was started in <PATH> instead of the
          current working directory
          [default: $(pwd)]

  -h, --help
          Print help information (see a summary with '-h')

Examples:
  # Inside a git directory run:
  git-loc

  # Use '--path' to run as if git-loc was started in <PATH> instead
  # of the current working directory.
  git-loc --path ./your/repo

Output:
  git-loc | column -t

  commits           loc-added  loc-deleted
  0c3f5e3..3a787b9  180        0
  8d51b23..0c3f5e3  16         0
  5633537..8d51b23  62         33
  d8df183..5633537  16         0
  3ce044e..d8df183  4          4
  ef78d95..3ce044e  16         0
  abef142..ef78d95  124        23
```

## Command: git-release

[back^](#index)

```
Generate the release info to publish in the Slack channel.

Usage:
  git-release [OPTIONS]

Options:
      --tail <N_TAIL>
          Last <N_TAIL> tags from git repository (must be greater than 1)
          [default: 2]

      --head <N_HEAD>
          First <N_HEAD> tags from the last <N_TAIL> tags (must be greater than 1)
          [default: <N_TAIL>]

      --path <PATH>
          Use to run as if git-release was started in <PATH> instead of the
          current working directory
          [default: $(pwd)]

      --since <STRING>
          Days to subtract from TODAY. Ex: --since '-5 days'

      --slack <URL>
          Slack channel URL to publish release info

      --ci
          Run script inside CI environment

      --quiet
          Don't print debug info

  -h, --help
          Print help information (see a summary with '-h')

Examples:
  # Generate the latest release info for several repositories:
  find . -maxdepth 1 -type d |
    xargs -n1 git-release --path

  # Use '--path' to run as if %{CMD_NAME} was started in <PATH> instead
  # of the current working directory.
  git-release --path ./your/repo

  # Generate the latest release info only if it was made today:
  git-release --path ./your/repo --since '-1 day'

  # Generate the release diff from TAG:latest-1..TAG:latest
  cd ./your/repo; git-release

  # Generate the release diff from TAG:latest-1..TAG:latest
  git-release --path ./your/repo

  # Generate the release diff from TAG:latest-5..TAG:latest
  git-release --path ./your/repo --tail 6

  # Generate the release diff from TAG:latest-5..TAG:latest-4
  git-release --path ./your/repo --tail 6 --head 2
```

## Command: git-sync

[back^](#index)

```
Pull the changes from the remote default branch into the local default branch.

Usage:
  git-sync [OPTIONS]

Options:
      --path <PATH>
          Use to run as if git-sync was started in <PATH> instead of the
          current working directory
          [default: $(pwd)]

  -h, --help
          Print help information (see a summary with '-h')

Examples:
  git-sync --path ./your/repo

  # Synchronize with the latest changes in several repositories:
  find . -maxdepth 1 -type d |
    xargs -P10 -n1 git-sync --path
```

## Command: j2b

[back^](#index)

```
Convert json to tab separated output.

Usage:
  j2b [OPTIONS]

Options:
  -f, --file <FILE>
          Path to a json file

  -h, --help
          Print help information (see a summary with '-h')

Examples:
  j2b --file example.json
```

## Command: lpath

[back^](#index)

```
Replaces the current path with its last part within the text.

Usage:
  lpath <TEXT>

Options:
  -h, --help
          Print help information (see a summary with '-h')

Examples:
  pwd | lpath
```

## Command: md-index

[back^](#index)

```
Create an index based on a markdown file.

Rule:
  The index will include headings that start with a capital letter.

Usage:
  md-index --file <FILE> [OPTIONS]

Arguments:
  -f, --file   <FILE>
          Markdown file to generate index from

Options:
  -h, --help
          Print help information (see a summary with '-h')

Examples:
  md-index --file README.md
```

## Command: t2b

[back^](#index)

```
Convert toml to tab separated output.

Usage:
  t2b [OPTIONS]

Options:
  -f, --file <FILE>
          Path to a toml file

  -h, --help
          Print help information (see a summary with '-h')

Examples:
  t2b --file example.toml
```

## Command: y2b

[back^](#index)

```
Convert yaml to tab separated output.

Usage:
  y2b [OPTIONS]

Options:
  -f, --file <FILE>
          Path to a yaml file

  -h, --help
          Print help information (see a summary with '-h')

Examples:
  y2b --file example.yaml
```

# Make Recipes

[back^](#index)

```
bash-all               Run all bash tests
bash-check             Check format bash code
bash-deps              Install bash dependencies
bash-fmt               Format bash code
bash-lint              Check lint bash code
doc-changelog          Write CHANGELOG.md
doc-readme             Write README.md
dprint-check           Dprint check
dprint-fmt             Dprint format
help                   Display this help screen
makefile-descriptions  Check if all Makefile rules have descriptions
typos                  Check typos
typos-fix              Fix typos
```

# How to Release

[back^](#index)

To generate a new version, you need to follow these steps:

1. Run the command `git tag -a <your.new.version> -m "version <your.new.version>"`.
2. Run the command `make doc-changelog && make doc-readme`.
3. Run the command `git add -A && git commit -m "release: <your.new.version>"`.
4. Run `git push` to `main`.

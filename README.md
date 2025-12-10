# .dotfiles

[![builds.sr.ht status](https://builds.sr.ht/~rodmoi.svg)](https://builds.sr.ht/~rodmoi?)

> [!IMPORTANT]
> This repo was [moved](https://git.sr.ht/~rodmoi/.dotfiles) to [sourcehut](https://sr.ht/)!

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
  - [Command: log-elapsed-time](#command-log-elapsed-time)
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
  bfs [OPTIONS] --file <FILE>

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
  dfs [OPTIONS] --file <FILE>

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
Display the interval between two dates.

Usage:
  di <DATETIME:OLDER> <DATETIME:NEWER> [OPTIONS]

Options:
  -h, --help
          Print help information (see a summary with '-h')

Examples:
  di 2024-05-10T17:18:52Z 2024-05-17T17:18:52Z
  di 1715361532 1715966332
  di 2024-05-10T17:18:52Z 1715966332
  di 1715361532 2024-05-17T17:18:52Z

Inputs:
  2024-05-10T17:18:52Z 2024-05-17T17:18:52Z
  1715361532 1715966332
  2024-05-10T17:18:52Z 1715966332
  1715361532 2024-05-17T17:18:52Z

Outputs:
  0 years, 7 days, 0 hours, 0 minutes and 0 seconds
  0 years, 7 days, 0 hours, 0 minutes and 0 seconds
  0 years, 7 days, 0 hours, 0 minutes and 0 seconds
  0 years, 7 days, 0 hours, 0 minutes and 0 seconds
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

Options:
  -l, --level <RELEASE_LEVEL>
          The release level to bump tag [possible values: patch, minor, major]

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

  # Use '--path' to run as if git-release was started in <PATH> instead
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
  j2b [OPTIONS] --file <FILE>

Options:
  -f, --file <FILE>
          Path to a json file

  -h, --help
          Print help information (see a summary with '-h')

Examples:
  j2b --file example.json
```

## Command: log-elapsed-time

[back^](#index)

```
Display elapsed time between operations in log file.

Usage:
  log-elapsed-time [OPTIONS]

Options:
      --field-time <JSON_KEY>
          JSON field containing a date [default: .time]

      --field-key <JSON_KEY>
          JSON field containing the value to be displayed [default: .msg]

      --filter-regex <REGEX>
          A REGEX pattern to filter messages within the log file

      --log-file <PATH>
          A path to a JSONL log file

  -h, --help
          Print help information (see a summary with '-h')

Input:

  % cat fruits.log

    {"registered":"2014-06-04T09:25:49","favoriteFruit":"apple"}
    {"registered":"2015-01-11T09:02:55","favoriteFruit":"strawberry"}
    {"registered":"2015-08-27T03:56:43","favoriteFruit":"strawberry"}
    {"registered":"2016-07-18T09:19:48","favoriteFruit":"strawberry"}
    {"registered":"2018-04-03T10:24:26","favoriteFruit":"strawberry"}
    {"registered":"2018-04-16T09:00:37","favoriteFruit":"apple"}
    {"registered":"2018-06-30T10:07:27","favoriteFruit":"apple"}
    {"registered":"2021-04-30T01:48:47","favoriteFruit":"strawberry"}
    {"registered":"2021-08-05T02:50:39","favoriteFruit":"banana"}
    {"registered":"2023-12-25T07:39:39","favoriteFruit":"strawberry"}

Examples:

  % log-elapsed-time --field-time=.registered --field-key=.favoriteFruit --log-file fruits.log

    FIELD_KEY(.favoriteFruit)  FIELD_TIME(.registered)
    -----                      -----
    apple                      0 years, 0 days, 0 hours, 0 minutes and 0 seconds
    strawberry                 0 years, 220 days, 22 hours, 37 minutes and 6 seconds
    strawberry                 0 years, 227 days, 19 hours, 53 minutes and 48 seconds
    strawberry                 0 years, 326 days, 5 hours, 23 minutes and 5 seconds
    strawberry                 1 years, 259 days, 1 hours, 4 minutes and 38 seconds
    apple                      0 years, 12 days, 22 hours, 36 minutes and 11 seconds
    apple                      0 years, 75 days, 1 hours, 6 minutes and 50 seconds
    strawberry                 2 years, 304 days, 15 hours, 41 minutes and 20 seconds
    banana                     0 years, 97 days, 1 hours, 1 minutes and 52 seconds
    strawberry                 2 years, 142 days, 4 hours, 49 minutes and 0 seconds
    -----                      -----
    TOTAL                      9 years, 205 days, 22 hours, 13 minutes and 50 seconds

  % log-elapsed-time --field-time=.registered --field-key=.registered --log-file fruits.log

    FIELD_KEY(.registered)  FIELD_TIME(.registered)
    -----                   -----
    2014-06-04T09:25:49     0 years, 0 days, 0 hours, 0 minutes and 0 seconds
    2015-01-11T09:02:55     0 years, 220 days, 22 hours, 37 minutes and 6 seconds
    2015-08-27T03:56:43     0 years, 227 days, 19 hours, 53 minutes and 48 seconds
    2016-07-18T09:19:48     0 years, 326 days, 5 hours, 23 minutes and 5 seconds
    2018-04-03T10:24:26     1 years, 259 days, 1 hours, 4 minutes and 38 seconds
    2018-04-16T09:00:37     0 years, 12 days, 22 hours, 36 minutes and 11 seconds
    2018-06-30T10:07:27     0 years, 75 days, 1 hours, 6 minutes and 50 seconds
    2021-04-30T01:48:47     2 years, 304 days, 15 hours, 41 minutes and 20 seconds
    2021-08-05T02:50:39     0 years, 97 days, 1 hours, 1 minutes and 52 seconds
    2023-12-25T07:39:39     2 years, 142 days, 4 hours, 49 minutes and 0 seconds
    -----                   -----
    TOTAL                   9 years, 205 days, 22 hours, 13 minutes and 50 seconds

  % log-elapsed-time --filter-regex=apple --field-time=.registered --field-key=.favoriteFruit --log-file fruits.log

    FIELD_KEY(.favoriteFruit)  FIELD_TIME(.registered)
    -----                      -----
    apple                      0 years, 0 days, 0 hours, 0 minutes and 0 seconds
    apple                      3 years, 316 days, 23 hours, 34 minutes and 48 seconds
    apple                      0 years, 75 days, 1 hours, 6 minutes and 50 seconds
    -----                      -----
    TOTAL                      4 years, 27 days, 0 hours, 41 minutes and 38 seconds
```

## Command: lpath

[back^](#index)

```
Replaces the current path with its last part within the text.

Usage:
  lpath [OPTIONS] <TEXT>

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
  md-index [OPTIONS] --file <FILE>

Options:
  -f, --file   <FILE>
          Markdown file to generate index from

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
  t2b [OPTIONS] --file <FILE>

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
  y2b [OPTIONS] --file <FILE>

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

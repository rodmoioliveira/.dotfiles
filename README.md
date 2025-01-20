# .dotfiles

# index

- [Setup](#setup)
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

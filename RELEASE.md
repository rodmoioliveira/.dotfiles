To generate a new version, you need to follow these steps:

1. Run the command `git tag -a <your.new.version> -m "version <your.new.version>"`.
2. Run the command `make doc-changelog && make doc-readme`.
3. Run the command `git add -A && git commit -m "release: <your.new.version>"`.
4. Run `git push` to `main`.

# Developer Guide

## Commands

- `nix fmt` - Format code
- `nix flake check` - Run checks (format, lint, build, tests)
- `nix build` - Build the project
- `dune exec contests/abs/tasks/practice_1/main.exe` - Run a problem's executable inside `nix develop`
- `dune utop contests/abs/tasks/practice_1` - Start a REPL (utop) with a problem's modules loaded, inside `nix develop`

## Testing against AtCoder samples

Sample inputs/outputs are fetched with [`oj`](https://github.com/online-judge-tools/oj) (available inside `nix develop`) and stored under each task's `tests/` directory, then committed to git.

```sh
cd contests/abs/tasks/practice_1
oj d -d tests https://atcoder.jp/contests/abs/tasks/practice_1
oj t -c "dune exec ./main.exe" -d tests
```

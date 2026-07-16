# Developer Guide

## Commands

- `nix fmt` - Format code
- `nix flake check` - Run checks (format, lint, build, tests)
- `nix build` - Build the project
- `new <contest-id>` - Scaffold a new contest with `acc new` and generate Merlin config, inside `nix develop`
- `dune exec contests/abs/tasks/practice_1/main.exe` - Run a problem's executable inside `nix develop`
- `dune utop contests/abs/tasks/practice_1` - Start a REPL (utop) with a problem's modules loaded, inside `nix develop`

## Initial setup

After cloning, `_build/` doesn't exist yet, so ocamllsp reports `no config for file ... (ocamllsp:nil)` when opening any `.ml` file. Run `dune build @check` once (inside `nix develop`) to generate the Merlin config.

## Scaffolding a new contest

Use `new <contest-id>` instead of calling `acc new` directly — it also runs `dune build @check` (see [Initial setup](#initial-setup)) so the newly scaffolded tasks get Merlin config immediately. If you call `acc new` directly, run `dune build @check` afterwards yourself.

## Testing against AtCoder samples

Sample inputs/outputs are fetched with [`oj`](https://github.com/online-judge-tools/oj) (available inside `nix develop`) and stored under each task's `test/` directory, then committed to git.

```sh
cd contests/abs/tasks/practice_1
oj d https://atcoder.jp/contests/abs/tasks/practice_1
oj t -c "dune exec ./main.exe"
```

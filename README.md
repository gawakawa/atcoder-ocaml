# atcoder-ocaml

AtCoder の問題を OCaml で解くための環境。

## ディレクトリ構造

`contests/<contest>/tasks/<task>/` が AtCoder の URL
`https://atcoder.jp/contests/<contest>/tasks/<task>` と 1:1 に対応する。
各末端ディレクトリに `dune` と `main.ml` を置く。

例: [Welcome to AtCoder](https://atcoder.jp/contests/abs/tasks/practice_1) は
`contests/abs/tasks/practice_1/` に対応する。

```
contests/
└── abs/
    └── tasks/
        └── practice_1/
            ├── dune
            └── main.ml
```

## セットアップ

`direnv allow` で Nix devShell を自動ロードする。開発コマンドは
[CONTRIBUTING.md](CONTRIBUTING.md) を参照。

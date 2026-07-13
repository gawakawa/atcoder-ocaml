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

`direnv allow` で Nix devShell を自動ロードする。

## ビルド

```sh
dune build                                          # プロジェクト全体
dune build contests/abs/tasks/practice_1/main.exe   # 単一問題
```

## 実行

```sh
dune exec contests/abs/tasks/practice_1/main.exe
```

標準入力は手動で流す。例:

```sh
printf '1\n2 3\ntest\n' | dune exec contests/abs/tasks/practice_1/main.exe
```

## REPL (utop)

```sh
dune utop contests/abs/tasks/practice_1
```

当該ディレクトリ配下のモジュールをロードした状態で utop が起動する。

# atcoder-ocaml

AtCoder の問題を OCaml で解くための環境。

## コマンド

- `new <contest-id>` - コンテスト内の全問題のディレクトリ・テンプレート・サンプルを一括生成する
- `upsolve <contest-id> <task-id>` - 指定した問題の `main.ml` をテンプレートに戻し、コンテストディレクトリでシェルを起動する
- `t [task-dir]` - タスクディレクトリのサンプルケースでテストする
- `dune utop <task-dir>` - タスクのモジュールを読み込んだ REPL を起動する

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

## 新しいコンテストの追加

[`acc`](https://github.com/Tatamo/atcoder-cli) (`direnv allow` でロードされる devShell 内で利用可能) でコンテスト内の全問題のディレクトリ・テンプレート・サンプルを一括生成する。
`acc` の設定は `.envrc` が自動で紐付けるため、`nix develop` から直接起動した場合は正しく動作しない。

初回のみ、AtCoder は CAPTCHA 導入により `acc login` での自動ログインが機能しないため、
[`aclogin`](https://github.com/key-moon/aclogin) でブラウザのセッション Cookie を渡す。
ブラウザで AtCoder にログインし、開発者ツールで `REVEL_SESSION` Cookie の値を控えてから:

```sh
aclogin
```

プロンプトに Cookie の値を貼り付けると `oj`/`acc` 両方のセッションストアに保存される。

コンテストごとに:

```sh
new abc321
```

`contests/abc321/tasks/<task_id>/{main.ml,dune,test/sample-*.{in,out}}` が全問題分生成される。

## サンプルケースのテスト

タスクディレクトリで `t` を実行すると、`test/` 配下のサンプルケースで
`oj t -c "dune exec ./main.exe"` を実行する。

```sh
cd contests/abs/tasks/practice_1
t
```

引数にタスクディレクトリへのパスを渡すと、`cd` せずにどこからでも実行できる。

```sh
t contests/abs/tasks/practice_1
```

## 問題の解き直し

`upsolve` を実行すると、対象タスクの `main.ml` をテンプレートに戻し、コンテストディレクトリでシェルを起動する。

```sh
upsolve abs practice_1
```

## セットアップ

`direnv allow` で Nix devShell を自動ロードする。初回は `dune build @check` を実行しておく。

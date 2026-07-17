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

## 新しいコンテストの追加

[`acc`](https://github.com/Tatamo/atcoder-cli) (`nix develop` 内で利用可能) でコンテスト内の全問題のディレクトリ・テンプレート・サンプルを一括生成する。

初回のみのセットアップ:

```sh
ln -sfn "$PWD/acc-config" "$(acc config-dir)"
acc config oj-path "$(which oj)"
```

AtCoder は CAPTCHA 導入により `acc login` での自動ログインが機能しないため、
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

## セットアップ

`direnv allow` で Nix devShell を自動ロードする。初回は `dune build @check` を実行しておく。

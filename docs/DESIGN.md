# Design

## Directory layout

ディレクトリ構造は AtCoder の URL パス
`https://atcoder.jp/contests/<contest>/tasks/<task>` と 1:1 に対応させる。
末端の `contests/<contest>/tasks/<task>/` に `dune` と `main.ml` を置く。

## 自作ライブラリ

提出は `main.ml` 1 ファイルのみのため、`lib/` の内容はリンクせずテンプレートへ展開する。

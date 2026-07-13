# Design

## Directory layout

ディレクトリ構造は AtCoder の URL パス
`https://atcoder.jp/contests/<contest>/tasks/<task>` と 1:1 に対応させる。
末端の `contests/<contest>/tasks/<task>/` に `dune` と `main.ml` を置く。

問題ごとの実行ファイルには `public_name` を付けない。AtCoder への提出用ソースを
opam パッケージのインストール対象に含める必要はないため。

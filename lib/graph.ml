open Core

(** 有向グラフを構築する

    @param n 頂点数
    @param edges 有向辺 (u, v) のリスト
    @return 隣接リスト表現の有向グラフ *)
let build_directed_graph n edges =
  let g = Array.create ~len:n [] in
  List.iter edges ~f:(fun (u, v) -> g.(u) <- v :: g.(u));
  g
;;

(** 無向グラフを構築する

    @param n 頂点数
    @param edges 無向辺 (u, v) のリスト
    @return 隣接リスト表現の無向グラフ *)
let build_undirected_graph n edges =
  let g = Array.create ~len:n [] in
  List.iter edges ~f:(fun (u, v) ->
    g.(u) <- v :: g.(u);
    g.(v) <- u :: g.(v));
  g
;;

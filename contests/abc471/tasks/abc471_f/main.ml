open Core

module Enumerate = struct
  [@@@warning "-32"]

  open Core

  (** 順列列挙

      @param lst リスト
      @return [lst] の要素からなるすべての順列を列挙する Iter *)
  let permutations lst : _ Iter.t =
    let rec insert x xs yield =
      match xs with
      | [] -> yield [ x ]
      | y :: ys ->
        insert x ys (fun ys' -> yield (y :: ys'));
        yield (x :: xs)
    in
    let rec permute xs yield =
      match xs with
      | [] -> yield []
      | x :: xs -> permute xs (fun p -> insert x p yield)
    in
    permute lst
  ;;

  (** 組み合わせ列挙

      @param k 選ぶ個数
      @param lst リスト
      @return [lst] から [k] 個選ぶ組み合わせの Iter *)
  let combinations k lst : _ Iter.t =
    (* invariant: List.length lst = n && 0 <= k && k <= n *)
    let rec go k n lst yield =
      match lst with
      | _ when k = 0 -> yield []
      | _ when k = n -> yield lst
      | x :: xs ->
        go (k - 1) (n - 1) xs (fun c -> yield (x :: c));
        go k (n - 1) xs yield
      | [] -> assert false
    in
    let n = List.length lst in
    fun yield -> if 0 <= k && k <= n then go k n lst yield
  ;;

  (** 重複組み合わせ列挙

      @param k 選ぶ個数
      @param lst リスト
      @return [lst] から重複を許して [k] 個選ぶ組み合わせの Iter *)
  let multi_combinations k lst : _ Iter.t =
    let rec go k lst yield =
      match lst with
      | _ when k = 0 -> yield []
      | x :: xs ->
        go (k - 1) lst (fun c -> yield (x :: c));
        go k xs yield
      | [] -> ()
    in
    fun yield -> if 0 <= k then go k lst yield
  ;;

  (** 部分集合列挙

      @param lst リスト
      @return [lst] のすべての部分集合 (2^n 通り) の Iter *)
  let subsets lst : _ Iter.t =
    let rec go lst yield =
      match lst with
      | [] -> yield []
      | x :: xs ->
        go xs (fun s -> yield (x :: s));
        go xs yield
    in
    go lst
  ;;
end

module Graph = struct
  [@@@warning "-32"]

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
end

module Greedy = struct
  [@@@warning "-32"]

  open Core

  (** 貪欲法

      @param can_update 要素を食って状態を更新してよいか判定する関数
      @param update 要素を食って状態を更新する関数
      @param init 初期状態
      @param items 検討する要素のリスト
      @return 畳み込んだ最終状態 *)
  let greedy
        ~(can_update : 'state -> 'item -> bool)
        ~(update : 'state -> 'item -> 'state)
        ~(init : 'state)
        ~(items : 'item list)
    : 'state
    =
    List.fold_left
      ~f:(fun state item -> if can_update state item then update state item else state)
      ~init
      items
  ;;
end

module Math = struct
  [@@@warning "-32"]

  open Core

  let rec pow base n =
    let open Int64.O in
    let half = if n = 0L then 0L else pow base (n / 2L) in
    match n with
    | 0L -> 1L
    | n when n % 2L = 0L -> half * half
    | _ -> base * half * half
  ;;
end

module Search = struct
  [@@@warning "-32"]

  open Core

  (** 二分探索

      @param ok 述語 [p] を満たす初期値
      @param ng 述語 [p] を満たさない初期値
      @param p 述語関数
      @return [p] を満たす値のうち [ng] に最も近いもの *)
  let bisect ~ok ~ng ~p =
    let ok = ref ok in
    let ng = ref ng in
    while abs (!ok - !ng) > 1 do
      let mid = !ok + ((!ng - !ok) / 2) in
      if p mid then ok := mid else ng := mid
    done;
    !ok
  ;;
end

open! Enumerate
open! Graph
open! Greedy
open! Math
open! Search

let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.value_exn
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let[@warning "-32"] read_int_lst () =
  line () |> String.split ~on:' ' |> List.map ~f:int_of_string
;;

let () = ()

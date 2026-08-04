open Core

let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.value_exn
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let[@warning "-32"] read_int_lst () =
  line () |> String.split ~on:' ' |> List.map ~f:int_of_string
;;

let[@warning "-32"] rec pow base n =
  let open Int64.O in
  let half = if n = 0L then 0L else pow base (n / 2L) in
  match n with
  | 0L -> 1L
  | n when n % 2L = 0L -> half * half
  | _ -> base * half * half
;;

(** 二分探索

    @param ok 述語 [p] を満たす初期値
    @param ng 述語 [p] を満たさない初期値
    @param p 述語関数
    @return [p] を満たす値のうち [ng] に最も近いもの *)
let[@warning "-32"] bisect ~ok ~ng ~p =
  let ok = ref ok in
  let ng = ref ng in
  while abs (!ok - !ng) > 1 do
    let mid = !ok + ((!ng - !ok) / 2) in
    if p mid then ok := mid else ng := mid
  done;
  !ok
;;

(** 貪欲法

    @param can_update 要素を食って状態を更新してよいか判定する関数
    @param update 要素を食って状態を更新する関数
    @param init 初期状態
    @param items 検討する要素のリスト
    @return 畳み込んだ最終状態 *)
let[@warning "-32"] greedy
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

(** 順列列挙

    @param lst リスト
    @return [lst] の要素からなるすべての順列を列挙する Iter *)
let[@warning "-32"] permutations lst : _ Iter.t =
  let open Iter.Infix in
  let rec insert x xs =
    match xs with
    | [] -> Iter.pure [ x ]
    | y :: ys -> Iter.append (insert x ys >|= fun ys' -> y :: ys') (Iter.pure (x :: xs))
  in
  let rec permute xs =
    match xs with
    | [] -> Iter.pure []
    | x :: xs -> permute xs >>= insert x
  in
  permute lst
;;

(** 組み合わせ列挙

    @param k 選ぶ個数
    @param lst リスト
    @return [lst] から [k] 個選ぶ組み合わせの Iter *)
let[@warning "-32"] rec combinations k lst : _ Iter.t =
  fun yield ->
  if k = 0
  then yield []
  else (
    match lst with
    | [] -> ()
    | x :: xs ->
      let with_x = combinations (k - 1) xs in
      let without_x = combinations k xs in
      with_x (fun c -> yield (x :: c));
      without_x yield)
;;

let build_graph n edges =
  let g = Array.create ~len:n [] in
  List.iter edges ~f:(fun (u, v) ->
    g.(u) <- v :: g.(u);
    g.(v) <- u :: g.(v));
  g
;;

let solve n lst =
  let zero_indexed_lst = List.map lst ~f:(Tuple2.map ~f:Int.pred) in
  let graph = build_graph n zero_indexed_lst in
  Array.counti graph ~f:(fun u vs -> List.count vs ~f:(fun v -> u > v) = 1)
;;

let () =
  let n, _m = sscanf (line ()) " %d %d" Tuple2.create in
  let ab_lst =
    lines ()
    |> List.map ~f:(fun line ->
      String.lsplit2_exn line ~on:' ' |> Tuple2.map ~f:int_of_string)
  in
  let ans = solve n ab_lst in
  printf "%d\n" ans
;;

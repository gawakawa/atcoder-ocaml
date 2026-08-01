open Core

let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Stdlib.Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let[@warning "-32"] rec pow base n =
  let open Core.Int64.O in
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

    @param arr 配列
    @return [arr] の順列のリスト *)
let[@warning "-32"] permutations arr =
  let arr = Core.Array.copy arr in
  let n = Core.Array.length arr in
  let results = ref [] in
  let rec aux k =
    if k = n
    then results := Core.Array.copy arr :: !results
    else
      for i = k to n - 1 do
        Core.Array.swap arr k i;
        aux (k + 1);
        Core.Array.swap arr k i
      done
  in
  aux 0;
  List.rev !results
;;

(** bit 全探索(畳み込み)

    @param n 要素数
    @param init 初期状態
    @param f 状態とビットマスクを受け取り新しい状態を返す関数
    @return 畳み込んだ最終状態 *)
let[@warning "-32"] bit_search n ~init ~f =
  Core.Sequence.init (1 lsl n) ~f:Fun.id |> Core.Sequence.fold ~init ~f
;;

let solve s =
  let n = String.length s in
  String.foldi s ~init:0 ~f:(fun i acc c ->
    acc
    +
    if
      equal_char c 'x'
      && (i - 1 < 0 || equal_char s.[i - 1] 'x')
      && (i + 1 >= n || equal_char s.[i + 1] 'x')
    then 1
    else 0)
;;

let () =
  let _n = Stdlib.read_int () in
  let s = line () in
  let ans = solve s in
  printf "%d\n" ans
;;

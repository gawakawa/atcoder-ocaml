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

    @param arr 配列
    @return [arr] の順列のリスト *)
let[@warning "-32"] permutations arr =
  let arr = Array.copy arr in
  let n = Array.length arr in
  let results = ref [] in
  let rec aux k =
    if k = n
    then results := Array.copy arr :: !results
    else
      for i = k to n - 1 do
        Array.swap arr k i;
        aux (k + 1);
        Array.swap arr k i
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
  Sequence.init (1 lsl n) ~f:Fun.id |> Sequence.fold ~init ~f
;;

let solve d s =
  let n = String.length s in
  let watched = Array.create ~len:n false in
  String.iteri
    ~f:(fun i c ->
      if Char.equal c 'G'
      then
        for j = max 0 (i - d) to min (n - 1) (i + d) do
          watched.(j) <- true
        done)
    s;
  watched |> Array.filter ~f:not |> Array.length
;;

let () =
  let _m, d = sscanf (line ()) " %d %d" Tuple2.create in
  let s = line () in
  let ans = solve d s in
  printf "%d\n" ans
;;

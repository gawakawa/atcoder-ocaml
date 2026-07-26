let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

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
    (fun state item -> if can_update state item then update state item else state)
    init
    items
;;

(* ようかんを長さ s 以上のピースで k 分割できるか判定する
   切れ目の長さが s 以上になったら即切断する貪欲法で切っていく

   state: 1 回前に切った位置 (prev_cut_pose) とあと何回切れるか (rest_cut_count)
   item: 切れ目

   init: (prev_cut_pos: 0, rest_cut_count: k)
   update: rest_cut_count を 1 引いて、prev_cut_pos を更新
   can_update: item - prev_cut_pos >= s and rest_cut_count > 0 *)
let can_divide l cut_pos_lst s k =
  let init = 0, k in
  let update (_, rest_cut_count) cut_pos = cut_pos, rest_cut_count - 1 in
  let can_update (prev_cut_pos, rest_cut_count) curr_cut_pos =
    curr_cut_pos - prev_cut_pos >= s && rest_cut_count > 0
  in
  let items = cut_pos_lst in
  let final_cut_pos, rest_cut_count = greedy ~init ~update ~can_update ~items in
  rest_cut_count <= 0 && l - final_cut_pos >= s
;;

(* 1 <= k <= n <= 10⁵ だから愚直な組み合わせ全探索では間に合わない
最小値の最大値を求める問題なので、答えで二分探索できないか考える
答えは 0 <= L (<= 10⁹) に収まるのでいけそう

スコアで二分探索 (O(log l))
スコア s は可能か ↔ s 以上のピース k+1 個で長さ L のようかんを作れるか
　　　　　　　　　↔ 1 ピースが s 以上になるような最小の切れ目を選んでいき
　　　　　　　　　　k 個の切れ目で分割できたら ok できなかったら ng (O(n))

O(n \log l), 1 <= n <= 10⁵, 0 < k <= 10⁹ なので間に合う *)
let solve l k a_lst = bisect ~ok:0 ~ng:1_000_000_010 ~p:(fun s -> can_divide l a_lst s k)

let () =
  let _n, l = sscanf (line ()) " %d %d" Core.Tuple2.create in
  let k = read_int () in
  let a_lst = line () |> String.split_on_char ' ' |> List.map int_of_string in
  let ans = solve l k a_lst in
  printf "%d\n" ans
;;

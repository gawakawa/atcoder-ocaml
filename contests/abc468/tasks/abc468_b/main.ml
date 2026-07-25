let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let[@warning "-32"] rec pow base n =
  let open Core.Int64.O in
  let half = if n = 0L then 0L else pow base (n / 2L) in
  match n with
  | 0L -> 1L
  | n when n % 2L = 0L -> half * half
  | _ -> base * half * half
;;

(*
文字列 s と同じ長さの boolean 配列を作り、
G の監視範囲を true 、そうでないものを false として
最後に false であるマスを数え上げる
 *)
let solve d s =
  let m = String.length s in
  let watched_cells = Array.make m false in
  String.iteri
    (fun i c ->
       if c = 'G'
       then
         for i_watched = max 0 (i - d) to min (m - 1) (i + d) do
           watched_cells.(i_watched) <- true
         done)
    s;
  Array.fold_left
    (fun acc is_watched -> if is_watched then acc else acc + 1)
    0
    watched_cells
;;

let () =
  let _m, d = sscanf (line ()) " %d %d" Core.Tuple2.create in
  let s = line () in
  let ans = solve d s in
  printf "%d\n" ans
;;

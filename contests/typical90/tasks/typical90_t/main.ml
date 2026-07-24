let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let rec pow base n =
  let open Core.Int64.O in
  let half = if n = 0L then 0L else pow base (n / 2L) in
  match n with
  | 0L -> 1L
  | n when n % 2L = 0L -> half * half
  | _ -> base * half * half
;;

let solve a b c = a < pow c b

let () =
  let a, b, c = sscanf (line ()) " %Ld %Ld %Ld" Core.Tuple3.create in
  let ans = if solve a b c then "Yes" else "No" in
  print_endline ans
;;

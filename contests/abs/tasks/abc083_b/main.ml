let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let rec sum_digits = function
  | 0 -> 0
  | n -> (n mod 10) + sum_digits (n / 10)
;;

let solve n a b =
  Iter.sum
    (Iter.filter_map
       (fun m ->
          match sum_digits m with
          | s when a <= s && s <= b -> Some m
          | _ -> None)
       (1 -- n))
;;

let () =
  let n, a, b = sscanf (line ()) " %d %d %d" (fun n a b -> n, a, b) in
  let ans = solve n a b in
  printf "%d\n" ans
;;

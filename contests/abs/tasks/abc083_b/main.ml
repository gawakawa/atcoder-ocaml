open Scanf
open Printf
open Iter

let rec sum_digits = function 0 -> 0 | n -> (n mod 10) + sum_digits (n / 10)

let solve n a b =
  sum
    (filter_map
       (fun m ->
         match sum_digits m with s when a <= s && s <= b -> Some m | _ -> None)
       (1 -- n))

let () =
  let n, a, b = sscanf (read_line ()) " %d %d %d" (fun n a b -> (n, a, b)) in
  let ans = solve n a b in
  printf "%d\n" ans

open Scanf
open Printf

let rec count_div2 = function
  | n when n mod 2 = 0 -> 1 + count_div2 (n / 2)
  | _ -> 0

let min_lst = List.fold_left min max_int
let solve a_lst = min_lst (List.map count_div2 a_lst)

let () =
  let _n = sscanf (read_line ()) " %d" Fun.id in
  let a_lst =
    read_line () |> String.split_on_char ' ' |> List.map int_of_string
  in
  let ans = solve a_lst in
  printf "%d\n" ans

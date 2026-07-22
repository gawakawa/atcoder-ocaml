let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let rec count_div2 = function
  | n when n mod 2 = 0 -> 1 + count_div2 (n / 2)
  | _ -> 0
;;

let min_lst = List.fold_left min max_int
let solve a_lst = min_lst (List.map count_div2 a_lst)

let () =
  let _n = read_int () in
  let a_lst = line () |> String.split_on_char ' ' |> List.map int_of_string in
  let ans = solve a_lst in
  printf "%d\n" ans
;;

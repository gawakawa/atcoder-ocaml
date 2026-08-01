open Core.Array

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

let permutations arr =
  let n = length arr in
  let results = ref [] in
  let rec aux k =
    if k = n
    then results := copy arr :: !results
    else
      for i = k to n - 1 do
        swap arr k i;
        aux (k + 1);
        swap arr k i
      done
  in
  aux 0;
  List.rev !results
;;

let solve p_lst q_lst =
  let n = List.length p_lst in
  let p_arr = of_list p_lst in
  let q_arr = of_list q_lst in
  let perms = init n ~f:(fun i -> i + 1) |> permutations in
  Core.List.count perms ~f:(fun perm ->
    Stdlib.compare perm p_arr > 0 && Stdlib.compare perm q_arr < 0)
;;

let () =
  let _n = read_int () in
  let p_lst = line () |> String.split_on_char ' ' |> List.map int_of_string in
  let q_list = line () |> String.split_on_char ' ' |> List.map int_of_string in
  let ans = solve p_lst q_list in
  printf "%d\n" ans
;;

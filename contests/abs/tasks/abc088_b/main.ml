let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let partitioni p lst =
  List.mapi (fun i x -> i, x) lst
  |> List.partition (fun (i, _) -> p i)
  |> fun (yes, no) -> List.map snd yes, List.map snd no
;;

let sum = List.fold_left ( + ) 0

let solve lst =
  List.sort (fun a b -> compare b a) lst
  |> partitioni (fun i -> i mod 2 = 0)
  |> fun (evens, odds) -> sum evens - sum odds
;;

let () =
  let _n = read_int () in
  let a_lst = line () |> String.split_on_char ' ' |> List.map int_of_string in
  let ans = solve a_lst in
  printf "%d\n" ans
;;

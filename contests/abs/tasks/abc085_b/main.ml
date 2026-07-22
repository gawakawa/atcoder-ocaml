let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin
let solve lst = List.sort_uniq (fun a b -> compare b a) lst |> List.length

let () =
  let _n = read_int () in
  let d_lst = lines () |> List.map int_of_string in
  let ans = solve d_lst in
  printf "%d\n" ans
;;

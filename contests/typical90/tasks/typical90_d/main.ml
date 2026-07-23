let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let transpose mat =
  Array.init (Array.length mat.(0)) (fun col -> Array.map (fun row -> row.(col)) mat)
;;

let sum_row = Array.fold_left ( + ) 0 |> Array.map
let sum_col mat = sum_row (transpose mat)

let solve mat =
  let col_sums = sum_col mat in
  Array.mapi
    (fun _ row ->
       let row_sum = Array.fold_left ( + ) 0 row in
       Array.mapi (fun j x -> row_sum + col_sums.(j) - x) row)
    mat
;;

let () =
  let _h, _w = sscanf (line ()) " %d %d" (fun h w -> h, w) in
  let a_mat =
    lines ()
    |> List.map (fun l ->
      String.split_on_char ' ' l |> List.map int_of_string |> Array.of_list)
    |> Array.of_list
  in
  let ans = solve a_mat in
  ans
  |> Array.iter (fun arr ->
    arr |> Array.map string_of_int |> Array.to_list |> String.concat " " |> printf "%s\n")
;;

let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let solve s =
  Str.string_match (Str.regexp "^\\(dream\\|dreamer\\|erase\\|eraser\\)+$") s 0
;;

let () =
  let s = line () in
  let ans = if solve s then "YES" else "NO" in
  printf "%s\n" ans
;;

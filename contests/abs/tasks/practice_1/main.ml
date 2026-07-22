let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let () =
  let a = sscanf (line ()) " %d" Fun.id in
  let b, c = sscanf (line ()) " %d %d" (fun b c -> b, c) in
  let s = line () in
  printf "%d %s\n" (a + b + c) s
;;

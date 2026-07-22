let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let () =
  let sum_s = sscanf (line ()) " %1d%1d%1d" (fun s1 s2 s3 -> s1 + s2 + s3) in
  printf "%d\n" sum_s
;;

let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let () =
  let a, b = sscanf (line ()) " %d %d" (fun a b -> a, b) in
  let ans = if a * b mod 2 = 1 then "Odd" else "Even" in
  printf "%s\n" ans
;;

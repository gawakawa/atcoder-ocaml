let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let solve n y =
  Iter.head
    (let* count_10000 = 0 -- n in
     let* count_5000 = 0 -- (n - count_10000) in
     let count_1000 = n - count_10000 - count_5000 in
     if (count_10000 * 10000) + (count_5000 * 5000) + (count_1000 * 1000) = y
     then Iter.pure (count_10000, count_5000, count_1000)
     else Iter.empty)
;;

let () =
  let n, y = sscanf (line ()) " %d %d" (fun n y -> n, y) in
  let count_10000, count_5000, count_1000 =
    match solve n y with
    | Some x -> x
    | None -> -1, -1, -1
  in
  printf "%d %d %d\n" count_10000 count_5000 count_1000
;;

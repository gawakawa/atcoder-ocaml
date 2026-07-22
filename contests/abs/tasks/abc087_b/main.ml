let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let solve a b c x =
  Iter.length
    (let* i = 0 -- a in
     let* j = 0 -- b in
     let* k = 0 -- c in
     if (500 * i) + (100 * j) + (50 * k) = x then Iter.pure () else Iter.empty)
;;

let () =
  let a = read_int () in
  let b = read_int () in
  let c = read_int () in
  let x = read_int () in
  let ans = solve a b c x in
  printf "%d\n" ans
;;

open Core

(* MYLIB *)

let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.value_exn
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin

let[@warning "-32"] read_int_lst () =
  line () |> String.split ~on:' ' |> List.map ~f:int_of_string
;;

let () = ()

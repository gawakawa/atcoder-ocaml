let ( let* ) = Iter.( let* )
let pure = Iter.pure
let ( -- ) = Iter.( -- )
let empty = Iter.empty

let solve n y =
  Iter.head
    (let* count_10000 = 0 -- n in
     let* count_5000 = 0 -- (n - count_10000) in
     let count_1000 = n - count_10000 - count_5000 in
     if (count_10000 * 10000) + (count_5000 * 5000) + (count_1000 * 1000) = y
     then pure (count_10000, count_5000, count_1000)
     else empty)
;;

let () =
  let n, y = Scanf.scanf " %d %d" (fun n y -> n, y) in
  let count_10000, count_5000, count_1000 =
    match solve n y with
    | Some x -> x
    | None -> -1, -1, -1
  in
  Printf.printf "%d %d %d\n" count_10000 count_5000 count_1000
;;

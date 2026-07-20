open Printf

let solve lst = List.sort_uniq (fun a b -> compare b a) lst |> List.length

let () =
  let n = read_int () in
  let d_lst = List.init n (fun _ -> read_int ()) in
  let ans = solve d_lst in
  printf "%d\n" ans
;;

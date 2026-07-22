let[@warning "-32"] ( let* ) = Iter.( let* )
let[@warning "-32"] ( -- ) = Iter.( -- )
let[@warning "-32"] sscanf = Scanf.sscanf
let[@warning "-32"] printf = Printf.printf
let[@warning "-32"] line () = In_channel.input_line In_channel.stdin |> Option.get
let[@warning "-32"] lines () = In_channel.input_lines In_channel.stdin
let l1_dist (x1, y1) (x2, y2) = abs (x1 - x2) + abs (y1 - y2)
let reachable d step = d <= step && d mod 2 = step mod 2

let reachable_between (t1, x1, y1) (t2, x2, y2) =
  reachable (l1_dist (x1, y1) (x2, y2)) (abs (t1 - t2))
;;

let rec pairwise = function
  | a :: (b :: _ as rest) -> (a, b) :: pairwise rest
  | _ -> []
;;

let solve lst =
  List.for_all (fun (a, b) -> reachable_between a b) (pairwise ((0, 0, 0) :: lst))
;;

let () =
  let _n = line () |> int_of_string in
  let txy_lst =
    lines () |> List.map (fun l -> sscanf l " %d %d %d" (fun t x y -> t, x, y))
  in
  let ans = if solve txy_lst then "Yes" else "No" in
  printf "%s\n" ans
;;

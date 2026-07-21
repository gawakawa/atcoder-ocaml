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
  let n = Scanf.scanf " %d" Fun.id in
  let txy_lst = List.init n (fun _ -> Scanf.scanf " %d %d %d" (fun t x y -> t, x, y)) in
  let ans = if solve txy_lst then "Yes" else "No" in
  Printf.printf "%s\n" ans
;;

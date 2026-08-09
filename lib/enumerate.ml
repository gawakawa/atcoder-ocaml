open Core

(** 順列列挙

    @param lst リスト
    @return [lst] の要素からなるすべての順列を列挙する Iter *)
let permutations lst : _ Iter.t =
  let rec insert x xs yield =
    match xs with
    | [] -> yield [ x ]
    | y :: ys ->
      insert x ys (fun ys' -> yield (y :: ys'));
      yield (x :: xs)
  in
  let rec permute xs yield =
    match xs with
    | [] -> yield []
    | x :: xs -> permute xs (fun p -> insert x p yield)
  in
  permute lst
;;

(** 組み合わせ列挙

    @param k 選ぶ個数
    @param lst リスト
    @return [lst] から [k] 個選ぶ組み合わせの Iter *)
let combinations k lst : _ Iter.t =
  (* invariant: List.length lst = n && 0 <= k && k <= n *)
  let rec go k n lst yield =
    match lst with
    | _ when k = 0 -> yield []
    | _ when k = n -> yield lst
    | x :: xs ->
      go (k - 1) (n - 1) xs (fun c -> yield (x :: c));
      go k (n - 1) xs yield
    | [] -> assert false
  in
  let n = List.length lst in
  fun yield -> if 0 <= k && k <= n then go k n lst yield
;;

(** 重複組み合わせ列挙

    @param k 選ぶ個数
    @param lst リスト
    @return [lst] から重複を許して [k] 個選ぶ組み合わせの Iter *)
let multi_combinations k lst : _ Iter.t =
  let rec go k lst yield =
    match lst with
    | _ when k = 0 -> yield []
    | x :: xs ->
      go (k - 1) lst (fun c -> yield (x :: c));
      go k xs yield
    | [] -> ()
  in
  fun yield -> if 0 <= k then go k lst yield
;;

(** 部分集合列挙

    @param lst リスト
    @return [lst] のすべての部分集合 (2^n 通り) の Iter *)
let subsets lst : _ Iter.t =
  let rec go lst yield =
    match lst with
    | [] -> yield []
    | x :: xs ->
      go xs (fun s -> yield (x :: s));
      go xs yield
  in
  go lst
;;

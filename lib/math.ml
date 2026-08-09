open Core

let rec pow base n =
  let open Int64.O in
  let half = if n = 0L then 0L else pow base (n / 2L) in
  match n with
  | 0L -> 1L
  | n when n % 2L = 0L -> half * half
  | _ -> base * half * half
;;

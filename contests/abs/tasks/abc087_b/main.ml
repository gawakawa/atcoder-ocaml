open Printf
open Scanf
open Iter

let guard cond = if cond then return () else empty

let solve a b c x =
  length
    (let* i = 0 -- a in
     let* j = 0 -- b in
     let* k = 0 -- c in
     guard ((500 * i) + (100 * j) + (50 * k) = x))

let () =
  let a, b, c, x = scanf " %d %d %d %d" (fun a b c x -> (a, b, c, x)) in
  let ans = solve a b c x in
  printf "%d\n" ans

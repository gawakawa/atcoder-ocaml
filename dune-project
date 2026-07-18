(lang dune 3.0)
(name atcoder)
(generate_opam_files true)

(package
 (name atcoder)
 (allow_empty)
 (synopsis "AtCoder OCaml environment")
 (depends
  (ocaml
   (>= 5.3))
  dune
  (batteries
   (= 3.9.0))
  (containers
   (= 3.16))
  (core
   (= v0.17.1))
  (iter
   (= 1.9))
  (num
   (= 1.6))
  (zarith
   (= 1.14))))

(lang dune 3.0)
(name atcoder)
(generate_opam_files true)

(package
 (name atcoder)
 (allow_empty)
 (synopsis "AtCoder OCaml environment")
 (depends
  (ocaml
   (>= 5.2))
  dune))

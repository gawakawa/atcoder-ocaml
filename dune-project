(lang dune 3.0)
(name atcoder)
(generate_opam_files true)

(package
 (name atcoder)
 (synopsis "AtCoder OCaml environment")
 (depends
  (ocaml
   (>= 4.14))
  dune
  (alcotest :with-test)
  (qcheck :with-test)
  (qcheck-alcotest :with-test)))

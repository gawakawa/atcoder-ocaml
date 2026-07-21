let solve s =
  Str.string_match (Str.regexp "^\\(dream\\|dreamer\\|erase\\|eraser\\)+$") s 0
;;

let () =
  let s = Scanf.scanf " %s" Fun.id in
  let ans = if solve s then "YES" else "NO" in
  Printf.printf "%s\n" ans
;;

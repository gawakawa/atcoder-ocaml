let () =
  let a, b = Scanf.sscanf (read_line ()) " %d %d" (fun a b -> (a, b)) in
  let ans = if a * b mod 2 == 1 then "Odd" else "Even" in
  Printf.printf "%s\n" ans

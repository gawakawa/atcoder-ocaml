let () =
  let sum_s =
    Scanf.sscanf (read_line ()) " %1d%1d%1d" (fun s1 s2 s3 -> s1 + s2 + s3)
  in
  Printf.printf "%d\n" sum_s

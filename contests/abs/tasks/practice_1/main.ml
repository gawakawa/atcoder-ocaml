let a = Scanf.sscanf (read_line ()) " %d" Fun.id
let sum_bc = Scanf.sscanf (read_line ()) " %d %d" (fun b c -> b + c)
let s = Scanf.sscanf (read_line ()) " %s" Fun.id
let () = Printf.printf "%d %s\n" (a + sum_bc) s

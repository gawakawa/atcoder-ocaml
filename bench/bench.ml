open Core
open Core_bench

let tests =
  [ Bench.Test.create ~name:"Search.bisect" (fun () ->
      Mylib.Search.bisect ~ok:0 ~ng:1_000_000_000_000_000_000 ~p:(fun x ->
        x < 500_000_000_000_000_000))
  ; Bench.Test.create ~name:"Math.pow" (fun () ->
      Mylib.Math.pow 3L 1_000_000_000_000_000_000L)
  ; Bench.Test.create_indexed
      ~name:"Greedy.greedy"
      ~args:[ 1_000; 100_000; 200_000 ]
      (fun n ->
         let items = List.init n ~f:Fn.id in
         Staged.stage (fun () ->
           Mylib.Greedy.greedy
             ~can_update:(fun _ _ -> true)
             ~update:(fun state item -> state + item)
             ~init:0
             ~items))
  ; Bench.Test.create_indexed
      ~name:"Graph.build_directed_graph"
      ~args:[ 1_000; 100_000; 200_000 ]
      (fun n ->
         let edges = List.init n ~f:(fun i -> i, (i + 1) mod n) in
         Staged.stage (fun () -> Mylib.Graph.build_directed_graph n edges))
  ; Bench.Test.create_indexed
      ~name:"Graph.build_undirected_graph"
      ~args:[ 1_000; 100_000; 200_000 ]
      (fun n ->
         let edges = List.init n ~f:(fun i -> i, (i + 1) mod n) in
         Staged.stage (fun () -> Mylib.Graph.build_undirected_graph n edges))
  ; Bench.Test.create_indexed ~name:"Enumerate.permutations" ~args:[ 6; 7; 8 ] (fun n ->
      let lst = List.init n ~f:Fn.id in
      Staged.stage (fun () -> Iter.length (Mylib.Enumerate.permutations lst)))
  ; Bench.Test.create_indexed
      ~name:"Enumerate.combinations"
      ~args:[ 10; 15; 20 ]
      (fun n ->
         let lst = List.init n ~f:Fn.id in
         Staged.stage (fun () -> Iter.length (Mylib.Enumerate.combinations (n / 2) lst)))
  ; Bench.Test.create_indexed
      ~name:"Enumerate.multi_combinations"
      ~args:[ 5; 10; 15 ]
      (fun n ->
         let lst = List.init n ~f:Fn.id in
         Staged.stage (fun () -> Iter.length (Mylib.Enumerate.multi_combinations 5 lst)))
  ; Bench.Test.create_indexed ~name:"Enumerate.subsets" ~args:[ 10; 15; 20 ] (fun n ->
      let lst = List.init n ~f:Fn.id in
      Staged.stage (fun () -> Iter.length (Mylib.Enumerate.subsets lst)))
  ]
;;

let () = Command_unix.run (Bench.make_command tests)

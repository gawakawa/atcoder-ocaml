open Core

(** 貪欲法

    @param can_update 要素を食って状態を更新してよいか判定する関数
    @param update 要素を食って状態を更新する関数
    @param init 初期状態
    @param items 検討する要素のリスト
    @return 畳み込んだ最終状態 *)
let greedy
      ~(can_update : 'state -> 'item -> bool)
      ~(update : 'state -> 'item -> 'state)
      ~(init : 'state)
      ~(items : 'item list)
  : 'state
  =
  List.fold_left
    ~f:(fun state item -> if can_update state item then update state item else state)
    ~init
    items
;;

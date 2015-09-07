(* This module provide a comonadic List's zipper *)

exception Unmovable of string

type 'a t = 'a LazyList.t
type 'a zipper =
  | Zipper of 'a t * 'a * 'a t

let right (Zipper (a, b, c)) =
  let open LazyList in
  match get c with
  | Some (x, xs) -> Zipper (cons b a, x, xs)
  | _ -> raise (Unmovable "right")

let left (Zipper (a, b, c)) =
  let open LazyList in
  match get a with
  | Some (x, xs) -> Zipper (xs, x, cons b c)
  | _ -> raise (Unmovable "left")

let read (Zipper (_, cursor, _)) = cursor
let write x (Zipper (l, _, r)) = Zipper (l, x, r) 

let base (Zipper (l, x, r)) =
  let open LazyList in 
  let rcons = cons x r in
  rev_append l rcons

let take n (Zipper (l, r, x)) =
  let open LazyList in
  rev (take n l)
  <++> (return r)
  <++> (take n l)

let abstract_move f g r =
  let open LazyList in
  let left_member  = tl (iterate f r)
  and right_member = tl (iterate g r)
  in Zipper (left_member, r, right_member)


let fmap f (Zipper (a, b, c)) =
  LazyList.(Zipper (map f a, f b, map f c))

let cojoin x   = abstract_move left right x
let coreturn   = read
let cobind x f = fmap f (cojoin x)
let ( =>> ) = cobind

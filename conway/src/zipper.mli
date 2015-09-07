(* This module provide a comonadic List's zipper *)

exception Unmovable of string 

type 'a t = 'a LazyList.t
type 'a zipper =
  | Zipper of 'a t * 'a * 'a t
val take   : int -> 'a zipper -> 'a t
val right  : 'a zipper -> 'a zipper
val left   : 'a zipper -> 'a zipper 
val read   : 'a zipper -> 'a
val write  : 'a -> 'a zipper -> 'a zipper
val base   : 'a zipper -> 'a t

val abstract_move : ('a -> 'a) -> ('a -> 'a) -> 'a-> 'a zipper

(* Functor API *)
val fmap : ('a -> 'b) -> 'a zipper -> 'b zipper

(* Comonadic API *)
val ( =>> )  : 'a zipper -> ('a zipper -> 'b) -> 'b zipper
val cobind   : 'a zipper -> ('a zipper -> 'b) -> 'b zipper
val coreturn : 'a zipper -> 'a
val cojoin   : 'a zipper -> ('a zipper) zipper

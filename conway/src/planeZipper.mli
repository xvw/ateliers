(* A 2D comonadic zipper *)
type 'a planeZipper =
  | Plane of ('a Zipper.zipper) Zipper.zipper 

val up    : 'a planeZipper -> 'a planeZipper
val down  : 'a planeZipper -> 'a planeZipper
val left  : 'a planeZipper -> 'a planeZipper
val right : 'a planeZipper -> 'a planeZipper

val read  : 'a planeZipper -> 'a
val write : 'a -> 'a planeZipper -> 'a planeZipper

val horz  : 'a planeZipper -> ('a planeZipper) Zipper.zipper
val vert  : 'a planeZipper -> ('a planeZipper) Zipper.zipper

(* Functor API *)
val fmap : ('a -> 'b) -> 'a planeZipper -> 'b planeZipper

(* Comonadic API *)
val ( =>> )  : 'a planeZipper -> ('a planeZipper -> 'b) -> 'b planeZipper
val cobind   : 'a planeZipper -> ('a planeZipper -> 'b) -> 'b planeZipper
val coreturn : 'a planeZipper -> 'a
val cojoin   : 'a planeZipper -> ('a planeZipper) planeZipper

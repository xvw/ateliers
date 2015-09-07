(* A 2D comonadic zipper *)
type 'a planeZipper =
  | Plane of ('a Zipper.zipper) Zipper.zipper 

let up (Plane zipper) =
  Plane (Zipper.left zipper)

let down (Plane zipper) =
  Plane (Zipper.right zipper)

let left (Plane zipper) =
  Zipper.(Plane (fmap left zipper)) 

let right (Plane zipper) =
  Zipper.(Plane (fmap right zipper))                          

let read (Plane zipper) =
  Zipper.read (Zipper.read zipper)

let write x (Plane zipper) =
  let first  = Zipper.read zipper in
  let second = Zipper.write x first in
  Plane (Zipper.write second zipper) 

let horz x = Zipper.abstract_move left right x
let vert x = Zipper.abstract_move up down x

let fmap f (Plane zipper) =
  Zipper.(Plane (fmap (fmap f) zipper))

let coreturn = read
let cojoin z = Plane (Zipper.fmap horz (vert z))  
let cobind x f = fmap f (cojoin x)
let ( =>> ) = cobind

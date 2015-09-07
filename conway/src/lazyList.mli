(* Provide Lazy List with monadic interface*)

exception InvalidIndex
exception EmptyList

type 'a t = ('a node) Lazy.t
and 'a node = 
  | Empty
  | Cons of 'a * 'a t

val empty : 'a t
val cons : 'a -> 'a t -> 'a t
val from_list : 'a list -> 'a t
val next : 'a t -> 'a node
val length : 'a t -> int 

val hd : 'a t -> 'a
val tl : 'a t -> 'a t
val nth : int -> 'a t -> 'a

val get : 'a t -> ('a * 'a t) option
val peek : 'a t -> 'a option
val rev : 'a t -> 'a t

val from : (unit -> 'a) -> 'a t
val seq : 'a -> ('a -> 'a) -> ('a -> bool) -> 'a t
val naturals : int -> int t
val iterate : ('a -> 'a) -> 'a -> 'a t
val take : int -> 'a t -> 'a t
val repeat : 'a -> 'a t

val map : ('a -> 'b) -> 'a t -> 'b t
val iter : ('a -> unit) -> 'a t -> unit
val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b t -> 'a
val fold_right : ('a -> 'b -> 'b) -> 'b -> 'a t -> 'b 
val filter : ('a -> bool) -> 'a t -> 'a t

val append : 'a t -> 'a t -> 'a t
val rev_append : 'a t -> 'a t -> 'a t
val ( <++> ) : 'a t -> 'a t -> 'a t

val return : 'a -> 'a t
val bind : 'a t -> ('a -> 'b t) -> 'b t
val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t
val liftM2  : ('a -> 'b -> 'c) -> 'a t -> 'b t -> 'c t 

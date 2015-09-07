(* Provide Lazy List with monadic interface*)

exception InvalidIndex
exception EmptyList

type 'a node =
  | Empty
  | Cons of 'a * 'a t
and 'a t = ('a node) Lazy.t

let empty = Lazy.from_val Empty
let cons hd tl = Lazy.from_val (Cons (hd, tl) )
let next = Lazy.force

let from_list li =
  let rec aux = function
    | [] -> empty
    | x :: xs -> lazy (Cons (x, aux xs))
  in aux li

let hd l = match next l with 
  | Cons (x, _) -> x 
  | Empty -> raise EmptyList
               
let tl l = match next l with 
  | Cons (_, x) -> x 
  | Empty -> raise EmptyList


let nth n l = 
  let rec aux l i = 
    match ((next l), i) with 
    | (Cons (x, _), 0) -> x
    | (Cons (_, x), _) -> aux x (i -1)
    | (Empty, _) -> raise InvalidIndex
  in if n < 0 then raise InvalidIndex else aux l n
      
let get l =
  match next l with
  | Empty -> None
  | Cons (a, b) -> Some (a, b)
     
let peek l =
  match next l with
  | Empty -> None
  | Cons (a, _) -> Some a

let from f =
  let iter f =
    let rec aux () = lazy begin
      match f () with
      | None -> Empty
      | Some x -> Cons (x, aux ())
    end
    in aux ()
  in
  let from () =
    try Some (f ())
    with EmptyList -> None
  in iter from

let repeat x = from (fun () -> x)

let seq i f g =
  let rec aux i =
    if g i
    then Cons (i, lazy (aux (f i)))
    else Empty
  in lazy (aux i)

let naturals start =
  seq start succ  (fun _ -> true)


let rec iterate f x =
  seq x f (fun _ -> true)


let iter f l =
  let rec aux l =
    match next l with
    | Cons (x, xs) -> (f x; aux xs)
    | Empty -> ()
  in aux l

let map f l = 
  let rec aux r = match next r with 
    | Cons (x, (xs : 'a t)) -> Cons (f x, lazy(aux xs))
    | Empty -> Empty
  in lazy (aux l)


let fold_left f i l = 
  let rec aux acc r =  
    match next r with 
    | Cons (x, xs) -> aux (f acc x) xs
    | Empty -> acc
  in aux i l

let length l = fold_left (fun n _ -> n + 1) 0 l


let rev l =
  fold_left (fun acc x -> cons x acc) empty l

let rev_list l = List.fold_left (fun acc x -> cons x acc) empty l
let take n l =
  let rec aux acc l n =
    if n = 0 then rev_list acc
    else match next l with
      | Empty -> raise InvalidIndex
      | Cons (x, xs) -> aux (x :: acc) xs (pred n)
  in aux [] l n

let fold_right f i l =
  let rec aux l =
    match next l with
    | Empty -> i 
    | Cons (x, xs) -> f x (aux xs) in
  aux l

let append (la: 'a t) (lb : 'a t) =
  let rec aux l =
    match next l with
    | Cons (x, (xs: 'a t)) -> Cons (x, lazy (aux xs))
    | _ -> Lazy.force lb
  in lazy (aux la)
let ( <++> ) = append

let rev_append (la : 'a t) (lb : 'a t) =
  let rec aux l acc =
    match next l with
    | Cons (x, xs) -> aux xs (Lazy.from_val (Cons (x, acc)))
    | Empty -> acc
  in aux la lb

let filter f l =
  let rec skip l =
    match next l with
    | Cons (x, xs) when not (f x) -> skip xs
    | xs -> xs
  in
  let rec aux l = lazy begin
    match skip l with
    | Cons (x, xs) -> Cons (x, aux xs)
    | Empty -> Empty
  end
  in aux l

let return x = cons x empty
let bind x f =
  fold_right (fun x acc -> append (f x) acc) empty x
let ( >>= )  = bind
let liftM2 f a b  =
  a
  >>= fun x -> b
  >>= fun y -> return (f x y)  

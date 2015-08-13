(* Exécute un calcul en notation polonaise *)


(* Réalisé par xavier van de Woestyne <xaviervdw@gmail.com> *)
(* Tout ce code à une vocation didactique et est logiquement *)
(* laissé au domaine publique ! *)

(* Exception indiquant qu'une expression est mal construite *)
exception Invalid_expression

(* Type pour représenter un arbre calculable *)
type tree =
  | Leaf of int
  | Node of ( (int -> int -> int) * tree * tree)
  | Empty

(* Convertit une chaine en arbre *)
(* A Finir *)
let tree_of_string str =
  let rec aux = function
    | [] -> (Empty, []) 
    | (Parser.Op x) :: xs ->
      let e1, rest = aux xs in
      let e2, tail = aux rest in 
      (Node (x, e1, e2), tail)
    | (Parser.Int x) :: xs -> (Leaf x, xs) 
  in
  (aux (Parser.parse str))
  |> fst

let calc str =
  let tree = tree_of_string str in
  let rec aux = function
    | Leaf x -> x
    | Node (op, e1, e2) -> op (aux e1) (aux e2)
    | Empty -> failwith "L'expression est invalide"
  in
  try
    aux tree
  with
  | Parser.Ambiguous_expression (c, i) ->
    failwith (Printf.sprintf "Caractère ambigu %c:%d" c i)
  | Parser.Malformed_expression (c, i) ->
    failwith (Printf.sprintf "Caractère invalide %c:%d" c i)
  | Invalid_expression ->
    failwith ("L'expression est invalide")

  
(* Routine principale *)
let () =
  if (Array.length Sys.argv) < 2
  then print_endline "usage : ./np \"<expression>\""
  else
    Printf.printf "Reponse: %d\n" (calc Sys.argv.(1))
  
  
    

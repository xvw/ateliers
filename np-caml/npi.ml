(* Exécute un calcul en notation polonaise inverse *)


(* Réalisé par xavier van de Woestyne <xaviervdw@gmail.com> *)
(* Tout ce code à une vocation didactique et est logiquement *)
(* laissé au domaine publique ! *)


exception Invalid_expression

(*
   Tente de calculer par accumulation 
   le résultat d'une liste de keyword
*)
let folding_function acc = function
  | Parser.Int i -> i :: acc
  | Parser.Op op ->
    begin
      match acc with
      | x::y::xs -> (op y x) :: xs
      | _ -> raise Invalid_expression
    end

(*
   Transforme la chaine donnée en une liste 
   de Parser.kwd et calcul son résultat (accumulé 
   dans la tête)
*)
let calc str =
  try
    List.fold_left
      folding_function
      []
      (Parser.parse str)
    |> List.hd
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
  then print_endline "usage : ./npi \"<expression>\""
  else
    Printf.printf "Reponse: %d\n" (calc Sys.argv.(1))
  
  
    

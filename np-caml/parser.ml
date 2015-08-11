(* Décrit le parseur générique d'une expression mathématique *)
(* simple pour calculer une notation polonaise ou une notation  *)
(* polonaise inverse *)


(* Réalisé par xavier van de Woestyne <xaviervdw@gmail.com> *)
(* Tout ce code à une vocation didactique et est logiquement *)
(* laissé au domaine publique ! *)

(* Exceptions usuelles *)
exception Malformed_expression of (char * int)
exception Ambiguous_expression of (char * int)

(* Une expression est composée d'entiers ou d'opérateurs*)
type kwd =
  | Int of int
  | Op  of (int -> int -> int)

(* Vérifie si un caractère est un chiffre ou pas *)
let is_digit x =
  let i = int_of_char x in  
  i >= (int_of_char '0') && i <= (int_of_char '9')

(* Multiplie par un caractère '+' = id x, '-' = -x*)
let mult_with v = function
  | '-' -> ( * ) v (-1)
  | _ -> v 

(* Prend une chaine de caractères et la transforme en 
   liste de Keyword (kwd
*)
let parse str =
  let len = String.length str in

  (* Parse *)
  let rec std_parse acc i =
    if len <= i then List.rev acc
    else match str.[i] with
      | ' ' | '\t' | '\n' -> std_parse acc (succ i)
      | ('-' | '+') as op ->
        let i' = succ i in
        if i' < len && (is_digit str.[i'])
        then
          if i > 0 && (is_digit(str.[pred i]))
          then raise (Ambiguous_expression (str.[i], i))
          else
            let (n, new_acc)  = parse_num acc i' op in
            std_parse new_acc n
        else std_parse (parse_op acc op) i'
      | ('*' | '/') as op -> std_parse (parse_op acc op) (succ i) 
      | ('0' .. '9') ->
        let (n, new_acc)  = parse_num acc i '+' in
        std_parse new_acc n
      | fail -> raise (Malformed_expression (fail, i))
                  
  (* Parse les opértateurs*)
  and parse_op acc r =
    let parse = function
      | '+' -> ( + )
      | '-' -> ( - )
      | '*' -> ( * )
      | '/' -> ( / )
      (* On ne rentre jamais dans ce cas !
         Peut être utiliser un GADT...
      *)
      | _   -> ( + ) 
    in (Op (parse r)) :: acc

  (* Parse les nombres *)
  and parse_num real_acc i op =
    let rec parse acc i =
      if len = i
      then (i, (Int (mult_with acc op)) :: real_acc)
      else
        match str.[i] with
        | x when is_digit(x) ->
          parse
            ((acc*10) + (int_of_char x) - (int_of_char '0'))
            (succ i)
        | _ -> (i, (Int (mult_with acc op)) :: real_acc)
    in parse 0 i
       
  in std_parse [] 0

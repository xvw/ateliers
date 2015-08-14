(* Micro serveur rédigé dans le cadre de atelier-prog.github.io *)
(* Tout le code ici présent est laissé au dommaine publique ! *)                                                   
(* Xavier Van de Woestyne *)

(* Requête simultanées maximums *)
let max_pending_request = 16

(* Définition du port d'écoute. Si aucun n'argument *)
(* n'est donné, le serveur écoutera le port 7777 *)
let port =
  if (Array.length Sys.argv) > 1
  then int_of_string Sys.argv.(1)
  else 7777

(* Adresse du server *)
let addr =
  Unix.inet_addr_of_string "127.0.0.1"

(* Construit une chaine de caractère pour le header HTTP *)
let http_header
    ?(http_code = "200/OK")
    ?(content_type = "text/html") () =
  Printf.sprintf
    "HTTP/1.1 %s\nContent-type: %s\n\n"
    http_code
    content_type

(* Contenu d'une page 404 *)
let page404 =
  "<h1>Erreur 404</h1>
   <p>La page demandée n'existe pas :(</p>"


(* Lit le contenu d'un fichier *)
let read_file filename =
  let channel = open_in filename in
  let length = in_channel_length channel in
  let result = Bytes.create length in
  let _ = really_input channel result 0 length in
  let _ = close_in channel in
  Bytes.to_string result
    

(* Socket écouteur *)
let listener_socket =
  let open Unix in
  socket PF_INET SOCK_STREAM 0

(* Envoi un message à un socket *)
let send sock content =
  let len = String.length content in
  (Unix.send sock content 0 len [])
  |> ignore
  
(* Envoi une chaine au client (avec le header HTTP)*)
let send_http_content
    ?(http_code = "200/OK")
    ?(content_type="text/html") client value =
  send client (http_header ~http_code ~content_type ());
  send client value

(* Envoi la page demandée au client *)
let send_http_page client =
  let req = input_line (Unix.in_channel_of_descr client) in
  let open Str in
  let page = match split (regexp " ") req with
    | [meth; p; protocol] ->
      begin 
        match global_replace (regexp "\\%20") " " p with
        | "/" -> "index.html"
        | file -> "."^file
      end 
    | _ -> "error 404"
  in
  let ctn =
    if Sys.file_exists page && not (Sys.is_directory page) then
      read_file page
    else
      page404
  in
  print_endline ("Page demandée: "^page);
  send_http_content client ctn
    
(* Boucle du serveur *)
let loop  =
  let open Unix in
  let rec loop () =
    let (client, client_ip) = accept listener_socket in
    print_endline "Connexion entrante";
    send_http_page client;
    Unix.close client;
    loop ()
  in loop

(* Routine principale *)
let () =
  let open Unix in
  let ( >>= ) = bind in
  let _ = listener_socket >>= Unix.ADDR_INET (addr, port) in
  let _ = Unix.listen listener_socket max_pending_request in
  Printf.printf "Serveur démarré sur le port %d\n" port;
  loop ()
  

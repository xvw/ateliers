(* The game *)
let ( % ) f g x = f (g x)
let id x = x

(* Return all neighbours *)
let neighbours =
  let longitude =
    LazyList.(cons PlaneZipper.left
                (return PlaneZipper.right))
  and latitude  =
    LazyList.(cons PlaneZipper.up
                (return PlaneZipper.down))
  in
  let open LazyList in
  longitude <++> latitude <++> (liftM2 ( % ) longitude latitude)

(* Count all alive neighbours *)
let alive zipper =
  let open LazyList in
  map (fun f -> PlaneZipper.coreturn (f zipper)) neighbours
  |> filter id
  |> length

(* Apply generation rule *)
let rule zipper =
  match alive zipper with
  | 2 -> PlaneZipper.coreturn zipper
  | 3 -> true
  | _ -> false

(* Generate next generation *)
let nextGen zipper =
  let open PlaneZipper in
  zipper =>> rule

(* display a zipper's line *)
let displayLine w zipper =
  let char = fun x -> if x then "*" else "." in
  let asList = Zipper.take w zipper in
  LazyList.map char asList
  |> LazyList.fold_left (fun acc x -> acc^x) ""

(* display PlaneZipper *)
let display w h (PlaneZipper.Plane zipper) =
  Zipper.take h zipper
  |> LazyList.map (displayLine w)
  |> LazyList.fold_left (fun acc x -> acc^"\n"^x) ""

let init_list i f =
  let rec aux acc i = 
    if i = -1 then acc
    else aux ((f i) :: acc) (pred i)
  in aux [] (pred i)
    
(* generate a sample's state *)
let sample w h =
  let _      = Random.self_init () in
  let g ()   = LazyList.from Random.bool in
  let emp () = Zipper.Zipper (g (), Random.bool (), g ()) in
  let open LazyList in 
  PlaneZipper.Plane (Zipper.Zipper (from emp, emp(), from emp))

let () =
  if Array.length Sys.argv < 3 then
    print_endline "usage: ./game width height"
  else begin
    let x = int_of_string Sys.argv.(1)
    and y = int_of_string Sys.argv.(2) in
    let t = ref (sample x y) in
    while true do 
      let _ = print_endline (display x y !t) in
      let _ = read_line () in
      t := nextGen !t
    done
  end 

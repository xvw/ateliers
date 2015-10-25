(* Description formelle des tables SQL *)
sequence taskSeq
table tasks : { Id : int, Date : time, Label : string }
              PRIMARY KEY Id


(* Gabarit de la page *)
fun header () =
    return <xml>
      <head>
        <title>Une todo-liste en Ur</title>
      </head>
    </xml>

fun presentation () =
    return <xml>
      <h1>Tâches à réaliser</h1>
      <p>
        Cette page est une petite application réalisée avec le langage Ur,
        en participation au site
        <a href="http://atelier-prog.github.io">
          Atelier-prog.github.io
        </a>
      </p>
    </xml>

(* Supprime une tâche référencée par son ID *)
fun remove_task r () =
    
    dml (DELETE FROM tasks WHERE Id = {[r]});

    hd    <- header ();
    pres  <- presentation ();
    form  <- formlet ();
    tasks <- retreive_tasks ();

    return <xml>
      {hd}
      <body>
        {pres}
        <p>La tâche a été supprimée !</p>
        {form}
        {tasks}
      </body>
    </xml>
    
    
(* Récupère le tableau des tâches *)
and retreive_tasks () =
    rows <- queryX
                (SELECT * FROM tasks)
                (fn tsk => <xml>
                  <tr>
                    <td>{[tsk.Tasks.Date]}</td>
                    <td>{[tsk.Tasks.Label]}</td>
                    <td>
                      <form>
                        <submit action={remove_task tsk.Tasks.Id}
                        value="Terminer la tâche" />
                      </form>
                    </td>
                  </tr>
                </xml>
                );
    return <xml>
      <br />
      <table border=1>
        <tr>
          <th>Date</th>
          <th>Label</th>
          <th>Terminée?</th>
        </tr>
        {rows}
      </table>
    </xml>
    

(* Procède à l'insertion d'une tâche dans la base de données *)
and add_task post =
    id <- nextval taskSeq;
    dml (INSERT INTO tasks (Id, Date, Label)
         VALUES({[id]}, CURRENT_TIMESTAMP, {[post.Label]}) );

    hd   <- header ();
    pres <- presentation ();
    form <- formlet ();
    tasks <- retreive_tasks ();
    
    return <xml>
      {hd}
      <body>
        {pres}
        <p>Tâche ajoutée dans la liste !</p>
        {form}
        {tasks}
      </body>
    </xml>

(* Génère le formlet pour ajouter une tâche *)
and formlet () =
    return <xml>
      <form>
        <textbox{#Label} placeholder="Le label de votre tâche"/>
        <submit action={add_task} value="Enregistrer la tâche " />
      </form>
    </xml>

fun main () =
    
    hd    <- header ();
    pres  <- presentation ();
    form  <- formlet ();
    tasks <- retreive_tasks ();

    return <xml>
      {hd}
      <body>
        {pres}
        {form}
        {tasks}
      </body>
    </xml>

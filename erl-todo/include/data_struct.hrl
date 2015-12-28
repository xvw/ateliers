%% A task is referenced by an ID and a Datetime. 
%% We use a title and a label for organisation. 
%% The state could be 0 : planned
%%                    1 : In progress 
%%                    _ : Finished

-record(
   task, 
   {
     id, 
     datetime, 
     title, 
     label,
     state
   }
  ).

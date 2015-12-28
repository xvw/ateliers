%% This module initialize the database (with Mnesia)

-module(initialize).
-export([do_once/0]).
-include("data_struct.hrl").
-author(["Xavier Van de Woestyne"]).


create_sh() ->
    Content = "#!/bin/sh\nerl -I include -pa ebin -s boot prompt -noshell",
    case file:open("todo.sh", write) of 
        {ok, S} -> io:format(S, "~s", [Content])
    end.

do_once() ->
    create_sh(),
    init:stop().

%% This module is the application's entry point. Prompt 
%% is the interactive loop

-module(boot).
-export([prompt/0]).
-include("data_struct.hrl").
-author(["Xavier Van de Woestyne"]).

prompt() ->
    io:format("Hello Clementine~n", []),
    init:stop().


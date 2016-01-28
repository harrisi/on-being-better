-module(functions).

-export([greet/2, head/1, second/1, same/2, valid_time/1]).

greet(male, Name) ->
    io:format("Hello, Mr. ~s!", [Name]);
greet(female, Name) ->
    io:format("Hello, Mrs. ~s!", [Name]);
greet(_, Name) ->
    io:format("Hello, ~s!", [Name]).

head([]) ->
    error;
head([H|_]) ->
    H.

second([_, S | _]) -> S.

same(X, X) ->
    true;
same(_, _) ->
    false.

valid_time({Date = {Y, M, D}, Time = {H, Min, S}}) ->
    io:format("The Date tuple (~p) says today is: ~p/~p/~p,~n", [Date, Y, M, D]),
    io:format("The Time tuple (~p) indicates: ~p:~p:~p.~n", [Time, H, Min, S]);
valid_time(_) ->
    io:format("Stop feeding me wrong data!~n").

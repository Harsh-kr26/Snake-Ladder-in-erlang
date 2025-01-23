-module(snake).
-export([min_throw/2]).

%N = 8.
%Arr = [3,22,5,8,11,26,20,29,17,4,19,7,27,1,21,9].

min_throw(N, Arr) ->
    Moves = create_moves(N, Arr),
    Visited = maps:from_list([{i, false} || i <- lists:seq(1, 30)]),
    Queue = [{1, 0}],
    bfs(Queue, Visited, Moves).

bfs([{Node, PrevMoves} | RemainingQueue], Visited, Moves) when Node =:= 30 -> 
    PrevMoves;
bfs([{Node, PrevMoves} | RemainingQueue], Visited, Moves) ->
    NextPositions = lists:filter(fun(Pos) -> Pos =< 30 andalso maps:get(Pos, Visited) =:= false end,
       lists:seq(Node + 1, min(Node + 6, 30))),
    NewVisited = lists:foldl(fun(Pos, Acc) -> maps:put(Pos, true, Acc) end, Visited, NextPositions),
    NewQueue = RemainingQueue ++
        lists:map(fun(Pos) ->
            {maps:get(Pos, Moves), PrevMoves + 1}
        end, NextPositions),
    bfs(NewQueue, NewVisited, Moves);

bfs(_, _, _) -> infinity.

create_moves(N, Arr) ->
    lists:foldl(fun(I, Acc) ->
               maps:put(lists:nth(I, Arr), lists:nth(I + 1, Arr), Acc)
           end, #{}, lists:seq(1, 2*N, 2)).

-module(practice).
-export([snakes_and_ladders/1]).

% Entry function for the Snakes and Ladders game
snakes_and_ladders(Board) ->
    N = length(Board),
    InitialDist = #{1 => 0},
    bfs([{1,0}], Board, N, InitialDist).

bfs([], _Board, _N, _Dist) ->
    -1;
bfs([{Current,Steps} | Rest], Board, N, Dist) when Current =:= N*N ->
    Steps;
bfs([{Current,Steps} | Rest], Board, N, Dist) ->
    NextMoves = get_next_moves(Current, Steps, Board, N, Dist),
    NewDist = update_distances(NextMoves, Dist),
    bfs(Rest ++ NextMoves, Board, N, NewDist).

get_next_moves(Current, Steps, Board, N, Dist) ->
    lists:flatmap(
        fun(Dice) ->
            check_move(Current + Dice, Steps, Board, N, Dist)
        end,
        lists:seq(1,6)).

check_move(Next, Steps, _Board, N, _Dist) when Next > N * N -> 
    [];
check_move(Next, Steps, Board, N, Dist) ->
    Row = (Next - 1) div N,
    Col = (Next - 1) rem N,

    AdjustedCol = case Row rem 2 of
        1 -> N - 1 - Col;
        0 -> Col
    end,
    AdjustedRow = N - 1 - Row,
    %io:format("adjrow value is : ~p", [AdjustedRow]),
    BoardRow = lists:nth(AdjustedRow + 1, Board),
    FinalNext = case lists:nth(AdjustedCol + 1, BoardRow) of
        -1 -> Next;
        Value -> Value
    end,
    case maps:find(FinalNext, Dist) of
        error -> [{FinalNext, Steps + 1}];
        {ok, OldSteps} ->
            case Steps + 1 < OldSteps of
                true -> [{FinalNext, Steps + 1}];
                false -> []
            end 
    end.

update_distances(Moves, Dist) ->
    lists:foldl(
        fun({Pos, Step}, AccDist) ->
            maps:put(Pos, Step, AccDist)
        end,
        Dist,
        Moves).
    
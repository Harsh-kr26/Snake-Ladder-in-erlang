-module(snake_ladder).
-export([min_dice_throws/3]).


min_dice_throws(N, Snakes, Ladders) ->
    % Create the board 
    Board = create_board(N*N, Snakes, Ladders),
    
    bfs(Board, N*N).

% Create board representation with snakes and ladders
create_board(BoardSize, Snakes, Ladders) ->
    
    EmptyBoard = maps:new(),
    
    % Add snakes to the board
    BoardWithSnakes = lists:foldl(
        fun({From, To}, Acc) -> maps:put(From, To, Acc) end,
        EmptyBoard,
        Snakes
    ),
    
    % Add ladders to the board
    BoardWithSnakesAndLadders = lists:foldl(
        fun({From, To}, Acc) -> maps:put(From, To, Acc) end,
        BoardWithSnakes,
        Ladders
    ),
    
    BoardWithSnakesAndLadders.

% Breadth-first search implementation
bfs(Board, Target) ->

    Queue = queue:in({1, 0}, queue:new()),
   
    Visited = sets:from_list([1]),
    
  
    bfs_loop(Queue, Visited, Board, Target).

bfs_loop(Queue, Visited, Board, Target) ->
    case queue:out(Queue) of
        {empty, _} ->
            -1;
        
        {{value, {CurrentCell, Distance}}, RestQueue} ->
            if
                CurrentCell =:= Target ->
                    Distance;
                true ->
                    % Try all possible dice throws (1-6)
                    {NewQueue, NewVisited} = process_neighbors(
                        CurrentCell, Distance, RestQueue, Visited, Board, Target
                    ),
                    bfs_loop(NewQueue, NewVisited, Board, Target)
            end
    end.

process_neighbors(CurrentCell, Distance, Queue, Visited, Board, Target) ->
    lists:foldl(
        fun(DiceValue, {AccQueue, AccVisited}) ->
            NextCell = CurrentCell + DiceValue,
            
            if
                NextCell > Target ->
                    {AccQueue, AccVisited};
                true ->
                    % Check if there's a snake or ladder
                    FinalCell = case maps:find(NextCell, Board) of
                        {ok, Destination} -> Destination;
                        error -> NextCell
                    end,
                    
                    % If cell is not visited yet, add it to the queue
                    case sets:is_element(FinalCell, AccVisited) of
                        true ->
                            {AccQueue, AccVisited};
                        false ->
                            NewVisited = sets:add_element(FinalCell, AccVisited),
                            NewQueue = queue:in({FinalCell, Distance + 1}, AccQueue),
                            {NewQueue, NewVisited}
                    end
            end
        end,
        {Queue, Visited},
        lists:seq(1, 6)
    ).
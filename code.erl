-module(snake_ladder).
-export([min_throw/2]).

min_throw(N,arr) ->

    Moves = create_map(N,arr),

    Visited = maps:from_list([{i,false} || i <- lists:seq(1,100)]),

    Q = queue:in([1,0],Q).

    bfs(Q, Visited, Moves).

% To Do : create bfs and create_map function
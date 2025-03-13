-module(snake_ladder_tests).
-include_lib("eunit/include/eunit.hrl").


basic_test() ->
    ?assertEqual(4, snake_ladder:min_dice_throws(5, [], [])).

ladder_test() ->
    ?assertEqual(2, snake_ladder:min_dice_throws(10, [], [{2, 95}])).

snake_test() ->
    ?assertEqual(4, snake_ladder:min_dice_throws(5, [{20, 2}], [])).

direct_win_test() ->
    ?assertEqual(1, snake_ladder:min_dice_throws(10, [], [{2, 100}])).

empty_board_test() ->
    ?assertEqual(1, snake_ladder:min_dice_throws(2, [], [])).

complex1_test() ->
    N = 6,
    Ladders = [{2, 15}, {14, 35}],
    Snakes = [{17, 13}],
    ?assertEqual(4, snake_ladder:min_dice_throws(N, Snakes, Ladders)).

complex2_test() ->
    Ladders = [{3, 15}, {8, 25}, {20, 34}],
    Snakes = [{17, 4}, {32, 12}, {30, 2}],
    ?assertEqual(3, snake_ladder:min_dice_throws(6, Snakes, Ladders)).

complex3_test() ->
    N = 10,
    Snakes = [{17, 7}, {54, 34}, {62, 19}, {64, 60}, {87, 24}, {93, 73}, {95, 75}, {99, 78}],
    Ladders = [{4, 14}, {9, 31}, {20, 38}, {28, 84}, {40, 59}, {51, 67}, {63, 81}, {71, 91}],
    ?assertEqual(7, snake_ladder:min_dice_throws(N, Snakes, Ladders)).

impossible_test() ->
    N = 3,
    Snakes = [{2,1},{3,1},{4,1},{5,1},{6,1},{7,1}],
    ?assertEqual(-1, snake_ladder:min_dice_throws(N, Snakes, [])).
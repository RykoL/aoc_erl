-module(aoc3).
-import(helper, [read_lines/1]).

-compile([export_all]).

-record(point, {x = 0 , y = 0 }).


start() ->
    [Line1, Line2] = lists:map(fun (Line) -> string:tokens(string:trim(Line), ",") end, read_lines("aoc3.txt")),
    Points1 = sets:from_list(traverse_line(Line1)),
    Points2 = sets:from_list(traverse_line(Line2)),
    Distances = [get_distance(P) || P <- sets:to_list(sets:intersection(Points1, Points2))],
    io:format("~p~n", [Distances]),
    lists:min(lists:delete(0, Distances)).

traverse_line(Wire) ->
    lists:foldl(fun traverse_line/2, [#point{x = 0, y = 0}], Wire).
traverse_line([Dir | C], Vectors) ->
    Last = lists:nth(1, Vectors),
    Steps = list_to_integer(C),
    
    Points = case Dir of
	$U -> [#point{x = 0, y = -Y} || Y <- lists:seq(1, Steps)];
	$D -> [#point{x = 0, y = Y} || Y <- lists:seq(1, Steps)];
	$L -> [#point{x = -X, y = 0} || X <- lists:seq(1, Steps)];
	$R -> [#point{x = X, y = 0} || X <- lists:seq(1, Steps)]
    end,
    lists:reverse([add_point(Last, Point) || Point <- Points]) ++ Vectors.
    
add_point(P1, P2) ->
    #point{x = P1#point.x + P2#point.x, y = P1#point.y + P2#point.y}.


get_distance(#point{x = X, y = Y}) ->
    abs(X) + abs(Y).
    


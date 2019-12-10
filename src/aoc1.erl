-module(aoc1).
-export([process_masses/0]).
-import(file, [open/2]).


read_file() ->
    {ok, Device} = open('aoc1.txt', [read]),
    read_line(Device, []).

read_line(IoDevice, Integers) ->
    case io:get_line(IoDevice, "") of
	eof ->
	    lists:reverse(Integers);
	Data ->
	    Number = list_to_integer(string:trim(Data)),
	    read_line(IoDevice, [Number | Integers])
    end.
	  

%calculate_fuel() ->
%    Masses = read_file(),
%    lists:sum([math:floor(X / 3) - 2 || X <- Masses]).
process_masses() ->
    Masses = read_file(),
    lists:sum([calculate_fuel(X) || X <- Masses]).
    
calculate_fuel(Mass) when Mass >= 0 ->
    Fuel = math:floor(Mass / 3) - 2,
    Fuel + calculate_fuel(Fuel);
calculate_fuel(Mass) when Mass =< 0 ->
    0.


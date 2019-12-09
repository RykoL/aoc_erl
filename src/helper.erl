-module(helper).
-import(file, [open/2]).
-export([read_lines/1]).

read_lines(Location) ->
    {ok, Device} = open(Location, [read]),
    read_line(Device, []).

read_line(IoDevice, Integers) ->
    case io:get_line(IoDevice, "") of
	eof ->
	    lists:reverse(Integers);
	Data ->
	    read_line(IoDevice, [Data | Integers])
    end.

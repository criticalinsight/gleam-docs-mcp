-module(cli_ffi).
-export([exec/1]).

exec(Command) ->
    Output = os:cmd(binary_to_list(Command)),
    unicode:characters_to_binary(Output).

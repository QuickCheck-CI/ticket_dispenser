-module(ticket_dispenser).

-export([start/0, stop/1, reset/1, take/1]).

start() ->
  {ok, spawn(fun() -> run(0) end)}.

stop(Pid) ->
  Pid ! {stop, self()},
  ok.

reset(Pid) ->
  write(Pid, 0).

take(Pid) ->
  N = read(Pid),
  N2 = write(Pid, N + 1),
  N2.

% -------------------

read(Pid) ->
  Pid ! {read, self()},
  receive N -> N end.

write(Pid, N) ->
  Pid ! {write, self(), N},
  receive N1 -> N1 end.

run(N) ->
  receive 
    {read, From} ->
      From ! N,
      run(N);
    {write, From, NewN} ->
      From ! NewN,
      run(NewN);
    {stop, _From} ->
      ok;
    Input ->
      io:format("Unexpected input ~p~n", [Input]),
      run(N)
  end.



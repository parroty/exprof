ExProf
============

[![Build Status](https://github.com/parroty/excoveralls/workflows/tests/badge.svg)](https://github.com/parroty/exprof/actions)
[![hex.pm version](https://img.shields.io/hexpm/v/exprof.svg)](https://hex.pm/packages/exprof)
[![hex.pm downloads](https://img.shields.io/hexpm/dt/exprof.svg)](https://hex.pm/packages/exprof)

A simple code profiler for Elixir using eprof.

It provides a simple macro as a wrapper for Erlang's <a href="http://www.erlang.org/doc/man/eprof.html" target="_blank">:eprof</a> profiler.

### Install
Add `:exprof` to `deps` section of `mix.exs`.

```elixir
  def deps do
    [ {:exprof, "~> 0.2.0"} ]
  end
```

### Usage
import "ExProf.Macro", then use "profile" macro to start profiling. It
prints out results, and returns them as list of records, along with the
result of the profiled block.

```elixir
defmodule SampleRunner do
  import ExProf.Macro

  @doc "analyze with profile macro"
  def do_analyze do
    profile do
      :timer.sleep 2000
      IO.puts "message\n"
    end
  end

  @doc "get analysis records and sum them up"
  def run do
    {records, _block_result} = do_analyze
    total_percent = Enum.reduce(records, 0.0, &(&1.percent + &2))
    IO.inspect "total = #{total_percent}"
  end
end
```

### Run
An example to use in iex console.

```elixir
$ iex -S mix
..
iex(1)> SampleRunner.run
message

FUNCTION                                 CALLS      %  TIME  [uS / CALLS]
--------                                 -----    ---  ----  [----------]
'Elixir.IO':puts/2                           1   0.86     1  [      1.00]
io:o_request/3                               1   1.72     2  [      2.00]
io:put_chars/2                               1   1.72     2  [      2.00]
erlang:group_leader/0                        1   1.72     2  [      2.00]
io:request/2                                 1   2.59     3  [      3.00]
io:execute_request/2                         1   2.59     3  [      3.00]
'Elixir.SampleRunner':'-run/0-fun-0-'/0      1   2.59     3  [      3.00]
'Elixir.IO':map_dev/1                        1   3.45     4  [      4.00]
erlang:demonitor/2                           1   4.31     5  [      5.00]
io:io_request/2                              1   6.03     7  [      7.00]
io:wait_io_mon_reply/2                       1   6.90     8  [      8.00]
'Elixir.IO':puts/1                           1   8.62    10  [     10.00]
unicode:characters_to_binary/2               1  11.21    13  [     13.00]
timer:sleep/1                                1  14.66    17  [     17.00]
erlang:monitor/2                             1  31.03    36  [     36.00]
"total = 100.0"
```

### Add a Mix Task
An example to use as mix tasks.

```elixir
defmodule Mix.Tasks.Exprof do
  @shortdoc "Profile using ExProf"
  use Mix.Task
  import ExProf.Macro

  def run(_mix_args) do
    profile do: do_work(2)
  end

  defp do_work(n) do
    :timer.sleep(n * 1000)
  end
end
```

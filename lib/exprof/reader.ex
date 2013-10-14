defmodule ExProf.Reader do
  @moduledoc """
  A reader for eprof outputs.
  """

  @doc """
  Read the eprof output file and returns the parsed result of Prof records.
  """
  def read(file_name) do
    File.read!(file_name) |> String.split("\n") |> parse([])
  end

  defp parse([], acc), do: Enum.reverse(acc)
  defp parse([head|tail], acc) do
    case parse_record(head) do
      nil    -> parse(tail, acc)
      record -> parse(tail, [record|acc])
    end
  end

  defp parse_record(head) do
    case Regex.run(%r/(.+?\/[0-9])\s+(.+?)\s+(.+?)\s+(.+?)\s+\[\s+(.+?)\]/, head) do
      [_all, function, calls, percent, time, us_per_call] ->
        Prof.new(function: function, calls: binary_to_integer(calls), percent: binary_to_float(percent),
                 time: binary_to_integer(time), us_per_call: binary_to_float(us_per_call))
      nil -> nil
    end
  end
end

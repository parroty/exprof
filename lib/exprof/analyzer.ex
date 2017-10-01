defmodule ExProf.Analyzer do
  @moduledoc """
  Proivdes helper methods for operating Prof records.
  """
  import ExPrintf

  @doc """
  Returns records only have major percent values, and filter out rest of them.
  The default is to pick "80%" and it can be changed by specifying rate argument.
  """
  def get_top_percent_items(records, rate \\ 80.0) do
    sorted_records = Enum.sort(records, &(&1.percent > &2.percent))
    do_get_top_percent_items(sorted_records, rate, [])
  end

  defp do_get_top_percent_items(records, rate, acc) when length(records) == 0 or rate <= 0.0 do
    Enum.reverse(acc)
  end

  defp do_get_top_percent_items([head|tail], rate, acc) do
    do_get_top_percent_items(tail, rate - head.percent, [head|acc])
  end

  @doc """
  Print records to screen
  """
  def print(records) do
    print_header()
    Enum.each(records, &(do_print(&1)))
  end

  defp print_header do
    IO.puts "FUNCTION                                           CALLS       %  TIME  [uS / CALLS]"
    IO.puts "--------                                           -----     ---  ----  [----------]"
  end

  defp do_print(record) do
    printf("%-50s %-6d %6.2f %5d  [%10.2f]\n",
      [String.slice(record.function, 0, 50), record.calls, record.percent, record.time, record.us_per_call])
  end
end

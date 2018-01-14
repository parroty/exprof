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
    {records, result} = do_analyze()
    total_percent = Enum.reduce(records, 0.0, &(&1.percent + &2))
    IO.inspect "total = #{total_percent}"
    result
  end
end

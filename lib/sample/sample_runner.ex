defmodule SampleRunner do
  import ExProf.Macro

  def run do
    records = analyze
    total_percent = Enum.reduce(records, 0.0, &(&1.percent + &2))
    IO.inspect "total = #{total_percent}"
  end

  def analyze do
    profile do
      :timer.sleep 2000
      IO.puts "message\n"
    end
  end
end

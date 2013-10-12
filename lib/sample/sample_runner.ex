defmodule SampleRunner do
  import ExProf.Macro

  def run do
    records = profile do
      :timer.sleep 2000
      IO.puts "message\n"
    end

    sum = Enum.reduce(records, 0.0, fn(record, acc) -> record.percent + acc end)
    IO.inspect "sum = #{sum}"
  end
end

defmodule ExprofTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "the truth" do
    assert(true)
  end

  test "sample runner" do
    assert capture_io(fn ->
      SampleRunner.run
    end) =~ ~r/FUNCTION\s+CALLS/m
  end
end

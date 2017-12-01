defmodule ExprofTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "sample runner" do
    assert capture_io(fn ->
      SampleRunner.run
    end) =~ ~r/FUNCTION\s+CALLS/m
  end

  @tag timeout: 1000
  test "abort on exit" do
    import ExProf.Macro

    Process.flag(:trap_exit, true)

    pid = spawn_link(fn ->
      profile do
        Process.exit(self(), :kill)
      end
    end)

    assert_receive {:EXIT, ^pid, :killed}, 500
  end
end

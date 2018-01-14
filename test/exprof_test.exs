defmodule ExprofTest do
  use ExUnit.Case, async: false
  import ExUnit.CaptureIO

  test "sample runner" do
    assert capture_io(fn ->
      assert :ok = SampleRunner.run
    end) =~ ~r/FUNCTION\s+CALLS/m
  end

  @tag timeout: 1000
  test "abort on exit" do
    Process.flag(:trap_exit, true)

    pid = spawn_link(fn ->
      import ExProf.Macro

      profile do
        Process.exit(self(), :kill)
      end
    end)

    assert_receive {:EXIT, ^pid, :killed}, 500
  end
end

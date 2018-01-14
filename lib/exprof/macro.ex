defmodule ExProf.Macro do
  @moduledoc """
  Provides a macro to profile a block of code.
  """

  @doc """
  A macro to specify the code block to profile.

  It spawns a new process to execute the code block for isolating the profile result.
  (ex.)

      profile do
        :timer.sleep 2000
      end

  """
  defmacro profile(do: code) do
    quote do
      pid = spawn_link(ExProf.Macro, :execute_profile, [fn -> unquote(code) end])
      ExProf.start(pid)
      send pid, self()

      result =
        receive do
          result -> result
        end

      ExProf.stop
      records = ExProf.analyze

      {records, result}
    end
  end

  @doc """
  An internal method for initiating profiling.
  """
  def execute_profile(func) do
    receive do
      sender ->
        send sender, func.()
    end
  end
end

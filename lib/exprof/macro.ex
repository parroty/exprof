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
      ref = make_ref()
      pid = spawn_link(ExProf.Macro, :execute_profile, [fn -> unquote(code) end, ref])
      ExProf.start(pid)
      send pid, {ref, self()}

      result =
        receive do
          {^ref, result} -> result
        end

      ExProf.stop
      records = ExProf.analyze

      {records, result}
    end
  end

  @doc """
  An internal method for initiating profiling.
  """
  def execute_profile(func, ref) do
    receive do
      {^ref, sender} ->
        send sender, {ref, func.()}
        forward_other_messages(sender)
    end
  end

  defp forward_other_messages(sender) do
    receive do
      message ->
        send sender, message
        forward_other_messages(sender)
    end
  end
end

defmodule ExProf.Macro do
  defmacro profile(code) do
    quote do
      pid = spawn(ExProf.Macro, :execute_profile, [fn -> unquote(code) end])
      ExProf.start(pid)
      pid <- self

      receive do
        _ -> nil
      end

      ExProf.stop
      ExProf.analyze
    end
  end

  def execute_profile(func) do
    receive do
      sender ->
        func.()
        sender <- nil
    end
  end
end

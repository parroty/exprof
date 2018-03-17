defmodule ExProf do
  @moduledoc """
  Wrapper for eprof library.
  It needs to be called in start -> stop -> analyze order.
  """

  # temporary file for storing eprof output
  @tmp_prof_name 'tmp_exprof'

  @doc """
  Start the profiling for the specified pid.
  """
  def start(pid \\ self()) do
    :eprof.start
    :eprof.start_profiling([pid])
  end

  @doc """
  Stop the profiling previously started with start method call.
  """
  def stop do
    :eprof.stop_profiling
  end

  @doc """
  Analyze and output the profiling as the list of Prof records.
  It also outputs to the STDOUT.
  """
  def analyze do
    random_number = :rand.uniform(100)
    file_name = to_string(@tmp_prof_name ++ [to_string(random_number)])
    :eprof.log(file_name)
    :eprof.analyze(:total, [{:sort, :time}])
    records = ExProf.Reader.read(file_name)
    File.rm!(file_name)
    records
  end
end

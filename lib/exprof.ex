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
    :eprof.log(@tmp_prof_name)
    :eprof.analyze(:total, [{:sort, :time}])
    records = ExProf.Reader.read(@tmp_prof_name)
    File.rm!(@tmp_prof_name)
    records
  end
end

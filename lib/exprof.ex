defmodule ExProf do
  @tmp_prof_name 'tmp_exprof'

  def start(pid // self) do
    :eprof.start
    :eprof.start_profiling([pid])
  end

  def stop do
    :eprof.stop_profiling
  end

  def analyze do
    :eprof.log(@tmp_prof_name)
    :eprof.analyze(:total, [{:sort, :time}])
    records = ExProf.Reader.read(@tmp_prof_name)
    File.rm!(@tmp_prof_name)
    records
  end
end

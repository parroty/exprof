0.2.4
------
#### Changes
* Makes sure it is OK for the profiled code to send/receive messages (#13).
* Fix for warnings with elixir v1.11.
  * Add :tools to extra_applications in mix.exs (#15).

0.2.3
------
#### Changes
* Fixes issue on windows where you get File.Error permission denied.
   - Changed to use randomized file name (#11).

0.2.2
------
#### Changes
* Return block result after completion (#9).
* Link profiled process to avoid hang (#10).

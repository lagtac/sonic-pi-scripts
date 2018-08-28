use_random_seed 40
use_bpm 120

live_loop :foo do
  use_synth :dull_bell
  notes = ring(:g4, :a4, :bb4)
  notes.each do |n|
    tick
    play notes.look, cutoff: rrand(60, 100), release: 15, amp: 0.5, pan: -0.5
    sleep 10
  end
  play :g3, release: 20
  sleep 10
end

live_loop :baz do
  use_synth :beep
  play choose([:c3, :e3, :a3]), amp: 0.1, pan: 0.7
  sleep 1
end

live_loop :beat do
  with_fx :reverb, mix: 0.5 do |fx|
    sample :loop_mika, rate: choose([1,-1]), start: 0, finish: 0.125, amp: 0.5, pan: -0.5
    sample :perc_bell, amp: 0.3, pan: 0.5
    sleep 10
  end
end


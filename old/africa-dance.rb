use_bpm 50

live_loop :qwe do
  with_fx :echo, phase: 0.5, decay: 1, mix: 0.0 do
    with_fx :distortion, mix: 0.5, distort: 0.1 do
      idx = tick
      play (scale :e3, :minor_pentatonic)[idx], release: 0.1
      sleep 0.125
    end
  end
end

live_loop :bass, sync: :qwe do
  stop
  use_synth :fm
  with_fx :echo, mix: 0.5 do
    play (ring 0, :g3, :fs3, :d3, :e3, 0, 0, 0).tick, amp: 1
    play (chord :g4, :maj9), amp: 0.3, release: 0.1, cutoff: 130
  end
  sleep 0.75
  
end

live_loop :beat, syn: :qwe do
  stop
  s = :drum_snare_soft
  with_fx :echo, phase: 0.1, decay: 8 do
    sample s, rate: 1, amp: 1
    ##| sleep sample_duration s
  end
  sleep 6
end

live_loop :mel, sync: :qwe do
  stop
  with_fx :slicer, phase: 0.125, phase_offset: 0.1, mix: 1 do
    use_synth :dtri
    s = play :g3, note_slide: 0.25, release: 4, amp: 0.5
    sleep 1.5
    control s, note: :b5
    sleep 6
  end
end

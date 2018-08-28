# polyarp

use_bpm 120
use_debug false

define :polyarp do |n|
end

with_fx :gverb, damp: 0.3, dry: 1, mix: 0.25, ref_level: 0.7, release: 1.5, room: 30, spread: 1 do
  live_loop :q do
    #tick_reset_all
    #stop
    with_fx :level, amp: ((line 0, 1, steps: 96).ramp.tick) do
      tick :t0
      use_synth :pretty_bell
      r = (ring 1, 2, 3)
      idx = r.look(:t0) * 1 # mult by 2 to allow reflection of ring
      print idx
      sample :bd_gas, pan: 0, amp: 1, finish: 1
      idx.times do
        tick :t1
        play (chord_degree :ii, :f3, :ionian, r.look(:t0)).look(:t1), amp: (line 0, 1, steps: 200).ramp.look(:t0), attack: 0.01, release: 0.2, decay: 0.25
        #play (chord_degree :vi, :f3, :ionian, r.look(:t0)).reverse.look(:t1), attack: 0.01, release: 0.2, pan: 0, decay: 0.02
        #play (chord_degree :iv, :f3, :ionian, r.look(:t0)).look(:t1), attack: 0.01, release: 0.2, pan: 0, decay: 0.02
        
        #play (chord :g3, :m7, num_octaves: 2).look(:t1), attack: 0.01, release: 0.05, pan: 0.5, decay: 0.2
        sleep 0.25
      end
      tick_reset :t1
    end
  end
end

live_loop :p do
  #stop
  use_synth :prophet
  with_fx :level, amp: 1 do
    with_fx :distortion, distort: 0.5, mix: 0.2 do
      1.times do
        with_fx :slicer, mix: 0.5, wave: 1, invert_wave: 0, smooth: 0, pulse_width: (ring 0.5, 0.3).choose do
          tick
          s =(knit [:d4, :d2], 1, [:g3, :g2], 1, :r, 2, [:a3,:a1], 1, [:eb3, :eb2], 1, :r, 2)
          #s2 = (knit :d3, 1)
          c = play s.look, amp: 1, pan: (rrand -1, 1), attack: 0.1, sustain: 1, release: 11, res: 0.7, cutoff: 50, cutoff_slide: 1.5
          sleep 3.75
          control c, cutoff: 120
          sleep 2.25
          control c, cutoff: 100
          #sleep 1
        end
      end
    end
  end
end

live_loop :bass do
  #stop
  use_synth :subpulse
  with_fx :level, amp: 0 do
    with_fx :panslicer, mix: 1, wave: 3, amp: 1, phase: 6, pan_min: -0.7, pan_max: 0.7 do
      with_fx :distortion, mix: 1, distort: [0.6, 0.7].choose do
        with_fx :ring_mod, mix: 0, freq: 6, mod_amp: 1.1 do
          16.times do
            density (knit 1, 48 ).look do
              sleep 0.75
              tick
              play (knit :g3, 2, :g4, 48, :a4, 48, :bb4, 96, :d5, 96, :c5, 48).look, amp: 0.0, attack: 0.0, release: 0.2,
                cutoff: (line 80, 120, steps: 48).look, pulse_width: 0.5, sub_detune: -12.1
              play (knit :d3, 1, :d4, 1, :d5, 1).look, amp: 1, attack: 0.0, release: 0.25,
                cutoff: (line 100, 70, steps: 48).look, pulse_width: 0.5, sub_detune: -24.1
              sleep -0.5
            end
          end
        end
      end
    end
  end
end

live_loop :bakir1 do
  stop
  sp = sample_paths '~/personal/audio/samples/aghiaanna/'
  sleep 3
  sample sp[0], pre_amp: 3, beat_stretch: 1.5, pan: -1
  #sample sp[0], pre_amp: 1, beat_stretch: 2.2, pan: -1
  sleep 3
  sample sp[0], pre_amp: 3, beat_stretch: 1, pan: 1
  sleep 18
end

live_loop :bakir2 do
  tick
  with_fx :level, amp: 1 do
    sp = sample_paths '~/personal/audio/samples/aghiaanna/'
    with_fx :bitcrusher, mix: 1, bits: 8, sample_rate: (line 8000, 8000, steps: 24).look do
      density (knit 1, 8, 2, 4).look do
        #sleep 1.5
        sample sp[16], pan: rrand(-1, 1), beat_stretch: 3,  num_slices: 32,  slice: (range 1, 13, 1).look, lpf: (ring 100, 120).choose
        sleep (knit 0.25, 4).look
      end
    end
  end
end
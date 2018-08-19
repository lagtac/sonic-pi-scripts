use_bpm 120
use_debug false

define :polyarp do |n|
end

with_fx :gverb, damp: 0.3, dry: 1, mix: 0.2, ref_level: 0.7, release: 1.5, room: 30, spread: 1 do
  live_loop :q do
    with_fx :level, amp: (line 1, 1, steps: 24).ramp.tick do
      with_fx :panslicer, mix: 0,  phase: 3, smooth: 0, wave: 3, pan_min: -1, pan_max: 1 do
        4.times do
          tick :t0
          use_synth :pretty_bell
          r = (ring 1, 2, 3)
          idx = r.look(:t0) * 1 # mult by 2 to allow reflection of ring
          print idx
          sample :bd_gas, pan: 0, amp: 1, finish: 1
          idx.times do
            tick :t1
            play (chord_degree :ii, :f3, :ionian, r.look(:t0)).look(:t1), attack: 0.01, release: 0.2, pan: -0.5, decay: 0.2
            #play (chord_degree :vi, :f3, :ionian, r.look(:t0)).reverse.look(:t1), attack: 0.01, release: 0.2, pan: -0.5, decay: 0.02
            #play (chord_degree :iv, :f3, :ionian, r.look(:t0)).look(:t1), attack: 0.01, release: 0.2, pan: -0.5, decay: 0.02
            
            #play (chord :g3, :m7, num_octaves: 2).look(:t1), attack: 0.01, release: 0.05, pan: 0.5, decay: 0.2
            sleep 0.25
          end
          tick_reset :t1
        end
      end
    end
  end
  
  live_loop :p do
    #stop
    use_synth :prophet
    with_fx :level, amp: 0 do
      with_fx :distortion, distort: 0.5, mix: 0.2 do
        24.times do
          with_fx :slicer, mix: 0, invert_wave: 0, smooth: 0, pulse_width: (ring 0.5, 0.3).choose do
            tick
            s =(knit [:d4, :d2], 1, [:g3, :g2], 1, :r, 2, [:a3,:a1], 1, [:eb3, :eb2], 1, :r, 2)
            c = play s.look, amp: 1, pan: (rrand -0.5, 0.5), attack: 0.1, sustain: 1, release: 11, res: 0.7, cutoff: 50, cutoff_slide: 0.4
            sleep 0.75
            control c, cutoff: 100
            sleep 1.25
            control c, cutoff: 50
            sleep 1
          end
        end
      end
    end
  end
  
  live_loop :lead1 do
    use_synth :blade
    with_fx :level, amp: 0 do
      with_fx :gverb, room: 100, dry: 1, mix: 0, release: 20, damp: 0.5 do
        with_fx :echo, mix: 0, max_phase: 3,  phase: 3, decay: 3 do
          24.times do
            tick
            sleep 0.75
            s = (knit :bb4, 1, :g4, 1, :r, 1, :bb4, 1, :a4, 1, :r, 3).look
            play s, amp: 1, pan: -0.5, sustain: 2,  release: 1.25, attack: 0.1, cutoff: 110,
              vibrato_rate: 8, vibrato_onset: 0.3, vibrato_delay: 0.6, vibrato_depth: 1
            play s - 11.9, amp: 1, pan: 0.5, sustain: 2, release: 2.25, attack: 0.2, cutoff: 88,
              vibrato_rate: 7, vibrato_onset: 0.3, vibrato_delay: 0.6, vibrato_depth: 2
            play s - 24.1, amp: 1, sustain: 1, release: 1.6, attack: 0.1, cutoff: 90
            sleep 2.25
          end
        end
      end
    end
  end
  
  live_loop :bass do
    #stop
    use_synth :subpulse
    with_fx :level, amp: 1 do
      with_fx :panslicer, wave: 3, amp: 1, phase: 6, pan_min: -0.7, pan_max: 0.7 do
        with_fx :distortion, distort: [0.6, 0.7].choose do
          with_fx :reverb, damp: 0.9, room: 0.8, mix: 0 do
            24.times do
              density (knit 1, 24).look do
                sleep 0.75
                tick
                play (knit :g3, 1, :g4, 1).look, amp: 0.5, attack: 0, release: 0.175,
                  cutoff: (line 90, 120, steps:48).look, pulse_width: 0.5, sub_detune: -12
                play (knit :d3, 1, :d4, 1).look, amp: 1, attack: 0.0, release: 0.2,
                  cutoff: (line 100, 70, steps:48).look, pulse_width: 0.5, sub_detune: -20
                sleep (knit -0.5, 1).look
              end
            end
          end
        end
      end
    end
  end
  
  live_loop :bakir1 do
    #stop
    sp = sample_paths '~/personal/audio/samples/aghiaanna/'
    sleep 3
    sample sp[0], pre_amp: 3, beat_stretch: 1.5, pan: -1
    sleep 3
    sample sp[0], pre_amp: 3, beat_stretch: 1, pan: 1
    sleep 18
  end
  
  live_loop :bakir2 do
    tick
    sp = sample_paths '~/personal/audio/samples/aghiaanna/'
    with_fx :bitcrusher, mix: 1, bits: 2, sample_rate: (line 1000, 8000, steps: 24).look do
      with_fx :echo, phase: 0.25, max_phase: 3, decay: 0.2, mix: 0 do
        with_fx :slicer, phase: 0.175, mix: 0 do
          density (knit 0.25, 12, 1, 20, 2, 8, 3, 2, 4, 12).look do
            #sleep 1.5
            sample sp[16], pan: 0, beat_stretch: 3,  num_slices: 32,  slice: (range 1, 13, 1).look, lpf: 130
            sleep (knit 0.25, 4).look
          end
        end
      end
    end
  end
end
# faros

use_bpm 113
with_fx :reverb, mix: 0.5, damp: 0.5, room: 0.5 do
  live_loop :arp_1 do
    stop
    use_bpm 113
    tick
    use_synth :pluck
    density 1 do
      play (chord_degree :ii, :f3, :ionian, (ring 2, 5, 9).look).look, amp: 1, pan: -0.5, coef: rrand(0.5, 0.6), noise_amp: 0.4, release: 2
      sleep 0.25
    end
    #play (chord_degree :ii, :f4, :ionian, (ring 0, 3, 5, 5, 3, 1).look), amp: 1, pan: 0.5, coef: rrand(0.2, 0.4), noise_amp: 0.8
    #sleep 0.25
  end
  
  
  
  live_loop :bass do
    #stop
    tick
    use_synth :growl
    with_fx :level, amp: 1 do
      with_fx :compressor, pre_amp: 3,  mix: 1 do
        play (ring :g4, :eb4, :c4, :d4).stretch(2).look, release: 0.55
        play (ring :g3, :eb3, :c3, :d3).stretch(2).look, release: 0.75
        sleep 3
      end
    end
  end
  
  live_loop :lead do
    stop
    tick
    use_synth :dark_ambience
    with_fx :level, amp: 1 do
      with_fx :compressor, pre_amp: 1, mix: 0.5 do
        with_fx :echo, phase: [0.2, 1].choose, decay: 4 do
          with_fx :slicer, phase: 0.25, wave: 1 do
            c = play (ring :g4, :a4 , :r, :bb4, :a4, :r).look, amp: 1,
              detune1: 12, detune2: 0.2, noise: 0, ring: 2,
              attack: 8, sustain: 4, release: 8, reverb_time: 50, room: 100,
              res: 0.1,
              res_slide: 0.5,
              cutoff: 130,
              cutoff_slide: [6].look,
              ring_slide: 1
            sleep 12
            control c, res: 0.1, cutoff: 90, ring: 2
            #sleep 3
          end
        end
      end
    end
  end
  
  live_loop :bell do
    stop
    tick
    use_synth :dull_bell
    seq = (chord :f6, :m7, invert: 2).look
    with_fx :level, amp: 1 do
      with_fx :ixi_techno, phase: [4, 0.175, 0.25].ring.look, res: 0.1  do
        play seq, amp: 0.2, pan: 0.6, attack: 1, release: 6
      end
      play seq, amp: 0.5, pan: -0.25, attack: 0.01
      sleep (knit 3, 4, 12, 3).look
    end
  end
  
  live_loop :snare do
    stop
    tick
    with_fx :level, amp: 1 do
      with_fx :bitcrusher, cutoff: (line 120, 60, steps: 16).mirror.look, sample_rate: 8000, bits: 6  do
        with_fx :echo, phase: (ring 0.5, 0.25).look, decay: 2.9, mix: 0.5 do
          sleep 1.5
          sample :drum_snare_hard, start: 0, finish: 0.2
          sleep 1.5
        end
      end
    end
  end
end
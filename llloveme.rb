# loveme

use_bpm 113
#reset_mixer!
#set_mixer_control! amp: 1, pre_amp: 1, hpf: 0, hpf_slide: 1

live_loop :g do
  tick
  amp = 0.5
  pan = 0.5
  use_synth :dsaw
  xs = (ring 60, 59)
  s1 = (knit :r, 2, [60,67], 2, :r, 2, 67, 1, :r, 1)
  play s1.look, amp: amp, pan: pan, sustain: 0.1, release: 0.1
  sleep 0.25
end

with_fx :level do
  live_loop :tak do
    tick
    amp = 0.5 #0.5
    s =  sample :drum_cymbal_closed, amp: amp,
      compress: 0,
      start:0, finish: (ring 0.2, 0.1, 0.9, 0).look,
      pan: rrand(0.7, -0.7)
    sleep 0.25
  end
  
  live_loop :kick do
    tick
    amp_1 = 1
    amp_2 = 1
    sample :bd_808, cutoff: 130, amp: amp_1,
      compress: 1, pre_amp: 30, slope_above: 0.7, slope_below: 3 if (ring true, true).look
    sample :elec_hi_snare, amp: amp_2 if (ring false, true).look
    sleep 1
  end
  
  live_loop :fast do
    amp = 0
    sample :elec_bong, amp: amp, pan: -0.5, slice: 4, num_slices: 4 if one_in(3)
    sleep 0.25
  end
  
  live_loop :fss do
    amp = 0.8 #0.6
    sample :loop_3d_printer, amp: amp, slice: 0.2, pan: 0.5
    sleep 8
  end
  
  live_loop :sm2 do
    amp = 0.5
    sleep 1.25
    with_fx :echo, decay: 0.5, phase: 0.25, mix: 1 do
      with_fx :ring_mod do
        sample :loop_industrial, amp: amp, rate: 0.75, start: 0.6, finish: 0.67
      end
    end
    sleep 2.75
  end
  
  live_loop :myfm do
    tick
    amp = 1
    with_fx :slicer, mix: 0.9, phase: 0.25, phase_offset: 0.0, pulse_width: 0.25, smooth: 0.1, wave: 1 do
      with_swing shift: 0 do #0.175 do
        s1 = (knit :a2, 16, :a2, 16, :d2, 16, :f2, 32)
        s2 = (knit :r, 16,  :e3, 16, :a3, 16, :f3, 32)
        play_fm (s1).look, amp
        play_fm (s2).look, amp
      end
    end
    sleep 1
  end
  
  live_loop :myfm2 do
    tick
    amp = 0.4
    with_fx :reverb, mix: 0.9, damp: 0.9, room: 0.9 do
      with_synth :mod_fm do
        s3 = (knit :b4, 4, :r, 6 , :a4, 2,  :g4, 2, :e4, 2)
        s4 = (knit :r, 10, :e4, 2,  :g4, 2, :e5, 2)
        s5 = (knit :c5, 8, :r, 2, :f4, 2,  :a4, 2, :f4, 2)
        s = play (s3 + s4 + s5 + s5 + s5).look, amp: amp,
          pan: -0.4,
          sustain: 1,
          release: 1,
          mod_range: 0.25,
          mod_phase: 0.5,
          cutoff: 120,
          divisor: 0.4,
          depth: 1
        sleep 0.7
        control s, mod_phase: 0.25, mod_range: 2
        sleep 0.3
      end
    end
  end
  
end

define :play_fm do |n, amp|
  with_synth :fm do
    am = amp
    pn =-0.4
    
    a = 0
    al = 1
    d = 0.25
    dl = 0.25
    s = 0.5
    sl = 0.75
    r = 0.175
    
    ec = 1
    
    co = 100
    
    dv = 1 #(range 0, 3, 0.1).tick
    dp = (range 0, 16, 1).look
    use_synth_defaults pan: pn, amp: am, attack: a, attack_level: al,
      decay: d, decay_level: dl,
      sustain: s, sustain_level: sl,
      release: r,
      env_curve: ec,
      cutoff: co,
      divisor: dv,
      depth: dp
    play n
  end
end


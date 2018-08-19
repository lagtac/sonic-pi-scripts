# Welcome to Sonic Pi v3.1
bpm = 120

live_loop :a do
  stop
  tick
  rphase = rdist(1, 0.5).abs
  print rphase
  rrelease = rrand(0.01,1)
  
  with_fx :panslicer, mix: 1, wave: 3, phase: rphase, phase_offset: 0.3 do
    with_fx :gverb, mix: 0.3, dry: 0.3, pre_amp: 1, spread: 1, damp: 0.7,
    room: 60, release: 10, ref_level: 0.7 do
      use_bpm bpm
      a = 0.01
      al = 1
      d = 0
      dl = 0.5
      s = 1
      sl = 1
      r = 3
      
      use_synth choose([:pluck])
      rpan = rrand(-1, 1)
      rsleep = choose([0.25, 0.5, 0.75, 1, 1.25])
      amp = rrand(0.5, 0.7)
      use_synth_defaults amp: amp, pan: rpan,
        attack: a, attack_level: al,
        decay: d, decay_level: dl,
        sustain: s, sustain_level: sl,
        release: r
      
      #rp = rrand(30, 460)
      #play hz_to_midi(rp)
      #sleep rsleep / 2
      play (chord :f, '7sus2').pick
      sleep rsleep
    end
  end
end

live_loop :b do
  #stop
  tick
  use_bpm 10
  with_fx :gverb, amp: choose([0.5, 0.75, 0.9]), damp: 0.5, ref_level: 0.5, mix: 0.2, dry: 0.25,room: 80,
  release: 10, spread: 1 do
    with_fx :slicer, phase: 0.01, mix: choose([0, 0.175, 0.25]), smooth: 0.24, wave: 3, invert_wave: 0 do
      use_synth :bnoise
      use_synth_defaults amp: 0.5, pan: 0.4,
        attack: choose([0.2, 0.25]), attack_level: 0.7,
        decay: 0.25, decay_level: 0.25,
        sustain: 0.25, sustain_level: 0.5,
        release: 0.5,
        env_curve: 3,
        cutoff: (ring 125, 128, 130).look,
        res: choose([0.5])
      play 1
      sleep choose([1.1, 1.3, 1.5])
    end
  end
end

# apokofto

bpm = 120

live_loop :guitarr do
  #stop
  tick
  
  with_fx :panslicer, mix: 1, wave: 3, phase: 2, phase_offset: 0.3 do
    with_fx :gverb, mix: 0.3, dry: 0.3, pre_amp: 1, spread: 1, damp: 0.7,
    room: 60, release: 10, ref_level: 0.7 do
      use_bpm bpm
      a = 0.01
      al = 1
      d = 0
      dl = 0.5
      s = 1
      sl = 1
      r = rrand(1, 10)
      
      use_synth :pluck
      
      amp = rrand(0.5, 0.7)
      use_synth_defaults amp: 1, pan: 1,
        attack: a, attack_level: al,
        decay: d, decay_level: dl,
        sustain: s, sustain_level: sl,
        release: r
      4.times do
        play [(chord :f4, '7sus2').pick([1, 2].choose), (chord :c3, :m9).pick(1)].choose
        sleep [1, 5, 7].choose
      end
    end
  end
end

live_loop :waves do
  #stop
  tick
  use_bpm 10
  with_fx :gverb, amp: choose([0.5, 0.75]), damp: 0.5, ref_level: 0.5, mix: 0.2, dry: 0.25,room: 80,
  release: 10, spread: 1 do
    with_fx :slicer, phase: 0.01, mix: choose([0, 0.175, 0.25]), smooth: 0.24, wave: 3, invert_wave: 0 do
      use_synth :bnoise
      use_synth_defaults amp: 0.5, pan: 0.4,
        attack: [0.2, 0.25].choose, attack_level: [0.7, 0.3].choose,
        decay: 0.25, decay_level: 0.25,
        sustain: 0.25, sustain_level: 0.5,
        release: [0.5, 0.7].choose,
        env_curve: 3,
        cutoff: (ring 125, 128, 130).look,
        res: [0.6, 0.7].choose
      4.times do
        play 1
        sleep [1.1, 1.5, 1.7, 2].choose
      end
    end
  end
end

live_loop :voices do
  sp = sample_paths '~/personal/audio/samples/voices/'
  si = rrand(0, 34).to_i
  with_fx :bpf, center: rrand(80, 95), res: 0.1 do
    sample sp[si], pan: rrand(-1, -0.5)
    sleep rrand(0.3, 3)
  end
end






















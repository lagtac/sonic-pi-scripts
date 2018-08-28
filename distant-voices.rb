#sample_free_all
sp = sample_paths "~/Personal/audio/samples/voices"
print sp.length

#sample_free_all
live_loop :l do
  tick
  use_bpm 60
  with_fx :gverb, pre_amp: 2, damp: 0.5, room: 100, ref_level: 0.1, release: 3, dry: 0.5, mix: 1 do
    with_fx :hpf, cutoff: 80, mix: 1 do
      16.times do
        si = (range 0, 34).choose.to_i
        print si
        s = sp[si]
        dur = [0.1, 0.3, 0.5].choose
        #sample2 s, dur, 0, 1
        start = rrand(0, 1 - dur)
        fin = start + dur
        sample s, amp: 1, norm: 0, pan: 1,
          rate: 1, pitch: p,
          attack: 0.1, release: 0.1, start: start, finish: fin
        sleep [0.1, 3, 5].choose
      end
    end
  end
end

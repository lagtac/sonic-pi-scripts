# jsbarb-0

#use_debug false
use_bpm 113
root = :a4

comment do
  i = (ps root, :ionian)
  ii = (ps root, :dorian)
  iii = (ps root, :phrygian)
  iv = (ps root, :lydian)
  v = (ps root, :mixolydian)
  vi = (ps root, :aeolian)
  vi = (ps root, :locrian)
end

live_loop :x do
  use_synth :pluck
  use_synth_defaults noise_amp: 0.7, coef: 0.7, max_delay_time: 0.125
  with_fx :reverb, damp: 0.5, room: 1, mix: 0.3 do
    4.times do
      tick
      play (chord_degree :ii, :f3, :ionian, (ring 1,3,5,5,2,1).look), release: 0.5, attack: 0.01, pan: 0.7
      #play (chord :c4, '6', num_octaves: 2, invert: 0).look, pan: -0.7
      sleep 0.25
    end
  end
end

live_loop :b do
  tick
  use_synth :growl
  play (ring :g2, :f2, :c2, :d2).stretch(4).look, attack: 0, amp: 1
  sleep 1.5
end

live_loop :l do
  tick
  use_synth :dark_ambience
  play (ring :a5, :g5, :d5, :c5).stretch(1).look, amp: 1, attack: 3, sustain: 3, release: 12,
    detune1: 2, detune2: 12, noise: 2, ring: 10, room: 70, reverb_time: 100
  sleep (ring 12).look
end

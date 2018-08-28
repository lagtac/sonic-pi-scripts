# harmonizing with twelve-notes
require 'set'

def note_to_chord(n, p, m)
  # given a note N and position P build a chord in mode M
  r = n - p
  c = (chord r, m, num_octaves: 1).add(n.to_i).to_a.to_set.ring
  #print note_info r
  return c
end
n = :a4
#c1 = note_to_chord(n, 9, 'M')

def note_name(n)
  (note_info n).to_s.split(':')[3].chop
end

def print_notes (s)
  return s.map do |n|
    note_name n
  end
end

s1 = (scale :c, :major, num_octaves: 1)
s2 = (scale :c2, :chromatic).butlast
# shuffle the chromatic
use_random_seed 4
a2 = s2.shuffle.to_a
# transpose some notes
#use_random_seed 2
s3 = (0..11).map { |i| a2[i] = (if one_in(100) then a2[i]+12 else a2[i] end) }.ring
#stop

use_synth :piano
use_synth_defaults amp: 1, release: 1, vel: 0.2, hard: 0.5
use_bpm 60

print print_notes s3
#stop

with_fx :reverb do
  live_loop :a do
    tick
    sample :drum_cymbal_pedal, pan: 0.3
    12.times do
      tick(:t0)
      play s3.look(:t0) + 12, pan: 0.2, amp: 1
      c = note_to_chord(s3.look(:t0), (ring 2).look(:t0), :min) + 24
      print c
      play c, pan: -0.2,
        amp: (knit 2, 1, 0, 3).look(:t0), release: 2
      sleep 0.5
    end
  end
  
  r = (knit 0.5, 2, 0.25, 4, 1, 2)
  
  live_loop :b do
    12.times do
      #stop
      tick
      sample :drum_snare_soft, pan: 0.2
      play s3.look, pan: -0.2, amp: 0
      sleep r.look
    end
  end
  
  live_loop :c do
    tick
    use_synth :pluck
    n = s3.look
    cn = chord_names
    #print cn.look
    play note_to_chord(n, 0, cn.look) + 12, pan: -0.3, amp: 0, release: 2
    sleep r.look
  end
  
end



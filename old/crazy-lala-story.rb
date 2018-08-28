use_bpm 80

with_fx :gverb, mix: 0.1, room: 15  do
  
  live_loop :chords do
    use_synth :blade
    play (chord :a3, ['+5', :sus4, '6'].ring.tick , num_octaves: 3,
    invert: choose([0,1,2])),
      release: 0.1, pan: 0.5, amp: 1
    sleep 1
    
  end
  
  live_loop :dulci do
    use_synth :pluck
    tick
    e = play (chord :a2, :major7, num_octaves: 2, invert: 1).choose, amp: 0.01, pan: 0,
      release: choose(line(0.01,1, steps:10)), coef: rrand(0.01,0.5)
    control e, amp: (line(0.01, 0.25, steps:100) + line(0.25, 0.01, steps:100)).look
    control e, pan: (line(-1, 1, steps:100) + line(1, -1, steps:100)).look
    
    sleep choose [0.25, 0.5, 0.25]
  end
  
  live_loop :d1 do
    sample :perc_snap, amp: 0.2, rate: 1, pan: 0.5
    sleep 0.01
    sample :perc_snap, amp: 0.2, rate: 0.9, pan: 0.4
    sleep 1.99
    with_fx :vowel do
      sample :bd_pure, amp: 0.5, rate: rrand(5, 10) , pan: -0.5
      sleep 2
    end
  end
  
  live_loop :bass do
    use_synth :tb303
    tick
    b = play :a1, amp: 0.1, res: 0.4, wave: 2, attack: 0.01, release: 0.2
    control b, note: (scale :a1, :major_pentatonic, num_octaves:1).look
    sleep (choose [2, 0.5])
  end
  
end
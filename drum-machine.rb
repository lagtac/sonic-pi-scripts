# drum-machine

use_bpm 120

def beats(pat)
  pat.delete(' ').split('').map(&:to_i).ring
end

patt = {
  :bd_klub         => "9--5 --5- ---- -3-- 9--- ---- 9--- ----",
  :drum_snare_soft => "---- ---3 9--- ---- ---- ---- --33 9---",
  :perc_snap2      => "9--- --11 11-- ---- 5--- 5-11 11-- 9---",
  :elec_flip       => "--5- ---- --5- --5- --5- ---- --5- --5-",
  # :bd_boom => "9-3--"
}

live_loop :main do
  tick  #(step: [0,1,1,1,1,1,2].choose)  # change step of tick randomly for nice effect
  patt.each{ |key, val|  sample key, amp: beats(val).look / 10.0 }
  sleep 0.25
end
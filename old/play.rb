use_random_seed 41
use_synth :tb303
loop do
  play rrand(67, 89), cutoff: rrand(60, 100)
  sleep 0.5
end

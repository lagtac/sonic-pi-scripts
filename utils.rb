
def note_to_chord(n, p, m)
  # given a note N and position P build a chord in mode M
  r = n - p
  c = (chord r, m, num_octaves: 1).add(n.to_i).to_a.to_set.ring
  #print note_info r
  return c
end

def note_name(n)
  (note_info n).to_s.split(':')[3].chop
end

def print_notes (s)
  return s.map do |n|
    note_name n
  end
end

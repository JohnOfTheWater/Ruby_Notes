
def print_notes(notes)
  i = notes.length
  k = 0
  i.times do
    print "|Title: #{notes[k].title.capitalize!}   |Tag: #{notes[k].tag}  |User: #{notes[k].user_name.capitalize!}" + "\n"
    print "============================================================" + "\n"
    line_fixer(notes[k].body)
    print "|__________________________________________________________/" + "\n"
    puts "\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s"
    k += 1
  end
end

def print_note(note)
  print "|Title: #{note[0].capitalize!}  Tag: #{note[1]}  |User: #{note[2].capitalize!}" + "\n"
  print "==============================================================" + "\n"
  line_fixer(note[3])
  print "|____________________________________________________________/" + "\n"
  puts "\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s"
end

def print_body(note)
  print "|Title: #{note[0].capitalize!}  |Tag: #{note[1]}  |User: #{note[2]}" + "\n"
  print "\\=============================================================" + "\n"
  line_fixer(note[3])
end

def line_fixer(str)
  if str == nil
    return x = "empty"
  else
    l = str.length
    i = (l/60.to_i)+1
    k = 0
    i.times do
      puts str.slice(0+k, 60)
      k += 60
    end
  end
end

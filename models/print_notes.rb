
def print_notes(notes)
  i = notes.length
  k = 0
  i.times do
    print "|Title: #{notes[k].title.capitalize!}             Tag: #{notes[k].tag}" + "\n"
    print "=====================================================" + "\n"
    print "Stuff stuff stuff stuff stuff stuff stuff stuff stuff" + "\n"
    print "Stuff stuff stuff stuff stuff stuff stuff stuff stuff" + "\n"
    print "|User: #{notes[k].user_name.capitalize!}|" + "\n"
    print "|___________________________________________________/" + "\n"
    puts "\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s"
    k += 1
  end
end

def print_note(note)
  print "|Title: #{note[0].capitalize!}             Tag: #{note[1]}" + "\n"
  print "=====================================================" + "\n"
  print "Stuff stuff stuff stuff stuff stuff stuff stuff stuff" + "\n"
  print "Stuff stuff stuff stuff stuff stuff stuff stuff stuff" + "\n"
  print "|User: #{note[2].capitalize!}|" + "\n"
  print "|___________________________________________________/" + "\n"
  puts "\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s"
end

def print_body(note)
  print "|Title: #{note[0].capitalize!}             Tag: #{note[1]}" + "\n"
  print "=====================================================" + "\n"
  print "#{note[3]}"
end

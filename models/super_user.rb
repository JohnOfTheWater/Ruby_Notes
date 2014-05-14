$LOAD_PATH << "models"

require 'user'
require 'note'

def super_user_menu
<<EOS
=============================================================================
|                                                                           |
|                                        ##########################         |
|                                     .*##*:*####***:::**###*:######*.      |
|                                    *##: .###*            *######:,##*     |
|                                  *##:  :####:             *####*.  :##:   |
|                                   *##,:########**********:,       :##:    |
|1.==> Back                          .#########################*,  *#*      |
|                                      *#########################*##:       |
|2.==> Delete User                       *##,        ..,,::**#####:         |
|                                         ,##*,*****,        *##*           |
|3.==> Delete Note                          *#########*########:            |
|                                             *##*:*******###*              |
|4.==> Delete all Notes                        .##*.    ,##*                |
|                                                :##*  *##,                 |
|5.==> Show all Notes                              *####:                   |
|                                                    :,                     |
|6.==> Tabula Rasa                                                          |
|                                                            Ruby_Notes_1.1 |
===========================================================================/
EOS
end

def password(user)
  puts "Password:"
  pswd = gets.chomp
  return unless pswd
  if pswd == "pretty please"
    super_user(user)
  else
    puts "Wrong Password!"
    what_now(user)
  end
end

def super_user(user)
  puts super_user_menu
  input = gets.chomp
  return unless input
  if input == "1"
    what_now(user)
  elsif input == "2"
    delete_user(user)
  elsif input == "3"
    super_delete_note(user)
  elsif input == "4"
    super_delete_notes(user)
  elsif input == "5"
    super_show_notes(user)
  elsif input == "6"
    tabula_rasa(user)
  else
    puts "'#{input}' is not a valid selection."
    super_user(user)
  end
end

def delete_user(user)
  puts "Enter the name of the User you want to destroy"
  input = gets.chomp
  return unless input
  User.destroy_user(input)
  puts "The User named #{input} has been annihilated"
  super_user(user)
end

def super_delete_note(user)
  puts "What is the title of the note you want to destroy?"
  input = gets.chomp
  return unless input
  Note.super_destroy_by_title(input)
  puts "The Note #{input} has been disintegrated"
  super_user(user)
end

def super_delete_notes(user)
  Note.super_destroy_all
  puts "All Notes have been turned to ashes"
  super_user(user)
end

def super_show_notes(user)
  notes = Note.super_find_all
  print_notes(notes)
  puts "press enter to continue"
  input = gets.chomp
  return unless input
  super_user(user)
end

def tabula_rasa(user)
  Note.super_destroy_all
  User.super_destroy_all
  puts "You just succesfully dropped a nuclear bomb on your database"
  super_user(user)
end

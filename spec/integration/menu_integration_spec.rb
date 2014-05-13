require_relative '../spec_helper'

describe "Start Menu Integration" do
  let(:menu_text) do
<<EOS
====================================================================================================================================================
|               .__                                  __                       ___.          _______          __                                    |
|__  _  __ ____ |  |   ____  ____   _____   ____   _/  |_  ____   _______ __ _\\_ |__ ___.__.\\      \\   _____/  |_  ____   ______                   |
|\\ \\/ \\/ // __ \\|  | _/ ___\\/  _ \\ /     \\_/ __ \\  \\   __\\/  _ \\  \\_  __ \\  |  \\ __ <   |  |/   |   \\ /  _ \\   __\\/ __ \\ /  ___/                   |
| \\     /\\  ___/|  |_\\  \\__(  <_> )  Y Y  \\  ___/   |  | (  <_> )  |  | \\/  |  / \\_\\ \\___  /    |    (  <_> )  | \\  ___/ \\___ \\                    |
|  \\/\\_/  \\___  >____/\\___  >____/|__|_|  /\\___  >  |__|  \\____/   |__|  |____/|___  / ____\\____|__  /\\____/|__|  \\___  >____  >                   |
|             \\/          \\/            \\/     \\/                                  \\/\\/            \\/                 \\/     \\/                    |
|                                                                                                                                                  |
|                                                                                                                                                  |
|Welcome to Ruby_Notes!                                                                                                                            |
|What do you want to do?                                                                                                                           |
|                                                                                                                                                  |
|1.==> Register as User                                                                                                                            |
|                                                                                                                                                  |
|2.==> Create a Note                                                                                                                               |
|                                                                                                                                                  |
|3.==> Modify a Note                                                                                                                               |
|                                                                                                                                                  |
|4.==> Search                                                                                                                                      |
|                                                                                                                                                  |
|5.==> Count all my Notes                                                                                                                          |
|                                                                                                                                   Ruby_Notes_1.1 |
|=================================================================================================================================================/
EOS
  end
  context "the menu displays on startup" do
    let(:shell_output){ run_ruby_notes_with_input() }
    it "should print the menu" do
      shell_output.should include(menu_text)
    end
  end

  context "the user selects 1 from start menu" do
    let(:shell_output){ run_ruby_notes_with_input("1") }
    it "should print the next menu" do
      shell_output.should include("Please enter a User-Name:")
    end
  end

  context "the user selects 2 from start menu" do
    before do
      user1 = User.new("Ryu")
      user1.save
    end
    let(:shell_output){ run_ruby_notes_with_input("2") }
    it "should ask for the note title" do
      shell_output.should include("Not so fast!")
    end
  end
  context "the user selects 3 from start menu" do
    before do
      user1 = User.new("Ryu")
      user1.save
      user2 = User.new("Ken")
      user2.save
      user3 = User.new("Gouki")
      user3.save
    end
    let(:shell_output){ run_ruby_notes_with_input("3") }
    it "should print out the giant question mark" do
      shell_output.should include("Who are you?")
    end
    it "should print out the giant question mark" do
      shell_output.should include("Ruby_Notes_1.1")
    end
    it "should print out the giant question mark" do
      shell_output.should include("jgN")
    end
  end
  context "if the user selects wrong input/number" do
    let(:shell_output){ run_ruby_notes_with_input("4") }
    it "should print menu again" do
      shell_output.should include_in_order("Not so fast!!!", "Who are you?", "Ruby_Notes_1.1")
    end
    it "should include appropriate error message" do
      shell_output.should include("jgN")
    end
  end
  context "if user puts in no input" do
    let(:shell_output){ run_ruby_notes_with_input("6") }
    it "should display the same menu again" do
      shell_output.should include(menu_text, "Sorry buddy, '6' is not a valid selection.")
    end
    it "should return appropriate error message" do
      shell_output.should include("Sorry")
    end
    it "should return appropriate error message" do
      shell_output.should include_in_order("Sorry", "'6'")
    end
  end
  context "if users selects incorrect input, it should allow correct input afterward" do
    before do
      user = User.new("Akuma")
      user.save
    end
    let(:shell_output){ run_ruby_notes_with_input("4", "Akuma") }
    it "should include appropriate menu" do
      shell_output.should include(menu_text, "Who are you?", menu_text, "Welcome back Akuma!")
    end
  end
  context "if user types in incorrect input multiple times, should allow proper input afterward" do
    before do
      user = User.new("Ryu")
      user.save
    end
    let(:shell_output){ run_ruby_notes_with_input("4", "Ryu", "1") }
    it "should print out appropriate menu" do
      shell_output.should include_in_order(menu_text, "Welcome back Ryu", "What kind of search you want to do?","By Title")
    end
  end
end

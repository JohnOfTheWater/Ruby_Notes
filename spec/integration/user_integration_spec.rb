require_relative '../spec_helper'

describe "adding a user (collector)" do
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
  before do
    user = User.new("Ryu")
    user.save
  end
end

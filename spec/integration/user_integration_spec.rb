require_relative '../spec_helper'

describe "adding a user (collector)" do
  let(:menu_text) do
<<EOS
What do you want to do?
1. Add a User
2. Create a Note
3. Modify a Note
4. Search
EOS
  end
  before do
    user = User.new("Ryu")
    user.save
  end
  context "adding a unique user" do
    let!(:output){ run_consumptiv_with_input("1", "Sammy Davis Jr.") }
    it "should print out a confirmation that collector was added" do
      output.should include("Sammy Davis Jr. has been added as a collector.")
    end
    it "should increase the number of collectors" do
      User.count.should == 2
    end
    it "should use the name entered in test" do
      User.last.name.should == "Sammy Davis Jr."
    end
  end


  context "duplicate collector shouldn't be added" do
    let!(:output){ run_consumptiv_with_input("1", "Dean Martin") }
    it "should print error message" do
      output.should include("Dean Martin is already a collector.")
      User.count.should == 1
    end
    it "last collector name should remain the same" do
      User.last.name.should == "Dean Martin"
    end
    it "should ask them to try again" do
      output.should include_in_order(menu_text, "Please enter your name: ", "Dean Martin is already a collector.", "Please enter your name: ")
    end
    context "trying again should save new collector" do
      let!(:output){ run_consumptiv_with_input("1", "Dean Martin", "Don Rickles") }
      it "should save new unique collector" do
        User.last.name.should == "Don Rickles"
      end
      it "should print a success message" do
        output.should include_in_order(menu_text, "Please enter your name: ", "Dean Martin is already a collector.", "Please enter your name: ", "Don Rickles has been added as a collector.")
      end
      it "should increase the user count" do
        User.count.should == 2
      end
    end
  end
  context "entering invalid looking collector name" do
    context "without alphabet characters" do
      let(:output){ run_consumptiv_with_input("1", "6.53") }
      it "should not save the collector" do
        User.count.should == 1
      end
      it "should print an error message" do
        output.should include("'6.53' is not a valid name — must include letters.")
      end
      it "should let them try again" do
        output.should include_in_order(menu_text, "'6.53' is not a valid name — must include letters.")
      end
    end
  end
end

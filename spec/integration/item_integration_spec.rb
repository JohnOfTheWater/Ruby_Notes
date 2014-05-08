require_relative '../spec_helper'

describe "adding an item" do
  let(:menu_text) do
<<EOS
What do you want to do?
1. Add collector
2. Add item
3. Choose existing collector
EOS
  end
  before do
    item = Item.new("The Great Shark Hunt")
    item.save
    item2 = Item.new("War and Peace")
    item2.save
  end
  context "adding a unique item" do
    let!(:output){ run_consumptiv_with_input("2", "On The Road") }
    it "should print a confirmation message" do
      output.should include("'On The Road' has been added as an item.")
    end
    it "should increase the items count" do
      Item.count.should == 3
    end
    it "should use the title entered, which should be last" do
      Item.last.title.should == "On The Road"
    end
  end
  context "shouldn't be able to add duplicate item" do
    let!(:output){ run_consumptiv_with_input("2", "The Great Shark Hunt") }
    it "should print error message" do
      output.should include("'The Great Shark Hunt' is already an item.")
    end
    it "should keep same last unique item" do
      Item.last.title.should == "War and Peace"
    end
    it "should ask them to try again" do
      output.should include_in_order(menu_text, "Please enter a title: ", "'The Great Shark Hunt' is already an item.", "Please enter a title: ")
    end
  end
  context "trying again should save new item" do
    let!(:output){ run_consumptiv_with_input("2", "The Great Shark Hunt", "Moby Dick") }
    it "should save new unique collector" do
      Item.last.title.should == "Moby Dick"
    end
    it "should print a success message" do
      output.should include_in_order(menu_text, "Please enter a title: ", "'The Great Shark Hunt' is already an item.", "Please enter a title: ", "'Moby Dick' has been added as an item.")
    end
    it "should increase the item count" do
      Item.count.should == 3
    end
  end
  context "entering invalid looking collector name" do
    context "without alphabet characters" do
      let(:output){ run_consumptiv_with_input("2", "6.53") }
      it "should not save the item" do
        Item.count.should == 2
      end
      it "should print an error message" do
        output.should include("'6.53' is not a valid title — must include letters.", "Please enter a title: ")
      end
      it "should let them try again" do
        output.should include_in_order(menu_text, "'6.53' is not a valid title — must include letters.")
      end
    end
  end
end

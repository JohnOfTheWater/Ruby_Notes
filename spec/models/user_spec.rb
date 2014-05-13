require_relative '../spec_helper'

describe User do
  context ".all" do
    context "with no people in the database" do
      it "should return an empty array" do
        User.all.should == []
      end
      it "should not return an array with stuff" do
        User.all.should_not == [["stuff"],["stuff"],["stuff"]]
      end
    end
    context "with multiple people in the database" do
      let!(:foo){ User.create("Foo") }
      let!(:bar){ User.create("Bar") }
      let!(:baz){ User.create("Baz") }
      let!(:grille){ User.create("Grille") }
      it "should return all of the people" do
        user_attrs = User.all.map{ |user| [user.name,user.id] }
        user_attrs.should == [["Foo", foo.id],
                                ["Bar", bar.id],
                                ["Baz", baz.id],
                                ["Grille", grille.id]]
      end
    end
  end

  context ".count" do
    context "with no people in the database" do
      it "should return 0" do
        User.count.should == 0
      end
    end
    context "with multiple people in the database" do
      before do
        User.new("Foo").save
        User.new("Bar").save
        User.new("Baz").save
      end
      it "should return the correct count" do
        User.count.should == 3
      end
      it "should return the correct count" do
        User.count.should_not == 5
      end
    end
  end

  context ".find_by_name" do
    context "with no people in the database" do
      it "should return 0" do
        User.find_by_name("Foo").should be_nil
      end
    end
    context "with user by that name in the database" do
      let(:foo){ User.create("Foo") }
      let(:baz){ User.create("Baz") }
      before do
        foo
        baz
        User.new("Bar").save
        User.new("Baz").save
        User.new("Grille").save
      end
      it "should return the user with that name" do
        User.find_by_name("Foo").id.should == foo.id
      end
      it "should return the user with that name" do
        User.find_by_name("Foo").id.should_not == baz.id
      end
      it "should do the same for baz" do
        User.find_by_name("Baz").id.should == baz.id
      end
      it "should return the user with that name" do
        User.find_by_name("Foo").name.should == foo.name
      end
      it "should return the user with that name" do
        User.find_by_name("Foo").name.should_not == baz.name
      end
    end
  end

  context ".last" do
    context "with no people in the database" do
      it "should return nil" do
        User.last.should be_nil
      end
    end
    context "with multiple people in the database" do
      before do
        User.new("Ryu").save
        User.new("Ken").save
        User.new("Akuma").save
        User.new("Gouki").save
      end
      it "should return the last one inserted" do
        User.last.name.should == "Gouki"
      end
      it "should not be the last one inserted" do
        User.last.name.should_not == "Ken"
      end
      it "should not be the last one inserted" do
        User.last.name.should_not == "Ryu"
      end
      it "should not be the last one inserted" do
        User.last.name.should_not == "Akuma"
      end
    end
  end

  context "#new" do
    let(:user) { User.new("Ryu") }
    it "should store the name" do
      user.name.should == "Ryu"
    end
  end

  context "#create" do
    let(:result){ Environment.database_connection.execute("Select * from users") }
    let(:user){ User.create("Ryu") }
    context "with an owned item" do
      before do
        User.any_instance.stub(:valid?){ true }
        user
      end
      it "should record the new id" do
        user.id.should == result[0]["id"]
      end
      it "should only save one row to the database" do
        result.count.should == 1
      end
      it "should actually save it to the database" do
        result[0]["name"].should == "Ryu"
      end
      it "should actually save it to the database" do
        result[0]["name"].should_not == "Ken"
      end
    end
    context "with an invalid item" do
      before do
        User.any_instance.stub(:valid?){ false }
        user
      end
      it "should not save a new injury" do
        result.count.should == 0
      end
      it "should not save a new injury" do
        result.count.should_not == 10
      end
    end
   end

  context "#save" do
    let(:result){ Environment.database_connection.execute("Select * from users") }
    let(:user){ User.new("Ryu") }
    let(:user1){ User.new("Ken") }
    let(:user2){ User.new("Akuma") }
    context "with a valid user" do
      before do
        user.stub(:valid?){ true }
      end
      it "should only save one row to the database" do
        user.save
        result.count.should == 1
      end
      it "should only save one row to the database" do
        user.save
        user1.save
        result.count.should == 2
      end
      it "should only save one row to the database" do
        user.save
        user1.save
        user2.save
        result.count.should == 3
      end
      it "should actually save it to the database" do
        user.save
        user1.save
        result[0]["name"].should == "Ryu"
        result[1]["name"].should == "Ken"
      end
      it "should record the new id" do
        user.save
        user.id.should == result[0]["id"]
      end
      context "with an invalid user" do
        before do
          user.stub(:valid?){ false }
        end
        it "should not save a new user" do
          user.save
          result.count.should == 0
        end
        it "should not save a new user" do
          user.save
          result.count.should_not == 3
        end
      end
    end
  end

  context "#valid?" do
    let(:result){ Environment. database_connection.execute("Select name from users") }
    context "after fixing the errors" do
      let(:user){ User.new"888" }
      it "should return true" do
        user.valid?.should be_false
        user.name = "Ryu"
        user.valid?.should be_true
      end
    end
    context "with a unique name" do
      let(:user){ User.new("Ken") }
      it "should return true" do
        user.valid?.should be_true
      end
      it "should return false" do
        user.valid?.should_not be_false
      end
    end
    context "with an invalid name" do
      let(:user){ User.new("725") }
      let(:user1){ User.new("AA5") }
      it "should return false" do
        user.valid?.should be_false
      end
      it "should return false" do
        user1.valid?.should be_true
      end
      it "should save the error messages" do
        user.valid?
        user.errors.first.should == "'725' is not a valid name — must include letters."
      end
    end
    context "with a duplicate name" do
      let(:name){ "Susan" }
      let(:name2){ "Penny" }
      let(:user){ User.new(name) }
      let(:user2){ User.new(name2) }
      before do
        User.new(name).save
        User.new(name2).save
      end
      it "should return false" do
        user.valid?.should be_false
      end
      it "should return false" do
        user2.valid?.should be_false
      end
      it "should save the error messages" do
        user.valid?
        user.errors.first.should == "#{name} is already a user."
      end
      it "should save the error messages" do
        user2.valid?
        user2.errors.first.should == "#{name2} is already a user."
      end
    end
  end
end

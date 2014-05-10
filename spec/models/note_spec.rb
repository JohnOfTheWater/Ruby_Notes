require_relative '../spec_helper'

describe Note do
  context ".all" do
    context "with no notes in the database" do
      it "should return an empty array" do
        Note.all.should == []
      end
    end
    context "with multiple notes in the database" do
      let!(:xxx){ Note.create("ciao", "miao", "bau") }
      let!(:bar){ Note.create("ciao", "miao", "bau") }
      let!(:baz){ Note.create("ciao", "miao", "bau") }
      it "should return all of the notes" do
        note_attrs = Note.all.map{ |note| [note.title,note.id] }
        note_attrs.should == [["ciao", xxx.id],
                                ["ciao", bar.id],
                                ["ciao", baz.id]]
      end
    end
  end

  context ".count" do
    context "with no notes in the database" do
      it "should return 0" do
        Note.count.should == 0
      end
    end
    context "with multiple notes in the database" do
      before do
        Note.new("ciao", "miao", "bau").save
        Note.new("ciao", "miao", "bau").save
        Note.new("ciao", "miao", "bau").save
      end
      it "should return the correct count" do
        Note.count.should == 3
      end
    end
  end

  context ".find_by_title" do
    context "with no notes in the database" do
      it "should return 0" do
        Note.find_by_title("Foo").should be_nil
      end
    end
    context "with a note by that title in the database" do
      let(:foo){ Note.create("Foo", "miao", "bau") }
      let(:baz){ Note.create("Baz", "miao", "bau") }
      before do
        foo
        baz
        Note.new("Bar", "xxx", "yyy").save
        Note.new("Baz", "miao", "bau").save
        Note.new("Grille", "ccc", "vvv").save
      end
      it "should return the note with that title" do
        Note.find_by_title("Foo").id.should == foo.id
      end
      it "should do the same for baz" do
        Note.find_by_title("Baz").id.should == baz.id
      end
      it "should return the note with that title" do
        Note.find_by_title("Foo").title.should == foo.title
      end
    end
  end

  context ".last" do
    context "with no notes in the database" do
      it "should return nil" do
        Note.last.should be_nil
      end
    end
    context "with multiple notes in the database" do
      before do
        Note.new("Ryu", "xxx", "aaa").save
        Note.new("Ken", "xxx", "aaa").save
        Note.new("Akuma", "xxx", "aaa").save
        Note.new("Gouki", "xxx", "aaa").save
      end
      it "should return the last one inserted" do
        Note.last.title.should == "Gouki"
      end
    end
  end

  context "#new" do
    let(:note) { Note.new("Ryu", "xxx", "aaa") }
    it "should store the title" do
      note.title.should == "Ryu"
    end
  end
end

require_relative '../spec_helper'

describe Note do
  context ".all" do
    context "with no notes in the database" do
      it "should return an empty array" do
        Note.all.should == []
      end
    end
    context "with multiple notes in the database" do
      let!(:xxx){ Note.create("ciao") }
      let!(:bar){ Note.create("Bar") }
      let!(:baz){ Note.create("Baz") }
      let!(:grille){ Note.create("Grille") }
      it "should return all of the notes" do
        note_attrs = Note.all.map{ |note| [note.title,note.id] }
        note_attrs.should == [["ciao", xxx.id],
                                ["Bar", bar.id],
                                ["Baz", baz.id],
                                ["Grille", grille.id]]
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
        Note.new("Foo").save
        Note.new("Bar").save
        Note.new("Baz").save
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
      let(:foo){ Note.create("Foo") }
      let(:baz){ Note.create("Baz") }
      before do
        foo
        baz
        Note.new("Bar").save
        Note.new("Baz").save
        Note.new("Grille").save
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
        Note.new("Ryu").save
        Note.new("Ken").save
        Note.new("Akuma").save
        Note.new("Gouki").save
      end
      it "should return the last one inserted" do
        Note.last.title.should == "Gouki"
      end
    end
  end

  context "#new" do
    let(:note) { Note.new("Ryu") }
    it "should store the title" do
      note.title.should == "Ryu"
    end
  end
end

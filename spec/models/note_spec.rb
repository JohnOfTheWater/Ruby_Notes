require_relative '../spec_helper'

describe Note do
  context ".all" do
    context "with no notes in the database" do
      it "should return an empty array" do
        Note.all.should == []
      end
    end
    context "with multiple notes in the database" do
      let!(:xxx){ Note.create("ciao", "miao", "bau", "frau") }
      let!(:bar){ Note.create("ciao", "miao", "bau", "frau") }
      let!(:baz){ Note.create("ciao", "miao", "bau", "frau") }
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
        Note.new("ciao", "miao", "bau", "frau").save
        Note.new("ciao", "miao", "bau", "frau").save
        Note.new("ciao", "miao", "bau", "frau").save
      end
      it "should return the correct count" do
        Note.count.should == 3
      end
    end
  end

  context ".find_all" do
    context "with no notes in the database" do
      it "should return 0" do
        Note.find_all("Foo").should == []
      end
    end
    context "with some notes by in the database" do
      let(:foo){ Note.create("Foo", "miao", "bau", "frau") }
      let(:baz){ Note.create("Baz", "miao", "bau", "frau") }
      before do
        foo
        baz
        Note.new("Bar", "xxx", "yyy", "frau").save
        Note.new("Baz", "miao", "bau", "frau").save
        Note.new("Grille", "ccc", "vvv", "frau").save
      end
      it "should return the note with that title" do
        Note.find_all("bau").length.should == 3
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
      let(:foo){ Note.create("Foo", "miao", "bau", "frau") }
      let(:baz){ Note.create("Baz", "miao", "bau", "frau") }
      before do
        foo
        baz
        Note.new("Bar", "xxx", "yyy", "frau").save
        Note.new("Baz", "miao", "bau", "frau").save
        Note.new("Grille", "ccc", "vvv", "frau").save
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

  context ".find_by_title_user" do
    context "with no notes in the database" do
      it "should return 0" do
        Note.find_by_title_user("Foo", "stuff").should be_nil
      end
    end
    context "with a note by that title in the database" do
      let(:foo){ Note.create("Foo", "miao", "bau", "frau") }
      let(:baz){ Note.create("Baz", "miao", "bau", "frau") }
      before do
        foo
        baz
        Note.new("Bar", "xxx", "yyy", "frau").save
        Note.new("Baz", "miao", "bau", "frau").save
        Note.new("Grille", "ccc", "vvv", "frau").save
      end
      it "should return the note with that title" do
        Note.find_by_title_user("Foo", "bau").id.should == foo.id
      end
      it "should do the same for baz" do
        Note.find_by_title_user("Baz", "bau").id.should == baz.id
      end
      it "should return the note with that title" do
        Note.find_by_title_user("Foo", "bau").title.should == foo.title
      end
    end
  end

  context ".find_by_tag" do
    context "with some notes in the database" do
      before do
        Note.new("Bar", "xxx", "yyy", "frau").save
        Note.new("Rol", "xxx", "yyy", "miao").save
        Note.new("Baz", "miao", "bau", "frau").save
        Note.new("Grille", "ccc", "vvv", "frau").save
      end
      it "should return 2" do
        Note.find_by_tag("xxx", "yyy").length.should == 2
      end
      it "should return 1" do
        Note.find_by_tag("miao", "bau").length.should == 1
      end
      it "should return 1" do
        Note.find_by_tag("ccc", "vvv").length.should == 1
      end
    end
  end

  context ".update" do
    context "after updating the body on a note" do
      before do
        Note.new("Bar", "xxx", "yyy", "frau").save
        Note.new("Rol", "xxx", "yyy", "miao").save
        Note.new("Baz", "miao", "bau", "frau").save
        Note.new("Grille", "ccc", "vvv", "").save
      end
      #it "should return 2" do
      #  Note.update("yyy", "Bar", "bluher")[3].should == "frau bluher"
      #end
      it "should return 1" do
        Note.find_by_tag("miao", "bau").length.should == 1
      end
      it "should return 1" do
        Note.find_by_tag("ccc", "vvv").length.should == 1
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
        Note.new("Ryu", "xxx", "aaa", "frau").save
        Note.new("Ken", "xxx", "aaa", "frau").save
        Note.new("Akuma", "xxx", "aaa", "frau").save
        Note.new("Gouki", "xxx", "aaa", "frau").save
      end
      it "should return the last one inserted" do
        Note.last.title.should == "Gouki"
      end
      it "should return the last one inserted" do
        Note.last.tag.should == "xxx"
      end
      it "should return the last one inserted" do
        Note.last.user_name.should == "aaa"
      end
      it "should return the last one inserted" do
        Note.last.body.should == "frau"
      end
    end
  end

  context "#new" do
    let(:note) { Note.new("Ryu", "xxx", "aaa", "frau") }
    it "should store the title" do
      note.title.should == "Ryu"
    end
    it "should store the title" do
      note.tag.should == "xxx"
    end
    it "should store the title" do
      note.user_name.should == "aaa"
    end
    it "should store the title" do
      note.body.should == "frau"
    end
  end
end

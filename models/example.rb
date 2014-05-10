class Note
  attr_reader :title, :body, :tag, , user_name:id

  def initialize(title, body, tag, user_name)
    @title = title
    @body = body
    @tag = tag
    @user_name = user_name
  end


  def save
    statement = "Insert into notes (title, body, tag, user_name) values (?,?,?,?);"
    environment = Database.environment
    db = Database.new('db/ruby_notes_'+environment+'.sqlite3')
    db.execute(statement, [@title, @body, @tag, @user_name])
    @id = db.execute("SELECT last_insert_rowid();")
  end

  def valid?
    true
  end

  def self.all
    []
  end

end

class Note

  attr_reader :errors
  attr_reader :id
  attr_accessor :title

  def initialize(title)
    @title = title
  end

  def self.create(title)
    note = Note.new(title)
    note.save
    note
  end

  def self.all
    statement = "Select * from notes;"
    execute_and_instantiate(statement)
  end


  def self.count
    statement = 'Select count(*) from notes;'
    result = Environment.database_connection.execute(statement)
    result[0][0]
  end

  def self.find_by_title(title)
    statement = "Select * from notes where title = ?;"
    execute_and_instantiate(statement, title)[0]
  end

  def self.last
    statement = "Select * from notes order by id DESC limit(1);"
    execute_and_instantiate(statement)[0]
  end

  def save
    statement = "Insert into notes (title) values (?);"
    Environment.database_connection.execute(statement, @title)
    @id = Environment.database_connection.execute("SELECT last_insert_rowid();")[0][0]
    true
  end

  private

  def self.execute_and_instantiate(statement, bind_vars = [])
    rows = Environment.database_connection.execute(statement, bind_vars)
    results = []
    rows.each do |row|
      note = Note.new(row["title"])
      note.instance_variable_set(:@id, row["id"])
      results << note
    end
    results
  end

end

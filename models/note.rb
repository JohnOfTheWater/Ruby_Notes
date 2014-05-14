class Note

  attr_reader :errors
  attr_reader :id
  attr_accessor :title, :user_name, :tag, :body

  def initialize(title, tag, user_name, body)
    @title = title
    @tag = tag
    @user_name = user_name
    @body = body
  end

  def self.create(title, tag, user_name, body)
    note = Note.new(title, tag, user_name, body)
    note.save
    note
  end

  def self.all
    statement = "Select * from notes;"
    execute_and_instantiate(statement)
  end

  def self.find_all(user)
    statement = "Select * from notes where user_name='#{user}';"
    execute_and_instantiate(statement)
  end

  def self.super_find_all
    statement = "Select * from notes;"
    execute_and_instantiate(statement)
  end


  def self.count
    statement = 'Select count(*) from notes;'
    result = Environment.database_connection.execute(statement)
    result[0][0]
  end

  def self.count_user(user)
    statement = "Select count(*) from notes where user_name='#{user}';"
    result = Environment.database_connection.execute(statement)
    result[0][0]
  end

  def self.find_by_title(title)
    statement = "Select * from notes where title = ?;"
    execute_and_instantiate(statement, title)[0]
  end

  def self.find_by_title_user(title, user_name)
    statement = "Select * from notes where title='#{title}' and user_name='#{user_name}';"
    execute_and_instantiate(statement)[0]
  end

  def self.find_by_tag(tag, user_name)
    statement = "Select * from notes where tag='#{tag}' and user_name='#{user_name}';"
    execute_and_instantiate(statement)
  end

  def self.update(user, title, body)
    statement = "update notes set body='#{body}' where user_name='#{user}' and title='#{title}';"
    execute_and_instantiate(statement)
  end

  def self.destroy_by_title(user, title)
    statement = "Delete from notes where user_name='#{user}' and title='#{title}';"
    execute_and_instantiate(statement)
  end

  def self.super_destroy_by_title(title)
    statement = "Delete from notes where title='#{title}';"
    execute_and_instantiate(statement)
  end

  def self.super_destroy_all
    statement = "Delete from notes;"
    execute_and_instantiate(statement)
  end

  def self.last
    statement = "Select * from notes order by id DESC limit(1);"
    execute_and_instantiate(statement)[0]
  end

  def save
    statement = "Insert into notes (title, tag, user_name, body) values (?, ?, ?, ?);"
    Environment.database_connection.execute(statement, [@title, @tag, @user_name, @body])
    @id = Environment.database_connection.execute("SELECT last_insert_rowid();")[0][0]
    true
  end

  private

  def self.execute_and_instantiate(statement, bind_vars = [])
    rows = Environment.database_connection.execute(statement, bind_vars)
    results = []
    rows.each do |row|
      note = Note.new(row["title"], row["tag"], row["user_name"], row["body"])
      note.instance_variable_set(:@id, row["id"])
      results << note
    end
    results
  end

end

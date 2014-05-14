class User

  attr_reader :errors
  attr_reader :id
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.create(name)
    user = User.new(name)
    user.save
    user
  end

  def self.all
    statement = "Select * from users;"
    execute_and_instantiate(statement)
  end


  def self.count
    statement = 'Select count(*) from users;'
    result = Environment.database_connection.execute(statement)
    result[0][0]
  end

  def self.destroy_user(user)
    statement = "Delete from users where name='#{user}';"
    execute_and_instantiate(statement)
  end

  def self.super_destroy_all
    statement = "Delete from users;"
    execute_and_instantiate(statement)
  end

  def self.find_by_name(name)
    statement = "Select * from users where name = ?;"
    execute_and_instantiate(statement, name)[0]
  end

  def self.last
    statement = "Select * from users order by id DESC limit(1);"
    execute_and_instantiate(statement)[0]
  end

  def save
    if self.valid?
      statement = "Insert into users (name) values (?);"
      Environment.database_connection.execute(statement, @name)
      @id = Environment.database_connection.execute("SELECT last_insert_rowid();")[0][0]
      true
    else
      false
    end
  end

  def valid?
    @errors = []
    if !name.match /[a-zA-Z]/
      @errors << "'#{self.name}' is not a valid name — must include letters."
    end
    if User.find_by_name(self.name)
      @errors << "#{self.name} is already a user."
    end
    @errors.empty?
  end

  private

  def self.execute_and_instantiate(statement, bind_vars = [])
    rows = Environment.database_connection.execute(statement, bind_vars)
    results = []
    rows.each do |row|
      user = User.new(row["name"])
      user.instance_variable_set(:@id, row["id"])
      results << user
    end
    results
  end

end

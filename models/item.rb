class Item

  attr_reader :errors
  attr_reader :id
  attr_accessor :title

  def initialize(title)
    @title = title
  end

  def self.find_by_title(title)
    statement = "Select * from items where title = ?;"
    execute_and_instantiate(statement, title)[0]
  end

  def self.count
    statement = "Select count(*) from items;"
    result = Environment.database_connection.execute(statement)
    result[0][0]
  end

  # def self.create(title)
  #   item = Item.new(title)
  #   item.save
  #   item
  # end

  def self.last
    statement = "Select * from items order by id DESC limit(1);"
    execute_and_instantiate(statement)[0]
  end

  def save
    if self.valid?
      statement = "Insert into items (title) values (?);"
      Environment.database_connection.execute(statement, @title)
      @id = Environment.database_connection.execute('SELECT last_insert_rowid();')[0][0]
      true
    else
      false
    end
  end

  def valid?
    @errors = []
    if !title.match /[a-zA-Z]/
      @errors << "'#{self.title}' is not a valid title — must include letters."
    end
    if Item.find_by_title(self.title)
      @errors << "'#{self.title}' is already an item."
    end
    @errors.empty?
  end

  private

  def self.execute_and_instantiate(statement, bind_vars = [])
    rows = Environment.database_connection.execute(statement, bind_vars)
    results = []
    rows.each do |row|
      item = Item.new(row["title"])
      item.instance_variable_set(:@id, row["id"])
      results << item
    end
    results
  end
end

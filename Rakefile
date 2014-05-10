require 'rspec/core/rake_task'
$LOAD_PATH << "lib"


RSpec::Core::RakeTask.new(:spec)

task :default => [ :test_prepare, :spec ]


desc 'create the production database setup'
task :create_pd do
  require 'environment'
  Environment.environment = 'production'
  database = Environment.database_connection
  database.create_tables
end

desc 'prepare the test database'
task :test_prepare do
  require 'environment'
  test_database = 'db/ruby_notes_test.sqlite3'
  File.delete(test_database) if File.exist?(test_database)
  Environment.environment = 'test'
  database = Environment.database_connection
  database.create_tables
end

=begin
#---Quick Methods to show what's in the databases---#
desc 'print test database to terminal'
task :print_test_db do
  db = Database.new('db/budget_test.sqlite3')

  puts "-------EXPENSES-------"
  expenses = db.execute("SELECT * FROM expenses")
  expenses.each do |expense|
    puts expense
    puts "====================="
  end

  puts "-------INCOMES-------"
  incomes = db.execute("SELECT * FROM incomes")
  incomes.each do |income|
    puts income
    puts "====================="
  end
end

desc 'print production database to terminal'
task :print_db do
  db = Database.new('db/budget_production.sqlite3')

  puts "-------EXPENSES-------"
  expenses = db.execute("SELECT * FROM expenses")
  expenses.each do |expense|
    puts expense
    puts "====================="
  end

  puts "-------INCOMES-------"
  incomes = db.execute("SELECT * FROM incomes")
  incomes.each do |income|
    puts income
    puts "====================="
  end
end
=end

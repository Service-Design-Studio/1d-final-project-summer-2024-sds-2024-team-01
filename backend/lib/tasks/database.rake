# lib/tasks/database.rake
# stolen from chatgpt for a simple db connection test

namespace :db do
  desc 'Test database connection'
  task test_connection: :environment do
    begin
      ActiveRecord::Base.connection.execute('SELECT 1')
      puts 'Database connection successful!'
    rescue ActiveRecord::NoDatabaseError => e
      puts "Error connecting to database: #{e.message}"
    end
  end
end


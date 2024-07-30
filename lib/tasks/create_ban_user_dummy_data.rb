namespace :db do
  desc 'Drop, create, migrate, seed and populate sample data'
  task prepare: [:drop, :create, 'schema:load', :seed, :create_dummy_data] do
    puts 'Complete!'
  end

  desc 'Populates the database with sample data'
  task create_dummy_data: :environment do
    include FactoryBot::Syntax::Methods

    ActiveRecord::Base.logger.silence do
      print 'Creating dummy data...'
      
      # Create roles
      admin_role = Role.find_or_create_by!(role_name: 'Admin')
      user_role = Role.find_or_create_by!(role_name: 'User')
      corporate_role = Role.find_or_create_by!(role_name: 'Corporate')

      puts 'Created Roles'

      # Create admin user
      admin = User.find_or_create_by!(email: 'admin@example.com') do |user|
        user.name = 'Admin User'
        user.number = '90000001'
        user.password = 'password'
        user.password_confirmation = 'password'
        user.role = admin_role
        user.status = 'normal'
      end

      # Create regular users
      user1 = User.find_or_create_by!(email: 'user1@example.com') do |user|
        user.name = 'User One'
        user.number = '90000002'
        user.password = 'password'
        user.password_confirmation = 'password'
        user.role = user_role
        user.status = 'normal'
      end

      user2 = User.find_or_create_by!(email: 'user2@example.com') do |user|
        user.name = 'User Two'
        user.number = '90000003'
        user.password = 'password'
        user.password_confirmation = 'password'
        user.role = user_role
        user.status = 'under_review'
      end

      user3 = User.find_or_create_by!(email: 'user3@example.com') do |user|
        user.name = 'User Three'
        user.number = '90000004'
        user.password = 'password'
        user.password_confirmation = 'password'
        user.role = user_role
        user.status = 'banned'
      end

      # Create corporate users
      corporate_user1 = User.find_or_create_by!(email: 'corporate1@example.com') do |user|
        user.name = 'Corporate User One'
        user.number = '90000005'
        user.password = 'password'
        user.password_confirmation = 'password'
        user.role = corporate_role
        user.status = 'normal'
      end

      corporate_user2 = User.find_or_create_by!(email: 'corporate2@example.com') do |user|
        user.name = 'Corporate User Two'
        user.number = '90000006'
        user.password = 'password'
        user.password_confirmation = 'password'
        user.role = corporate_role
        user.status = 'banned'
      end

      puts 'Created Users'

      # Create user reports
      UserReport.find_or_create_by!(reported_user_id: user1.id, reported_by_id: admin.id) do |report|
        report.report_reason = 'Suspicious activity'
        report.status = 'under_review'
      end

      UserReport.find_or_create_by!(reported_user_id: user3.id, reported_by_id: admin.id) do |report|
        report.report_reason = 'Violation of terms'
        report.status = 'ban'
      end

      puts 'Created User Reports'

      print "\r100% Complete                      "
    end
  end
end

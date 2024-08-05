require 'factory_bot_rails'

role_list = [[1, 'User'], [2, 'Admin'], [3, 'Corporate Manager'], [4, 'Corporate User'], [5, 'Charity Manager']]

if Role.count.zero?
  p 'No roles found, seeding role data...'
  role_list.each do |role_id, role_name|
    role = Role.new({ id: role_id, role_name: })
    role.save(validate: false) # Skipping validations
  end

  User.create!(
    name: 'Administrator',
    email: 'admin@gebirah.com',
    description: 'Adminstrator for Ring of Reciprocity.',
    status: 'Active',
    password: 'P@ssword123',
    password_confirmation: 'P@ssword123',
    role_id: 2
  )

  p 'Created Roles and Admin account'
end

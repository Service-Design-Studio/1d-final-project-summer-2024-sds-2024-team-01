Before do
  role_list = [[1, 'User'], [2, 'Admin'], [3, 'Corporate Manager'], [4, 'Corporate User'], [5, 'Charity Manager']]

  if Role.count == 0
    p 'No roles found, seeding role data...'
    role_list.each do |role_id, role_name|
      role = Role.new({ id: role_id, role_name: })
      role.save(validate: false) # Skipping validations
    end
  end
end

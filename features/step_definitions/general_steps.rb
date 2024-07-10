Given('Roles are seeded') do
  role_list = [[1, 'User'], [2, 'Admin'], [3, 'Corporate Manager'], [4, 'Corporate User'], [5, 'Charity Manager']]

  if Role.count == 0
    p 'No roles found, seeding role data...'
    role_list.each do |role_id, role_name|
      role = Role.new({ id: role_id, role_name: })
      role.save(validate: false) # Skipping validations
    end
    p 'Created Roles'
  end
end

Then('There should be 5 roles') do
expect(Role.count).to eq(5)
end

Given('I have an account') do
    visit new_user_registration_path
    fill_in 'user_name', with: 'Harrison Ford'
    fill_in 'user_number', with: '56789012'
    fill_in 'user_email', with: 'harrison@example.com'
    fill_in 'user_password', with: 'asdfasdf'
    fill_in 'user_password_confirmation', with: 'asdfasdf'
    click_button 'Sign up!'
    expect(page).to have_content('signed up successfully.')
end

And('I login') do
  visit new_user_session_path
  fill_in 'user_number', with: '56789012'
  fill_in 'user_password', with: 'asdfasdf'
  click_button 'Login'
  expect(page).to have_content('Signed in successfully.')
end

Given('I am on the {string} page') do |page|
  puts page
  if page == 'home'
    visit '/'
  else
    visit page
  end
end

When('I click on {string} button') do |button|
  click_button button
end

And('I press {string}') do |button_text|
  click_button button_text
end

When('I follow {string}') do |link_text|
  click_link link_text
end

Then('I should see {string}') do |message|
  expect(page).to have_content(message)
end

Then('I should see a message {string}') do |string|
  expect(page).to have_content(string)
end

And('I have a request') do
  Request.create(
    id: 123,
    title: 'Test Request',
    description: 'Need someone to walk my dog for an hour every afternoon',
    category: 'Pet Care',
    location: 'POINT(34.052235 -118.243683)',
    date: Date.new(2024, 7, 2),
    number_of_pax: 1,
    duration: 1,
    start_time: '12:00',
    reward: '$20',
    reward_type: 'Cash',
    status: 'Open',
    created_by: 123
  )
end

And('there is an application for my request') do
  RequestApplication.create(
    status: 'Pending',
    applicant_id: 1,
    request_id: 123,
    created_at: DateTime.now,
    updated_at: DateTime.now
  )
end

Given('there is a registered user on the app') do
  User.create(
    id: 1,
    name: 'Alice Smith',
    nric: 'S8901234H',
    number: '12345678',
    email: 'alice.smith@example.com',
    status: 'Active',
    role_id: 1,
    created_at: DateTime.now,
    password: 'password',
    password_confirmation: 'password',
    updated_at: DateTime.now
  )
end

Given('I am logged in') do
  role_list = [[1, 'User']]

  if Role.count.zero?
    p 'No roles found, seeding role data...'
    role_list.each do |role_id, role_name|
      Role.create!(id: role_id, role_name:)
    end
  end

  user = User.find_or_create_by!(number: '56789012') do |new_user|
    new_user.id = 123
    new_user.name = 'Evan Green'
    new_user.nric = 'S5678901E'
    new_user.email = 'evan.green@example.com'
    new_user.status = 'Active'
    new_user.role_id = Role.find_by(role_name: 'User').id
    new_user.password = 'password'
    new_user.password_confirmation = 'password'
  end

  visit new_user_session_path
  fill_in 'user_number', with: user.number
  fill_in 'user_password', with: 'password'
  click_button 'Login'
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
    created_by: current_user.id
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
    name: 'Hannah Black',
    nric: 'S8901234H',
    number: '89012345',
    email: 'hannah.black@example.com',
    status: 'Active',
    role_id: 1,
    created_at: DateTime.now,
    password: 'password',
    password_confirmation: 'password',
    updated_at: DateTime.now
  )
end

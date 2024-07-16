Given('Roles are seeded') do
    role = Role.new({ id: 1, role_name: 'User'})
    role.save
end

Given('I have an account') do
    visit new_user_registration_path
    fill_in 'user_name', with: 'Harrison Ford'
    fill_in 'user_number', with: '96789012'
    fill_in 'user_email', with: 'harrison@example.com'
    fill_in 'user_password', with: 'asdfasdf'
    fill_in 'user_password_confirmation', with: 'asdfasdf'
    click_button 'Sign up!'
    expect(page).to have_content('signed up successfully.')
    click_button 'Logout'
end

And('I login') do
  visit new_user_session_path
  fill_in 'user_number', with: '96789012'
  fill_in 'user_password', with: 'asdfasdf'
  click_button 'Login'
  expect(page).to have_content('Signed in successfully.')
end

Given('(that )I am on the {string} page') do |page|
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
    title: 'Test Request',
    description: 'Need someone to walk my dog for an hour every afternoon',
    category: 'Pet Care',
    location: 'POINT(34.052235 -118.243683)',
    date: Date.tomorrow,
    number_of_pax: 1,
    duration: 1,
    start_time: '12:00',
    reward: '$20',
    reward_type: 'Cash',
    status: 'Open',
    created_by: User.where(name: 'Harrison Ford').take.id
  )
end

And('there is an application for my request') do
  RequestApplication.create(
    status: 'Pending',
    applicant_id: User.where(name: 'Alice Smith').take.id,
    request_id: Request.where(title: 'Test Request').take.id,
    created_at: DateTime.now,
    updated_at: DateTime.now
  )
end

Given('there is a registered user on the app') do
  User.create(
    name: 'Alice Smith',
    number: '92345678',
    email: 'alice.smith@example.com',
    status: 'Active',
    role_id: 1,
    created_at: DateTime.now,
    password: 'password',
    password_confirmation: 'password',
    updated_at: DateTime.now
  )
end

Then('I should not see {string}') do |message|
  expect(page).not_to have_content(message)
end

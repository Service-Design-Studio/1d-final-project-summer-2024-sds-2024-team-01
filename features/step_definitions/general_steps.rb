Given('I am logged in') do
  role_list = [[1, 'User']]

  if Role.count.zero?
    p 'No roles found, seeding role data...'
    role_list.each do |role_id, role_name|
      Role.create!(id: role_id, role_name:)
    end
  end

  user = User.find_or_create_by!(number: '56789012') do |new_user|
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

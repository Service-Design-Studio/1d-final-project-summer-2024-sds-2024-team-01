Given('I am logged in') do
  @user = User.find_or_create_by!(number: '123') do |user|
    user.name = 'Evan Green'
    user.nric = 'S5678901E'
    user.email = 'evan.green@example.com'
    user.status = 'Active'
    user.role_id = 1
    user.password = 'asdfasdf'
    user.password_confirmation = 'asdfasdf'
    user.created_at = DateTime.now
    user.updated_at = DateTime.now
  end

  visit new_user_session_path
  fill_in 'user_number', with: '123'
  fill_in 'user_password', with: 'asdfasdf'
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

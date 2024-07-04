# features/step_definitions/login_steps.rb

## Login
Given('I am on the login page') do
  visit '/login'
end

When('I enter the following credentials:') do |table|
  table.hashes.each do |row|
    case row['field']
    when 'Phone number'
      fill_in 'user_number', with: row['value']
    when 'Password'
      fill_in 'user_password', with: row['value']
    end
  end
end

When('I click on {string} button') do |button|
  click_button button
end

Then('I should be brought to the request page') do
  visit '/requests'
end

Then('I should see a message {string}') do |message|
  expect(page).to have_content(message)
end

# features/step_definitions/forgot_password_steps.rb

## Forgot Password
Given('I am on the forget password page') do 
  visit '/forgot/new'
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

# features/step_definitions/signup_steps.rb

## Signup
Given('I am on the signup page') do
  visit '/register'
end

When('I fill in the following:') do |table|
  table.hashes.each do |row|
    case row['field']
    when 'Full name'
      fill_in 'user_name', with: row['value']
    when 'Nric'
      fill_in 'user_nric', with: row['value']
    when 'Phone number'
      fill_in 'user_number', with: row['value']
    when 'Email'
      fill_in 'user_email', with: row['value']
    when 'Password'
      fill_in 'user_password', with: row['value']
    when 'Confirm password'
      fill_in 'user_password_confirmation', with: row['value']
    end
  end
end


Then('I will be at request page') do
  visit '/requests'
end

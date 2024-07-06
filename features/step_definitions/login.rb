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

Then('I should see {string}') do |message|
  expect(page).to have_content(message)
end
##################################################################
#signup






















#####################################################################
#forgotpwd
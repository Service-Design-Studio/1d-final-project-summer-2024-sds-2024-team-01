##Login
Given('I am on the login page') do
  visit '/login'
end

When('I enter {string} for {string}') do |value, field|
case field
  when 'Phone number'
    fill_in 'user_number', with: value
  
  when 'Password'
    fill_in 'user_password', with: value
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
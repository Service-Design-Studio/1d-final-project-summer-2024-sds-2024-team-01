When('I enter {string} for {string}') do |value, field|
case field
  when 'Phone number'
    fill_in 'user_number', with: value
  
  when 'Password'
    fill_in 'user_password', with: value
  end
end

Then('I should be brought to the request page') do
  visit '/requests'
end
##################################################################
#signup






















#####################################################################
#forgotpwd

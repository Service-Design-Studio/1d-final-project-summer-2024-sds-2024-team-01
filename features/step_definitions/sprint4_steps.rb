Given('there is an application for my request from a corporate user') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see {string} applicants') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see {string} corporate volunteer applicant') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I am logged in as a cvm') do
  visit '/login'
  fill_in 'user_login', with: 'cvm@test.com'
  fill_in 'user_password', with: 'password'
end

Given('I am on the cvm dashboard') do
  visit '/cvm'
end

When('I click on the copy code button') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the company code should be copied to my clipboard') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I click on the regenerate code button') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should receive a new company code') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I have a cvm account') do
  create(:user, role_id: 5, email: 'cvm@test.com', password: 'password', password_confirmation: 'password', number: nil)
end

Given('I login as a cvm') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Willing Hearts is registered with the application') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I click {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I am on the cvm dashboard') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Willing Hearts is registered with my company') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Jason\'s account is deactivated') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I deactivate Alice\'s account') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('Alice should not be able to log in') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I activate Jason\'s account') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('Jason should be able to log in') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I click on Charity') do
  find('.fa-hand-holding-heart').click
end

When('I enter my charity details') do
  fill_in 'charity_name', with: 'Willing Hearts'
  fill_in 'email', with: 'willing@hearts.com'
  attach_file('document_proof', Rails.root.join('lib', 'assets', 'sample.pdf'))
end

When('I enter the details including the code associated with my company') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I click on Corporate') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I enter my company details') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I am logged in as a corporate volunteer') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should not see {string} #compensation') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should not see {string} #only registered charities, not any') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Jason has completed a request') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Alice has completed a request') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Bob has completed a request') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I login as a cvm') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should {int} hours volunteered this week') do |int|
# Then('I should {float} hours volunteered this week') do |float|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see {string} under top employees') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see {string} before {string} under top employees') do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

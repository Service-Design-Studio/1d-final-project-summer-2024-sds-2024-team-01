
Given('I am logged in as a user') do
  user = User.create!(:phone => '00001', :password => '223344')
  login_as(user, :scope => :user)
end

Given('I am on "My Applications" page') do
  visit '/myapplications'
end

Then('I should see My Application details') do
  expect(page).to have_content('My Application')
  end

When ('I click on one application') do
  pending ## need to write 
  end

Then('I should see the application details page') do
  pending ## need to write
  end

Then('I should see the status as {string}') do
  expect(page).to have_content('string')
end

Then('I should see the application status as {string}') do |string|
  expect(page).to have_content(string)
end

When('I click on one succesful application') do
  click #pending
  end

Then('I click on {string} button on the pop up') do 
  pending
  end


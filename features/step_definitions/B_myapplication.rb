And('I have already applied for a request recently') do
  pending
end


Given('I am on "My Applications" page') do 
  visit '/my-applications'
  end

Then('I should see all my applications') do
  expect(page).to have_content('My Application details')
  end
  
Then('I should see the application details page') do
    pending # Write code here that turns the phrase above into concrete actions
  end
  

Then('I should see status "Successful"') do
  expect(page).to have_content('Successful')
  end

When('I click on one application') do
  find('a', text: 'View').click
  end

Then('I should see the application status as {string}') do
  expect(page).to have_content(string)
  end

Then('I should be able to see a pop up {string}') do |string|
  expect(page).to have_content(string)
  end



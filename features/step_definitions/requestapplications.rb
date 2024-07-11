Given('the first request is fully filled') do
  pending
  # Add the code to check if the first request is fully filled
end

Then('I should not be able to accept any applicants') do
  pending
  # Add the code to verify that no applicants can be accepted
end

When('I {string} the first applicant') do |action|
  find('.clickable-card_requests_index-wrapper').hover
  if action == 'Accept'
    find('.accept-btn_requests_index', visible: false).click
  else
    find('.reject-btn_requests_index', visible: false).click
  end
end

Then('the application should be {string}') do |status|
  expect(RequestApplication.where(request_id: Request.where(title: 'Test Request').take.id).take.status).to eq(status)
end

Given('there is at least one request') do
  # Add the code to ensure there is at least one request
  pending
end

When('I click on the first request') do
  # Add the code to click on the first request
  pending
end

When('I click on Apply') do
  # Add the code to click on the Apply button
  pending
end

When('I apply for a request') do
  # Add the code to apply for a request
  pending
end

Then('I should see {string} in the status column of the most recent request') do |_status|
  # Add the code to check the status of the most recent request
  pending
end

When('my application has been accepted') do
  # Add the code to handle the acceptance of the application
  pending
end

When('my application has been rejected') do
  # Add the code to handle the rejection of the application
  pending
end

# Then('I should see {string} under the status column of the first request') do |status|
#   # Add the code to check the status under the first request
#   pending
# end

Then('I should see the applicants who have applied for each request') do
  page.should have_css('.applicant-info_requests_index > p', visible: false, text: 'Alice Smith')
end

Then('I should see the name of each applicant') do
  page.should have_css('.applicant-info_requests_index > p', visible: false, text: 'Alice Smith')
end

When('I click on the profile section of the first applicant') do
  find('.clickable-card_requests_index-wrapper').hover
  visit find('.applicant-profile')[:href]
end

Then('I should see the applicants profile') do
  expect(page).to have_content('Alice Smith')
  expect(page).to have_selector('.body-container_profile')
end

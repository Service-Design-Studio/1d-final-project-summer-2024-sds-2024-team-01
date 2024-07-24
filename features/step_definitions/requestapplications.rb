Given('the first request is fully filled') do
  pending
  # Add the code to check if the first request is fully filled
end

Then('I should not be able to accept any applicants') do
  pending
  # Add the code to verify that no applicants can be accepted
end

Then('the application should be {string}') do |status|
  expect(find('.status-indicator_my', visible: false).text).to eq(status)
end

Given('there is a request to be applied for') do
  Request.create(
      title: 'Test Request to Apply',
      description: 'Need someone to walk my dog for an hour every afternoon',
      category: 'Pet Care',
      location: 'POINT(34.052235 -118.243683)',
      date: Date.tomorrow,
      number_of_pax: 1,
      duration: 1,
      start_time: '12:00',
      reward: '$20',
      reward_type: 'Cash',
      status: 'Open',
      created_by: User.where(name: 'Alice Smith').take.id
    )
end

When('I click on the request') do
  find('.clickable-card_requests_index').click
end

When('I expand the request') do
  find('.dropdown-btn_requests_index_my').click
end

When('I click on Apply') do
  click_on 'Apply'
end

Given('I have applied for the request') do
  RequestApplication.create(
    status: 'Pending',
    applicant_id: User.where(name: 'Harrison Ford').take.id,
    request_id: Request.where(title: 'Test Request to Apply').take.id,
    created_at: DateTime.now,
    updated_at: DateTime.now
  )
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
  page.should have_css('.applicant-info_requests_index_my > p', visible: false, text: 'Alice Smith')
end

Then('I should see the name of each applicant') do
  page.should have_css('.applicant-info_requests_index_my > p', visible: false, text: 'Alice Smith')
end

When('I click on the profile section of the first applicant') do
  find('.dropdown-btn_requests_index_my').click
  visit find('.applicant-profile_my')[:href]
end

Then('I should see the applicants profile') do
  expect(page).to have_content('Alice Smith')
  expect(page).to have_selector('.body-container_profile')
end

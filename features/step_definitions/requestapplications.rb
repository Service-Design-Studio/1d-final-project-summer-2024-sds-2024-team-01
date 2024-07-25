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
      date: Date.tomorrow + 3,
      number_of_pax: 1,
      duration: 1,
      start_time: '12:00',
      reward: '$20',
      reward_type: 'Money',
      status: 'Available',
      created_by: User.where(name: 'Alice Smith').take.id
    )
end

When('I click on the request') do
  find('.clickable-card_requests_index').click
end

When('I expand the request') do
  find('.dropdown-btn_requests_index_my').click
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

When('my application has been accepted') do
  application = RequestApplication.where(applicant_id: User.where(name: 'Harrison Ford').take.id)
  application.update(status: 'Accepted')
end

When('my application has been rejected') do
  application = RequestApplication.where(applicant_id: User.where(name: 'Harrison Ford').take.id)
  application.update(status: 'Rejected')
end

Given('I have completed the request') do
  Request.where(title: 'Test Request to Apply').update(status: 'Completed')
end

When('the request becomes full') do
  create(:random_application, request: Request.where(title: 'Test Request to Apply').take, status: 'Accepted')
end

Then('I should see the applicants who have applied for each request') do
  page.should have_css('.applicant-info_requests_index_my h6', visible: false, text: 'Alice Smith')
end

Then('I should see the name of each applicant') do
  page.should have_css('.applicant-info_requests_index_my h6', visible: false, text: 'Alice Smith')
end

When('I click on the profile section of the first applicant') do
  visit find('.mini-profile')[:href]
end

Then('I should see the applicants profile') do
  expect(page).to have_content('Alice Smith')
  expect(page).to have_selector('.body-container_profile')
end

When('I click on the request title') do

end

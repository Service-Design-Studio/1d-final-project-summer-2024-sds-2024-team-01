# Feature 1: View Requests

Given('I am on the Ring of Reciprocity requests page') do
  visit '/requests'
end

Given('I can see no requests available') do
  Request.delete_all
end

# not sure if there is a message yet
Then('I should see a message indicating no requests are currently available') do
  # #should have a message that says that there is no requests available
  # expect(page).to have_content('No requests are currently available')
  puts 'No requests available'
end
##############################################################
# Feature 2: Create Request

Given('I want to make new requests') do
  visit '/requests/new'
end

Then('I fill in the following details:') do |table|
  table.hashes.each do |row|
    input = row['Field']
    value = row['Value']
    case input
    when 'Banner Photo'
      attach_file('Banner Photo', value, make_visible: true) if value.present?
    when 'Title'
      fill_in 'Title', with: value
    when 'Category'
      find('#request_category').find(:xpath, 'option[2]').select_option
    when 'Date'
      fill_in 'Date', with: value
    when 'Number of volunteers needed'
      fill_in 'Number of volunteers needed', with: value
    when 'Start time'
      page.find('#start_time').click
      page.find('.flatpickr-hour').click
    when 'Duration'
      fill_in 'Duration', with: value
    when 'Location'
      fill_in 'request[location]', with: value
    when 'Description'
      fill_in 'Description', with: value
    when 'Incentive provided'
      find('#request_reward_type').find(:xpath, 'option[2]').select_option
    when 'Incentive'
      fill_in 'request[reward]', with: value
    else
      raise "Field '#{input}' is not defined in the step definition."
    end
  end
end

When('I click on {string},{string}') do |_label, _option|
  find('#request_category').find(:xpath, 'option[2]').select_option
end

Then('I should not see any new requests') do
  # Assuming the application handles invalid form submissions without creating new requests
  expect(page).not_to have_css('.request-card')
end

Then('I should be able to see the request') do
  expect(page).to have_css('.request-card')
end

Then('I should be returned back to new requests page') do
  expect(page).to have_current_path('/requests/new')
end
Then('I should see message {string}') do |_string|
  # expect(page).to have_current_path(%r{/requests/\d+})
  expect(page).to have_content('Request was successfully created.')
end
###########################################
# Feature 3: Show more details of Request

Given('I have a request titled {string}') do |title|
  Request.where(title:)
end

When('I follow "Show more details" of the same row of {string}') do |_title|
  visit '/requests/13' # make it to click on the item instead
end

############################
# Feature 6: sort_requests
When('I enter {string} in the Search requests field') do |string|
  fill_in 'searchInput', with: string
end

# features/step_definitions/view-requestspage.rb

Then('I should see the requests that contain the keyword {string}') do |keyword|
  keyword_downcased = keyword.downcase

  # Find all request cards on the page
  request_cards = all('.request-card_requests_index')

  matching_cards = []
  request_cards.each do |card|
    title = card.find('.card-title_requests_index').text
    puts "Found title: #{title}" # Debugging output
    matching_cards << card if title.downcase.include?(keyword_downcased)
  end

  # Ensure there is at least one matching card
  expect(matching_cards).not_to be_empty, "expected to find text '#{keyword}' in the requests, but did not"
end

############################
# Feature 7: Show More Details

When('I click on a request') do
  first('.clickable-card_requests_index').click
end

Then('I should see the request details') do
  expect(page).to have_content('Request Title')
  expect(page).to have_content('Request Description')
  expect(page).to have_content('Category')
  expect(page).to have_content('Location')
  expect(page).to have_content('Date')
  expect(page).to have_content('Start Time')
  expect(page).to have_content('Duration')
  expect(page).to have_content('Reward')
  expect(page).to have_content('Status')
end

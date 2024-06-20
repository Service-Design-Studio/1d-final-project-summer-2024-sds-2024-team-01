# File: features/step_definitions/request_steps.rb

Given('I am logged in as {string} with nric {string}') do |email, nric|
  # Implement authentication logic here if necessary
  puts "Logged in as #{email} with NRIC #{nric}"
end

Given('I am on the Ring of Reciprocity requests page') do
  visit '/requests' # Assuming this is the correct URL to view requests
end

Then('I should see the following:') do |table|
 # Convert the table into an array of hashes
 requests = table.hashes

 # Loop through each request and create it in the database
 requests.each do |request|
   Request.create!(
     title: request['Title'],
     category: request['Category'],
     location: request['Location'],
     date: request['Date'],
     number_of_pax: request['Number of Pax'],
     duration: request['Duration'],
     reward: request['Reward'],
     reward_type: request['Reward_Type'],  
     status: 'Active',               
     created_by: request['Created by']                  
   )
 end
end

Then('see that there are {int} requests') do |expected_count|
  expect(page).to have_selector('.request', count: expected_count)
end

Given('I have no requests') do
  Request.delete_all
end

When('I follow {string}') do |link|
  click_link(link)
end

Then('I am on create request page') do
  puts "I am on create request page"
end

When('I fill in {string} with {string}') do |field, value|
  fill_in(field, with: value)
end

When('I fill in {string} with "POINT \({float} {float})') do |string, float, float2|
  fill_in(string, with: "POINT (#{float} #{float2})")
end

Then('I should see {string}') do |content|
  expect(page).to have_content(content)
end

Then('I should see {string} in the table of requests') do |content|
  expect(page).to have_selector('table#requests-table', text: content)
end

Given('I have a request titled {string}') do |title|
  Request.create!(title: title) # Create a request with the specified title
end

When('I follow {string} for {string}') do |action, title|
  click_link("#{action} #{title}")
end

Then('I should not see {string} in the table of requests') do |title|
  expect(page).not_to have_selector('table#requests-table', text: title)
end

Then('I should see {string} on the request details page') do |title|
  expect(page).to have_content(title)
end

Then('I should see {string} with {string}') do |field, value|
  expect(page).to have_content("#{field}: #{value}")
end

Given('I can see no requests available') do
  # Implement logic to ensure no seed requests are present
  puts "No seed requests available"
end

Then('I should see a message indicating no requests are currently available') do
  expect(page).to have_content("No requests are currently available")
end

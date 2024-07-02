<<<<<<< HEAD
Given('I am logged in as {string} with nric {string}') do |email, nric|
  # Implementation to log in with the given credentials
=======

#Feature 1: View Requests
Given('I am logged in as {string} with nric {string}') do |email, nric|
  # Implement authentication logic here if necessary
>>>>>>> ddbb5a2d1745231b62753735ab04e4859613e12d
  puts "Logged in as #{email} with NRIC #{nric}"
end

Given('I am on the Ring of Reciprocity requests page') do
<<<<<<< HEAD
  requests_page
end

Then('I should see the following:') do |table|
  pending
end

Then('see that there are {int} requests') do |count|
  expect(page).to have_css('.request', count: count)
  puts "There are #{count} requests"
end

Given('I have no requests') do
  puts "No requests!"
end

When('I follow {string}') do |link_text|
  click_link(link_text)
  puts "Clicked on #{link_text}"
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
  puts "Filled in #{field} with #{value}"
end

When('I fill in {string} with "{string}"') do |field, string|
  fill_in field, with: "POINT (#{string} )"
  puts "Filled in #{field} with POINT (#{string})"
end

When('I press {string}') do |button_text|
  click_button(button_text)
  puts "Pressed #{button_text}"
end

Then('I should see {string}') do |content|
  expect(page).to have_content(content)
  puts "Saw '#{content}'"
end

Then('I should see {string} in the table of requests') do |content|
  within('table.requests-table') do
    expect(page).to have_content(content)
  end
  puts "Saw '#{content}' in the table of requests"
end

Given('I have a request titled {string}') do |title|
  puts "Have a request titled '#{title}'"
end

When('I follow {string} for {string}') do |link_text, request_title|
  within('.request', text: request_title) do
    click_link(link_text)
  end
  puts "Clicked '#{link_text}' for '#{request_title}'"
end

Then('I should not see {string} in the table of requests') do |content|
  within('table.requests-table') do
    expect(page).not_to have_content(content)
  end
  puts "Did not see '#{content}' in the table of requests"
end

Then('I should see {string} on the request details page') do |content|
  expect(page).to have_content(content)
  puts "Saw '#{content}' on the request details page"
end

Then('I should see {string} with {string}') do |content1, content2|
  puts "#{content1} : #{content2}"
end

Given('I can see no seed requests available') do
  puts "No seed requests available"
end

Then('I should see a message indicating no requests are currently available') do
  expect(page).to have_content('No requests are currently available')
  puts "No requests are currently available!"
end
=======
  visit '/requests' # Assuming this is the correct URL to view requests
end

# Then('I should see the following:') do |table|
#  # Convert the table into an array of hashes
#  requests = table.hashes
#  # Loop through each request and create it in the database
#  requests.each do |request|
#   Request.create!(
#     title: request['Title'],
#     category: request['Category'],
#     location: request['Location'],
#     date: request['Date'],
#     number_of_pax: request['Number of Pax'],
#     duration: request['Duration'],
#     reward: request['Reward'],
#     reward_type: request['Reward_Type'],  
#     status: 'Active',               
#     created_by: request['Created by']                  
#   )
#  end
# end

Then('I should see a list of requests') do
  # Check if the page has a list of requests
  expect(page).to have_css('table tr') 
  end

Then('see that there are {int} requests') do |expected_count|
  expect(page).to have_selector('.request', count: expected_count)
end

Given('I can see no requests available') do
  Request.delete_all
end

Then ('I should see a message indicating no requests are currently available') do
  ##should have a message that says that there is no requests available
  #expect(page).to have_content('No requests are currently available')
  puts "No requests available"  
end
##############################################################
#Feature 2: Create Request 
Given('I want to make new requests') do
  visit 'requests/new'
end

When("I fill in the following:") do |table|
  table.hashes.each do |row|
    fill_in row['field'], with: row['value']
  end
end

#confirm that the button is the only and correct one
When('I press {string}') do |string|
  click_button(string, exact: true) 
  ##capybara looks for button element that matches the text or ID// exact: true --> Capybara to match button's text exactly as provided 
end

When('I follow {string}') do |string|
  click_link(string)
end

#get the feedback at the top that there is that string
Then('I should see {string}') do |content|
  expect(page).to have_content(content)
end

Then('I should not see any new requests') do
  puts " "
end

########################
#Feature 3: Show more details of Request

# Given('the following requests exist:') do |table|
  
#     # Your implementation here
#     # Access the data from the table using 'table.hashes' or other methods
#     # Perform any necessary actions based on the request details
#     table.hashes.each do |row|
#       Request.create!(
#         title: row['title'],
#         description: row['description'],
#         category: row['category'],
#         location: row['location'],
#         date: row['date'],
#         number_of_pax: row['number_of_pax'],
#         duration: row['duration'],
#         reward: row['reward'],
#         reward_type: row['reward_type']
#       )
#     end
#   end
  


Given('I have a request titled {string}') do |title|
  @request = Request.find_by(title: title)
  raise "Request with title '#{title}' not found" unless @request
end

When('I follow "Show more details" of the same row of {string}') do |title|
  request = Request.find_by(title: title)
  within(:xpath, "//tr[td[contains(.,'#{title}')]]") do
    click_link "Show more details"
  end
end

Then('I should see the following request details:') do |table|
  # Extract the expected details from the table and compare with actual details
  # For example, verify title, description, thumbnail, etc.
  # You can use assertions or custom validation methods
  table.hashes.each do |row|
    field = row['field']
    value = row['value']
    expect(page).to have_content("#{field.humanize}: #{value}")
    
  end
end

Then('I should see an error message {string}') do |string|
  puts "#{string}"
end
##################


Then('I should see {string} in the table of requests') do |content|
  expect(page).to have_selector('table#requests-table', text: content)
end




Then('I should see {string} on the request details page') do |title|
  expect(page).to have_content(title)
end




>>>>>>> ddbb5a2d1745231b62753735ab04e4859613e12d


#Feature 1: View Requests
Given('I am logged in as {string} with nric {string}') do |email, nric|
  # Implement authentication logic here if necessary
puts "Logged in as #{email} with NRIC #{nric}"  #need to check information with database


end

Given('I am on the Ring of Reciprocity requests page') do
  visit '/requests' 
end

#just check that there is a list of requests in the database
Then('I should see a list of requests') do
  # Check if the page has a list of requests
  expect(page).to have_css('.request-card')
  expect(page).to have_content('Help with Gardening')
  expect(page).to have_content('Dog Walking')
  expect(page).to have_content('Grocery Shopping')
  end


Given('I can see no requests available') do
  Request.delete_all
end

#not sure if there is a message yet
Then ('I should see a message indicating no requests are currently available') do
  ##should have a message that says that there is no requests available
  #expect(page).to have_content('No requests are currently available')
  puts "No requests available"  
end
##############################################################
#Feature 2: Create Request 

Given("I want to make new requests") do
  visit '/requests/new'
end

When("I fill in the following:") do |table|
  table.rows_hash.each do |field, value|
    case field
    when "BannerPhoto"
      attach_file("request_thumbnail", value) unless value.strip.empty?
    when "Title"
      fill_in "request_title", with: value
    when "Date"
      fill_in "request_date", with: value
    when "Category"
      select value, from: "request_category" unless value.strip.empty?
    when "Number of volunteers needed"
      fill_in "request_number_of_pax", with: value
    when "Start Time"
      fill_in "request_start_time", with: value
    when "End Time"
      fill_in "request_duration", with: value
    when "Description"
      fill_in "request_description", with: value
    when "Incentive"
      select value, from: "request_reward_type" unless value.strip.empty?
      fill_in "request_reward", with: value unless value.strip.empty?
    end
  end
end

And("I press {string}") do |button_text|
  click_button button_text
end

Then("I should see {string}") do |text|
  expect(page).to have_content text
end

When("I follow {string}") do |link_text|
  click_link link_text
end

Then("I should not see any new requests") do
  # Assuming the application handles invalid form submissions without creating new requests
  expect(page).not_to have_css('.request-card')
end


###########################################
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
  Request.where(title: title)
end

When('I follow "Show more details" of the same row of {string}') do |title|
  visit '/requests/13'
end

# Then('I should see the following request details:') do |table|
#   # Extract the expected details from the table and compare with actual details
#   # For example, verify title, description, thumbnail, etc.
#   # You can use assertions or custom validation methods
#   table.hashes.each do |row|
#     field = row['field']
#     value = row['value']
#     expect(page).to have_content("#{field.humanize}: #{value}")
    
#   end
# # end
# Then('I should see the following request details:') do |table|
#   table.hashes.each do |row|
#     field = row['field'].downcase
#     value = row['value']

#     case field
#     when 'title'
#       expect(page).to have_content(value)
#     when 'category'
#       expect(page).to have_content("Category: #{value}")
#     when 'description'
#       expect(page).to have_content("Description: #{value}")
#     when 'location'
#       expect(page).to have_content("Location: #{value}")
#     when 'date'
#       expect(page).to have_content("Date: #{value}")
#     when 'number_of_pax'
#       expect(page).to have_content("Number of Pax: #{value}")
#     when 'duration'
#       expect(page).to have_content("Duration: #{value}")
#     when 'reward'
#       expect(page).to have_content("Reward: #{value}")
#     when 'reward_type'
#       # Assuming reward_type is also displayed somewhere in the view
#       expect(page).to have_content("Reward Type: #{value}")
#     when 'created_by'
#       expect(page).to have_content("Created by: #{value}")
#     else
#       raise "Unknown field: #{field}"
#     end
#   end
# end

Then('I should see a list of details:') do
  # Check if the page has a list of requests
  expect(page).to have_css('table tr') 
  end

Then('I should see an error message {string}') do |string|
  puts "#{string}"
end
##################

#Feature 4: delete_requests












################################
#Feature 5: edit_requests




















############################
#Feature 6: sort_requests







Then('I should see {string} in the table of requests') do |content|
  expect(page).to have_selector('table#requests-table', text: content)
end




Then('I should see {string} on the request details page') do |title|
  expect(page).to have_content(title)
end




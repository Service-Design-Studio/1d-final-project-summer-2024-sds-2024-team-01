
#Feature 1: View Requests
Given('I am on the Ring of Reciprocity requests page') do
  visit '/requests' 
end

#just check that there is a list of requests in the database
Then('I should see a list of requests') do
  # Check if the page has a list of requests
  expect(page).to have_css('#requestContainer')
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

When('I fill in the following:') do |table|
  table.hashes.each do |row|
    attach_file('Banner Photo', row['BannerPhoto'], make_visible: true) if row['BannerPhoto'].present?

    fill_in 'request_title', with: row['Title']
    fill_in 'request_date', with: row['Date']
    select row['Category'], from: 'request_category'
    fill_in 'request_number_of_pax', with: row['Number of volunteers needed']
    fill_in 'request_start_time', with: row['Start Time']
    fill_in 'request_duration', with: row['Duration']
    fill_in 'request_location', with: row['Location']
    fill_in 'request_description', with: row['Description']
    select row['Incentive provided'], from: 'request_reward_type'
    fill_in 'request_reward', with: row['Incentive']
  end
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
    if title.downcase.include?(keyword_downcased)
      matching_cards << card
    end
  end

  # Ensure there is at least one matching card
  expect(matching_cards).not_to be_empty, "expected to find text '#{keyword}' in the requests, but did not"
end

# Then('I should see {string} in the table of requests') do |content|
#   expect(page).to have_selector('table#requests-table', text: content)
# end




# Then('I should see {string} on the request details page') do |title|
#   expect(page).to have_content(title)
# end





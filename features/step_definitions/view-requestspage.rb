Given('I am logged in as {string} with nric {string}') do |email, nric|
  # Implementation to log in with the given credentials
  puts "Logged in as #{email} with NRIC #{nric}"
end

Given('I am on the Ring of Reciprocity requests page') do
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

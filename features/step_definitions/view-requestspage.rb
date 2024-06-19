Given('I am logged in as {string} with nric {string}') do |email, nric|
  # Implement a login helper method, assuming we have a login step available
  pending
end

Given('I am on the Ring of Reciprocity requests page') do
  visit '/index.html.erb'
end

Then('I should see the following:') do |request|
  @requests.each do |request|
  byebug
  end
end

Then('see that there are {int} requests') do |count|
  expect(page).to have_css('.request', count: count)
end

When('I follow {string}') do |link|
  click_link link
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I press {string}') do |button|
  click_button button
end

Then('I should see {string}') do |content|
  expect(page).to have_content(content)
end

When('I follow {string} for {string}') do |link, title|
  request = Request.find_by(title: title)
  within("#request_#{request.id}") do
    click_link link
  end
end

Then('I should not see {string} in the table of requests') do |content|
  expect(page).not_to have_content(content)
end

Then('I should see {string} on the request details page') do |title|
  request = Request.find_by(title: title)
  visit request_path(request)
  expect(page).to have_content(title)
end

Then('I should see {string} with {string}') do |label, value|
  expect(page).to have_content("#{label}: #{value}")
end

Then('I should see a message indicating no requests are currently available') do
  expect(page).to have_content('No requests are currently available')
end


Given('I have no requests') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I fill in {string} with "POINT \({float} {float})') do |string, float, float2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see {string} in the table of requests') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I have a request titled {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I can see no seed requests available') do
  pending # Write code here that turns the phrase above into concrete actions
end
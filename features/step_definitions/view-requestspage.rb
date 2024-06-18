Given('the following requests exist:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

Given /^I am on the Ring of Reciprocity requests page$/ do
  visit requests_path
end

Then /^I should see the following:$/ do |table|
  table.hashes.each do |request|
    expect(page).to have_content(request['Title'])
    expect(page).to have_content(request['Category'])
    expect(page).to have_content(request['Location'])
    expect(page).to have_content(request['Date'])
    expect(page).to have_content(request['Number of Pax'])
    expect(page).to have_content(request['Duration'])
    expect(page).to have_content(request['Reward'])
    expect(page).to have_content(request['Created by'])
    expect(page).to have_content(request['Details'])
  end
end

Given /^I have no requests$/ do
  Request.destroy_all
end

When /^I follow "Create Request"$/ do
  visit new_request_path
end

When /^I fill in "Title" with "(.*?)"$/ do |title|
  fill_in 'Title', with: title
end

When /^I select "(.*?)" from "(.*?)"$/ do |option, field|
  select option, from: field
end

When('I fill in {string} with "POINT \({float} {float})') do |string, float, float2|
  pending # Write code here that turns the phrase above into concrete actions
end

When /^I fill in "Date" with "(.*?)"$/ do |date|
  fill_in 'Date', with: date
end

When /^I fill in "Number of Pax" with "(.*?)"$/ do |number_of_pax|
  fill_in 'Number of Pax', with: number_of_pax
end

When /^I fill in "Duration" with "(.*?)"$/ do |duration|
  fill_in 'Duration', with: duration
end

When /^I fill in "Reward" with "(.*?)"$/ do |reward|
  fill_in 'Reward', with: reward
end

When /^I fill in "Details" with "(.*?)"$/ do |details|
  fill_in 'Details', with: details
end

When /^I press "Create Request"$/ do
  click_button 'Create Request'
end

Then /^I should see "Request was successfully created."$/ do
  expect(page).to have_content('Request was successfully created.')
end

Then /^I should see "(.*?)" on the table of requests$/ do |title|
  expect(page).to have_content(title)
end

When /^I follow "Edit" for "(.*?)"$/ do |title|
  within("tr", text: title) do
    click_link 'Edit'
  end
end

When /^I press "Update Request"$/ do
  click_button 'Update Request'
end

Then /^I should see "Request was successfully updated."$/ do
  expect(page).to have_content('Request was successfully updated.')
end

When /^I follow "Delete" for "(.*?)"$/ do |title|
  within("tr", text: title) do
    click_link 'Delete'
  end
end

Then /^I should see "Request was successfully deleted."$/ do
  expect(page).to have_content('Request was successfully deleted.')
end

Given('I have a request titled {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When /^I follow "Show more details" for "(.*?)"$/ do |title|
  within("tr", text: title) do
    click_link 'Show more details'
  end
end

Then /^I should see "(.*?)" on the request details page$/ do |title|
  expect(page).to have_content(title)
end

Then('I should see {string} with {string}') do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end
Given /^I can see no seed requests available$/ do
  Request.destroy_all
end

Then /^I should see a message indicating no requests are currently available$/ do
  expect(page).to have_content('No requests are currently available.')
end

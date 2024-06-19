Given('I am logged in as {string} with nric {string}') do |email, nric|
 puts "signed in!"
end




Given('I am on the Ring of Reciprocity requests page') do
  puts "at request page!"
end

Then('I should see the following:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

Then('see that there are {int} requests') do |int|
# Then('see that there are {float} requests') do |float|
  puts int
end

Given('I have no requests') do
  puts "no requests!"
end

When('I follow {string}') do |string|
  puts "followed #{string}!"
end

When('I fill in {string} with {string}') do |string, string2|
  puts "filled in #{string} with #{string2}!"
end

When('I fill in {string} with "POINT \({float} {float})') do |string, float, float2|
  puts "filled in #{string} with POINT (#{float} #{float2})!"
end

When('I press {string}') do |string|
  puts "pressed #{string}!"
end

Then('I should see {string}') do |string|
  puts "saw #{string}!"
end

Then('I should see {string} in the table of requests') do |string|
  puts "saw #{string} in the table of requests!"
end

Given('I have a request titled {string}') do |string|
  puts "have a request titled #{string}!"
end

When('I follow {string} for {string}') do |string, string2|
  puts "followed #{string} for #{string2}!"
end

Then('I should not see {string} in the table of requests') do |string|
  puts "did not see #{string} in the table of requests!"
end

Then('I should see {string} on the request details page') do |string|
  puts "saw #{string} on the request details page!"
end

Then('I should see {string} with {string}') do |string, string2|
  puts "@string : @string2"
end

Given('I can see no seed requests available') do
  puts "0 requests available"
end

Then('I should see a message indicating no requests are currently available') do
  puts "No requests are currently available!"
end

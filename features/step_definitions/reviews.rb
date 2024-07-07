# Given ('I am on the Ring of Reciprocity requests page') do
#   visit '/requests'
# end

# When ('I follow {string}') do |link|
#   click_link link
# end

# When ('I fill in {string} with {string}') do |field, value|
#   fill_in field, with: value
# end

# When ('I press {string}') do |button|
#   click_button button
# end

# Then ('I should see {string}') do |message|
#   expect(page).to have_content(message)
# end

# features/step_definitions/review_steps.rb
# Given('I am logged in as a user') do
#   @current_user = User.create!(email: 'user@example.com', password: 'password', name: 'Current User')
#   visit new_user_session_path
#   fill_in 'Email', with: 'user@example.com'
#   fill_in 'Password', with: 'password'
#   click_button 'Log in'
# end

# Given('there is a user named {string}') do |name|
#   first_name, last_name = name.split
#   @reviewee = User.create!(name: name, email: 'john@example.com', password: 'password')
# end

# Given('I have written a review for {string} with {string} and rating {string}') do |name, comment, rating|
#   @reviewee = User.find_by(name: name)
#   Review.create!(reviewer: @current_user, reviewee: @reviewee, comment: comment, rating: rating)
# end

# When('I go to the new review page for {string}') do |name|
#   @reviewee = User.find_by(name: name)
#   visit new_user_review_path(@reviewee)
# end

# When('I fill in {string} with {string}') do |field, value|
#   fill_in field, with: value
# end

# When('I press {string}') do |button|
#   click_button button
# end

# Then('I should see {string}') do |content|
#   expect(page).to have_content(content)
# end

# When('I go to the reviews index page') do
#   visit reviews_path
# end

# When('I click on {string} for the review') do |link|
#   click_link link
# end


Given('I am on the "My Requests" page') do
  visit '/requests'
end

And('I can see my completed requests') do
  expect(page).to have_content('Completed Requests')
end

When('I follow {string}') do |link_text|
  click_link link_text
end

And('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

And('I press {string}') do |button|
  click_button button
end

Then('I should see {string}') do |content|
  expect(page).to have_content(content)
end

# Scenario: Leave a review for a user
Given('there is a user named {string}') do |name|
  @reviewee = User.create!(name: name, email: 'john@example.com', password: 'password')
end

When('I go to the new review page for {string}') do |name|
  @reviewee = User.find_by(name: name)
  visit new_user_review_path(@reviewee)
end

# Scenario: Edit a review
Given('I have written a review for {string} with {string} and rating {string}') do |name, comment, rating|
  @reviewee = User.find_by(name: name)
  Review.create!(reviewer: @current_user, reviewee: @reviewee, comment: comment, rating: rating)
end

Given('I am on the "My Reviews" page') do
  visit reviews_path
end

When('I click on {string} for the review') do |link_text|
  click_link link_text
end

And('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

And('I press {string}') do |button|
  click_button button
end

Then('I should see {string}') do |content|
  expect(page).to have_content(content)
end


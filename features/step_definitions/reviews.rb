# Scenario: Leave a review for a user
When('I have a completed request') do
  @review = Review.find_by!(status: "Completed").first
end

Given('there is a user named {string}') do |name|
  @reviewee = User.create!(name: name, email: 'john@example.com', password: 'password')
end

When('I go to the new review page for {string}') do |name|
  @reviewee = User.find_by(name: name)
  visit new_user_review_path(@reviewee)
end

When()

# Scenario: Edit a review
# Given('I have written a review for {string} with {string} and rating {string}') do |name, comment, rating|
#   @reviewee = User.find_by(name: name)
#   Review.create(review_for: @reviewee, created_by: @current_user, review_content: comment, rating: rating)
# end

# When('I click on {string} for the review') do |link_text|
#   link_to link_text
# end

# And('I change the rating in {string} to {string}') do |rating, new|
#   fill_in rating, with: new
# end

# And('I change the text in {string} to {string}') do |field, value|
#   fill_in field, with: value
# end

# And('I press {string}') do |button|
#   click_button button
# end

# Then('I should see {string}') do |content|
#   expect(page).to have_content(content)
# end

# And('I should see "Updated review!"') do
#   p "Updated review!"
# end
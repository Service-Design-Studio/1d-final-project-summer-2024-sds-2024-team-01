# # Scenario: Leave a review for a user
# # features/step_definitions/reviews.rb
# # features/step_definitions/reviews.rb
#
# Given('I am logged in') do
#   @current_user = User.create!(name: 'Test User', email: 'test@example.com', password: 'password')
#   login_as(@current_user, scope: :user)
# end
#
# Given('I am logged in') do
#   @current_user = User.create!(name: 'Test User', email: 'test@example.com', password: 'password')
#   login_as(@current_user, scope: :user)
# end

When('I have a completed request') do
  @request = Request.create!(title: 'Completed Request', status: 'Completed', created_by: @current_user.id)
end

Given('there is a user named {string}') do |name|
  @reviewee = User.create!(name: name, email: 'volunteer@example.com', password: 'password')
end


# When('I am on the {string} page') do |page_name|
#   visit myrequests_path
# end

When('I fill out the review form with rating {int} and comment {string}') do |rating, comment|
  fill_in 'Rating', with: rating
  fill_in 'Review content', with: comment
end

Then('a review with rating {int} and comment {string} should be created for {string}') do |rating, comment, user_name|
  reviewee = User.find_by(name: user_name)
  review = Review.find_by(rating: rating, review_content: comment, review_for: reviewee.id)
  expect(review).not_to be_nil
end

# When('I have a completed request') do
#   @request = Request.create!(title: 'Completed Request', status: 'Completed', created_by: @current_user.id)
# end
#
# Given('there is a user named {string}') do |name|
#   @reviewee = User.create!(name: name, email: 'volunteer@example.com', password: 'password')
# end
#
# When('I am on the {string} page') do |page_name|
#   visit myrequests_path
# end
#
# When('I click on the request') do
#   click_link @request.title
# end
#
# When('I fill out the review form with rating {int} and comment {string}') do |rating, comment|
#   fill_in 'Rating', with: rating
#   fill_in 'Review content', with: comment
# end
#
# When('I press {string}') do |button|
#   click_button button
# end
#
# Then('a review with rating {int} and comment {string} should be created for {string}') do |rating, comment, user_name|
#   reviewee = User.find_by(name: user_name)
#   review = Review.find_by(rating: rating, review_content: comment, review_for: reviewee.id)
#   expect(review).not_to be_nil
# end
#
# # When('I have a completed request') do
# #   @request = Request.create!(title: 'Completed Request', status: 'Completed', created_by: @current_user.id)
# # end
# #
# # Given('there is a user named {string}') do |name|
# #   @reviewee = User.create!(name: name, email: 'volunteer@example.com', password: 'password')
# # end
# #
# #
# # When('I click on the request') do
# #   click_link @request.title
# # end
# #
# # When('I click on {string}') do |link_text|
# #   click_link link_text
# # end
# #
# # When('I fill out the review form with rating {int} and comment {string}') do |rating, comment|
# #   fill_in 'Rating', with: rating
# #   fill_in 'Review content', with: comment
# # end
# #
# # When('I press {string}') do |button|
# #   click_button button
# # end
# #
# # Then('a review with rating {int} and comment {string} should be created for {string}') do |rating, comment, user_name|
# #   reviewee = User.find_by(name: user_name)
# #   review = Review.find_by(rating: rating, review_content: comment, review_for: reviewee.id)
# #   expect(review).not_to be_nil
# # end
# #
#
#
#
# # Scenario: Edit a review
# # Given('I have written a review for {string} with {string} and rating {string}') do |name, comment, rating|
# #   @reviewee = User.find_by(name: name)
# #   Review.create(review_for: @reviewee, created_by: @current_user, review_content: comment, rating: rating)
# # end
#
# # When('I click on {string} for the review') do |link_text|
# #   link_to link_text
# # end
#
# # And('I change the rating in {string} to {string}') do |rating, new|
# #   fill_in rating, with: new
# # end
#
# # And('I change the text in {string} to {string}') do |field, value|
# #   fill_in field, with: value
# # end
#
# # And('I press {string}') do |button|
# #   click_button button
# # end
#
# # Then('I should see {string}') do |content|
# #   expect(page).to have_content(content)
# # end
#
# # And('I should see "Updated review!"') do
# #   p "Updated review!"
# # end

Given('I have completed a request') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I expand the application') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I enter review details') do
  pending # Write code here that turns the phrase above into concrete actions
end
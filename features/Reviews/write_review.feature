Feature: Leave a review
  As a user
  So that I can evaluate the user
  I want to leave a review for the user

# Scenario: Write a review
#     Given I am on the "My Requests" page
#     And I can see my completed requests
#     When I follow "Leave a review"
#     Then I follow "Help with Gardening"
#     Then I follow "Leave a Review"
#     And I fill in "Rating" with "5"
#     And I fill in "Comment" with "Great experience!"
#     And I press "Submit Review"
#     Then I should see "Review was successfully created."

  Scenario: Leave a review for a user
    # Given I am logged in as a user
    # And there is a user named "John Doe"
    # When I go to the new review page for "John Doe"
    Given I am on the "My Requests" page
    And I can see my completed requests
    When I follow "Leave a review"
    And I fill in "Rating" with "5"
    And I fill in "Comment" with "Great experience!"
    And I press "Submit Review"
    Then I should see "Review was successfully created."
    And I should see "My Reviews"
    And I should see "Great experience!"
    And I should see "Edit"

  Scenario: Edit a review
    # Given I am logged in as a user
    # And there is a user named "John Doe"
    # And I have written a review for "John Doe" with "Great experience!" and rating "5"
    # When I go to the reviews index page
    Given I am on the "My Reviews" page
    And I have written a review for "John Doe" with "Greate experience!" and rating "5"
    And I click on "Edit" for the review
    And I fill in "Comment" with "Updated review!"
    And I press "Update Review"
    Then I should see "Review was successfully updated."
    And I should see "Updated review!"


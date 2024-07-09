Feature: Leave a review
  As a user
  So that I can evaluate the user
  I want to leave a review for the user

Background:
  Given I am logged in

  Scenario: Leave a review for a user
    Given I am on the "My Requests" page
    # And I have a completed request
    When I follow "Leave a review"
    And I fill in "Rating" with "5"
    And I fill in "Comment" with "Great experience!"
    And I press "Submit Review"
    Then I should see "Review was successfully created."
    And I should see "My Reviews"
    And I should see "Great experience!"
    And I should see "Edit"

  Scenario: Edit a review
    When I am on the "reviews" page
    And I have written a review for "Charlie Lee" with "Great experience!" and rating "5"
    And I click on "Edit" for the review
    And I change the rating in "Rating" to "4"
    And I change the text in "Comment" to "Updated review!"
    And I press "Update Review"
    Then I should see "Review was successfully updated."
    And I should see "Updated review!"


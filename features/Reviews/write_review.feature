# Feature: Leave a review
#   As a user
#   So that I can evaluate the user
#   I want to leave a review for the user
#
# Background:
#   Given I am logged in
#
# Scenario: Leave a review for a volunteer
#   Given there is a user named "Volunteer User"
#   When I am on the "My Requests" page
#   And I have a completed request
#   When I click on the request
#   And I click on "Leave a Review"
#   And I fill out the review form with rating 5 and comment "Great job!"
#   And I press "Submit Review"
#   Then a review with rating 5 and comment "Great job!" should be created for "Volunteer User"

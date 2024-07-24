Feature: Show More Details
  As a user
  I want to see more details about a request
  So that I an have all the necessary information


Background:
    Given there is a registered user on the app
    And there is a request to be applied for
          
#Happy Case
  Scenario: View details of a specific request
    Given I am on the "home" page
    When I click on the request
    Then I should see 'Need someone to walk my dog for an hour every afternoon'

#Sad Case
Scenario: The request is deleted as I navigate to it
    Given I am on the "home" page
    When the request is deleted
    And I click on the request
    Then I should see "This request does not exist"

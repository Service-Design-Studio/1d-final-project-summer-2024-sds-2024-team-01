Feature: Delete Request
  As a user
  I want to be able to delete a request
  So that I can remove unwanted requests

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And I have a request
    
  Scenario: Delete a request successfully
    Given I am on the "requests" page
    When I follow "Test" request link
    And I click on "Delete" button
    Then I should see a message "Request deleted successfully"
    And the request with title "Test" should not exist
    
    Scenario: Delete a request successfully
        Given I am on the "requests" page
        And I have a request
        When I follow 

  Scenario: Delete a request that does not exist
    Given I am on the "requests" page
    When I attempt to delete a non-existent request
    Then I should see an error message "Request not found"

  Scenario: Delete a request with invalid permissions
    Given I am logged in as a different user
    And I have a request with the following details:
      | title   | description   | category   | status   |
      | Test    | Test request  | Test       | pending  |
    When I follow "Test" request link
    And I click on "Delete" button
    Then I should see an error message "You do not have permission to delete this request"

  Scenario: Attempt to delete a request when not logged in
    Given I am not logged in
    When I attempt to delete a request
    Then I should be redirected to the login page

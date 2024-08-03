Feature: View Requests
  As a volunteer
  So that I can view requests made by users
  I want to see the available requests made by the users

  Background: 
    Given there is a registered user on the app

  # Happy Path Scenarios
  Scenario: View requests
    Given there is a request to be applied for
    And I have an account
    When I login       
    And I am on the 'home' page
    Then I should see 'Test Request to Apply'

  # View requests as a non logged in user
  Scenario: View requests while not logged in
    Given there is a request to be applied for
    And I have an account
    When I am on the 'home' page
    Then I should see 'Test Request to Apply'

 # Sad Path Scenarios
  Scenario: No requests available 
    Given I am on the 'home' page
    Then I should not see 'Test Request to Apply'


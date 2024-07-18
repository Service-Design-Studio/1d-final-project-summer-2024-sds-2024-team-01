Feature: View Requests
  As a volunteer
  So that I can view requests made by users
  I want to see the available requests made by the users

  # Happy Path Scenarios
  Scenario: View requests
      Given I have an account
      And I login       
    When I am on the Ring of Reciprocity requests page
    Then I should see a list of requests

  # View requests as a non logged in user
  Scenario: View requests while not logged in
    Given I am on the Ring of Reciprocity requests page
    Then I should see a list of requests

 # Sad Path Scenarios
Scenario: No requests available 
  Given I have an account
  And I login       
    When I can see no requests available
    Then I should see a message indicating no requests are currently available


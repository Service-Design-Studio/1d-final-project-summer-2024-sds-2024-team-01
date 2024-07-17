Feature: View Requests
  As a volunteer
  So that I can view requests made by users
  I want to see the available requests made by the users

Background: 
          Given I have an account
          And I login       
          
  # Happy Path Scenarios
  Scenario: View requests
    Given I am on the Ring of Reciprocity requests page
    Then I should see a list of requests

 # Sad Path Scenarios
Scenario: No requests available 
    Given I can see no requests available
    Then I should see a message indicating no requests are currently available


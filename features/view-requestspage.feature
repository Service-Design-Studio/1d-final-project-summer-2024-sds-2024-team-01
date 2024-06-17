# view_requests.feature

Feature: View details of different user requests
  As a volunteer
  So that I can apply for different volunteer jobs
  I want to be able to view the different requests made by the users

  Scenario: View user requests on requests page
    Given I am on Ring of Reciprocity requests page
    When I scroll
    Then I should be able to see 2 full view and 2 partial view of user requests
    When I click on 1 of the requests card
    Then I should be brought to another page that shows me a full description of the requests posted by the user

  Scenario: View user requests on requests page (unsuccessful)
    Given I am on Ring of Reciprocity requests page
    When I scroll down, but there are no requests available
    Then I should see a message indicating no requests are currently available

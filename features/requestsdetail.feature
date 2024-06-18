Feature: Show more details on the request
As a volunteer 
So that I can fully understand the detail of the request
I want to be able to view the full description of the details made by the requester

Scenario: View details of a request by clicking on a request card (Happy Path)
    Given I am on the Ring of Reciprocity requests page
    When I click on a seed request
    Then I should be brought to another page that shows me a full description of the request post by the user
    And I should see the user's contact information
    And I should see the date the request was posted

Scenario: View details of a request by clicking on a request card with no details available (Sad Path)
    Given I am on the Ring of Reciprocity requests page
    When I click on a request card
    Then I should see a message indicating that the request details are not available
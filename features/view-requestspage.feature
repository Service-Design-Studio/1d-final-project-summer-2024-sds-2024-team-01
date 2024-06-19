Feature: View Requests
  As a user
  So that I can ask for help
  I want to be able to view, create and manage the requests

  Background: Sign in with valid acct
    Given I am logged in as "alice.smith@example.com" with nric "S1234567A"
     

  # Happy Path Scenarios
  Scenario: View requests
    Given I am on the Ring of Reciprocity requests page
    Then I should see the following:
      | Title               | Category    | Location                     | Date       | Number of Pax | Duration | Reward | Created by | Details           |
      | Dog Walking         | Pet Care    | POINT (34.052235 -90.0)      | 2024-07-02 | 1             | 1        | $20    | 2          | Show more details |
      | Grocery Shopping    | Errands     | POINT (51.507351 -0.127758)  | 2024-07-03 | 1             | 2        | £30    | 3          | Show more details |
      | Moving Assistance   | Moving      | POINT (48.856613 2.352222)   | 2024-07-04 | 3             | 5        | €100   | 4          | Show more details |
      | Painting Job        | Household   | POINT (35.689487 90.0)       | 2024-07-05 | 2             | 4        | ¥5000  | 5          | Show more details |
      | Car Wash            | Automotive  | POINT (37.774929 -90.0)      | 2024-07-06 | 1             | 1        | $30    | 6          | Show more details |
      | Babysitting         | Childcare   | POINT (55.755825 37.617298)  | 2024-07-07 | 1             | 5        | 2000₽  | 7          | Show more details |
      | Tutoring            | Education   | POINT (40.416775 -3.70379)   | 2024-07-08 | 1             | 2        | €50    | 8          | Show more details |
      | Tech Support        | IT          | POINT (39.904202 90.0)       | 2024-07-09 | 1             | 1        | ¥200   | 9          | Show more details |
      | Photography         | Photography | POINT (52.520008 13.404954)  | 2024-07-10 | 1             | 3        | €150   | 10         | Show more details |
    And see that there are 9 requests

  #Scenario: Sort requests ((date))
  #  Given I have request titled "Help with Gardening", date " 2024-07-01" and request titled "Dog Walking", date " 2024-07-02 "
  #  When I click on the "Date" header
  #  Then I should see "Help with Gardening" before "Dog Walking"

  Scenario: Create request
    Given I have no requests
    When I follow "Create Request" 
    And I fill in "Title" with "Help with Gardening"
    And I fill in "Category" with "Gardening"
    And I fill in "Location" with "POINT (40.712776 -74.005)
    And I fill in "Date" with "2024-07-01"
    And I fill in "Number of Pax" with "2"
    And I fill in "Duration" with "3"
    And I fill in "Reward" with "$50"
    And I fill in "Details" with "Show more details"
    And I press "Create Request"
    Then I should see "Request was successfully created."
    Then I should see "Cooking Dinner" in the table of requests

Scenario: Edit request
    Given I have a request titled "Help with Gardening"
    When I follow "Edit" for "Help with Gardening"
    And I fill in "Title" with "Gardening Help"
    And I press "Update Request"
    Then I should see "Request was successfully updated."
    Then I should see "Gardening Help" in the table of requests

    Scenario: Delete request
    Given I have a request titled "Help with Gardening"
    When I follow "Delete" for "Help with Gardening"
    Then I should see "Request was successfully deleted."
    Then I should not see "Help with Gardening" in the table of requests

    Scenario: Show request
    Given I have a request titled "Help with Gardening"
    When I follow "Show more details" for "Help with Gardening"
    Then I should see "Help with Gardening" on the request details page
    And I should see "Description" with "Looking for someone to help with my backyard garden"

Scenario: Go to create request
    Given I have no requests
    When I press "Create Request" 

# Sad Path Scenarios
Scenario: View user requests on the requests page with no requests available
    Given I can see no seed requests available
    Then I should see a message indicating no requests are currently available


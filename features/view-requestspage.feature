Feature: View Requests
  As a user
  So that I can ask for help
  I want to be able to view, create and manage the requests

  Background: Sign in with valid acct
    Given I am logged in as "alice.smith@example.com" with nric "S1234567A"
     

  # Happy Path Scenarios
  Scenario: View requests
    Given I am on the Ring of Reciprocity requests page
    # Then I should see the following:
    #   | Title               | Category    | Location                     | Date       | Number of Pax | Duration | Reward | Created by | Details           |
    #   | Help with Gardening |Gardening    |	POINT (40.712776 -74.005974) |2024-07-01  | 2             | 3        | $50    | 1          | Show more details |
    #   | Dog Walking         | Pet Care    | POINT (34.052235 -90.0)      | 2024-07-02 | 1             | 1        | $20    | 2          | Show more details |
    #   | Grocery Shopping    | Errands     | POINT (51.507351 -0.127758)  | 2024-07-03 | 1             | 2        | £30    | 3          | Show more details |
    #   | Moving Assistance   | Moving      | POINT (48.856613 2.352222)   | 2024-07-04 | 3             | 5        | €100   | 4          | Show more details |
    #   | Painting Job        | Household   | POINT (35.689487 90.0)       | 2024-07-05 | 2             | 4        | ¥5000  | 5          | Show more details |
    #   | Car Wash            | Automotive  | POINT (37.774929 -90.0)      | 2024-07-06 | 1             | 1        | $30    | 6          | Show more details |
    #   | Babysitting         | Childcare   | POINT (55.755825 37.617298)  | 2024-07-07 | 1             | 5        | 2000₽  | 7          | Show more details |
    #   | Tutoring            | Education   | POINT (40.416775 -3.70379)   | 2024-07-08 | 1             | 2        | €50    | 8          | Show more details |
    #   | Tech Support        | IT          | POINT (39.904202 90.0)       | 2024-07-09 | 1             | 1        | ¥200   | 9          | Show more details |
    #   | Photography         | Photography | POINT (52.520008 13.404954)  | 2024-07-10 | 1             | 3        | €150   | 10         | Show more details |
    And see that there are 10 requests

  #Scenario: Sort requests ((date))
  #  Given I have request titled "Help with Gardening", date " 2024-07-01" and request titled "Dog Walking", date " 2024-07-02 "
  #  When I click on the "Date" header
  #  Then I should see "Help with Gardening" before "Dog Walking"

  Scenario: Create request
    Given I have no requests
    When I follow "New Request"
    And I fill in "title" with "Help with Gardening"
    And I fill in "description" with "Looking for someone to help with my backyard garden"
    And I fill in "thumbnail" with "https://example.com/thumbnails/gardening.jpg"
    And I fill in "category" with "Gardening"
    And I fill in "location" with "POINT (40.712776 -74.005)"
    And I fill in "date" with "2024-07-01"
    And I fill in "number_of_pax" with "2"
    And I fill in "duration" with "3"
    And I fill in "reward" with "$50"
    And I fill in "reward_type" with "Cash"
    And I press "Create"
    Then I should see "Request was successfully created."
    And I should see "Help with Gardening"
   

  
  Scenario: Show request
    Given I have a request titled "Help with Gardening"
    When I follow "Show more details" for "Help with Gardening"
    Then I should see "Help with Gardening" on the request details page
    And I should see "Description" with "Looking for someone to help with my backyard garden"

  Scenario: Edit request
    Given I have a request titled "Help with Gardening"
    When I follow "Edit this request" for "Help with Gardening"
    And I fill in "Title" with "Gardening Help"
    And I press "Update Request"
    Then I should see "Request was successfully updated."
    And I follow "Back to requests"
    Then I should see "Gardening Help" in the table of requests

  Scenario: Delete request
    Given I have a request titled "Help with Gardening"
    When I follow "Destroy this request" for "Help with Gardening"
    Then I should see "Request was successfully deleted."
    And I follow "Back to requests"
    Then I should not see "Help with Gardening" in the table of requests

  

# Sad Path Scenarios
Scenario: View user requests on the requests page with no requests available
    Given I can see no requests available
    Then I should see a message indicating no requests are currently available


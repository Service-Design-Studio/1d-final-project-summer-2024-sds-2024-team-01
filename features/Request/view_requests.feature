Feature: View Requests
  As a volunteer
  So that I can view requests made by users
  I want to see the available requests made by the users

  Background: Sign in with valid acct
    Given I am logged in as "alice.smith@example.com" with nric "S1234567A"
    

  # Happy Path Scenarios
  Scenario: View requests
    Given I am on the Ring of Reciprocity requests page
    Then I should see a list of requests
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
    # And see that there are 10 requests

 
 
# Sad Path Scenarios
Scenario: View user requests on the requests page with no requests available
    Given I can see no requests available
    Then I should see a message indicating no requests are currently available


Feature: View User Requests
  As a volunteer
  So that I can apply for different volunteer jobs
  I want to be able to view the different requests made by the users

  Background: requests have been added into the database
    Given the following requests exist:
    | Title               | Category  | Location                     | Date       | Number of Pax | Duration | Reward | Created by | Details           |
    |---------------------|-----------|------------------------------|------------|---------------|----------|--------|------------|-------------------|
    | Help with Gardening | Gardening | POINT (40.712776 -74.005974) | 2024-07-01 | 2             | 3        | $50    | 1          | Show more details |
    | Dog Walking         | Pet Care  | POINT (34.052235 -90.0)      | 2024-07-02 | 1             | 1        | $20    | 2          | Show more details |
    | Grocery Shopping    | Errands   | POINT (51.507351 -0.127758)  | 2024-07-03 | 1             | 2        | £30    | 3          | Show more details |
    | Moving Assistance   | Moving    | POINT (48.856613 2.352222)   | 2024-07-04 | 3             | 5        | €100   | 4          | Show more details |
    #| Painting Job        | Household | POINT (35.689487 90.0)       | 2024-07-05 | 2             | 4        | ¥5000  | 5          | Show more details |
    #| Car Wash            | Automotive| POINT (37.774929 -90.0)      | 2024-07-06 | 1             | 1        | $30    | 6          | Show more details |
    #| Babysitting         | Childcare | POINT (55.755825 37.617298)  | 2024-07-07 | 1             | 5        | 2000₽  | 7          | Show more details |
    #| Tutoring            | Education | POINT (40.416775 -3.70379)   | 2024-07-08 | 1             | 2        | €50    | 8          | Show more details |
    #| Tech Support        | IT        | POINT (39.904202 90.0)       | 2024-07-09 | 1             | 1        | ¥200   | 9          | Show more details |
    #| Photography         | Photography| POINT (52.520008 13.404954) | 2024-07-10 | 1             | 3        | €150   | 10         | Show more details |
    And I am on the Ring of Reciprocity request page
    Then 4 seed requests should exist

  # Happy Path Scenarios
  Scenario: View user requests on the requests page 
    #when I am at the request page, then I should be able to see 4 seed requests on that page, where I can see the 
    Given I am on the Ring of Reciprocity requests page
    When I scroll down
    Then I should see at 2 full view of the requests overview
    | Grocery Shopping    | Errands   | POINT (51.507351 -0.127758)  | 2024-07-03 | 1             | 2        | £30    | 3          | Show more details |
    | Moving Assistance   | Moving    | POINT (48.856613 2.352222)   | 2024-07-04 | 3             | 5        | €100   | 4          | Show more details |
    Then I should see 2 partial view of the requests overview
    | Painting Job        | Household | POINT (35.689487 90.0)       | 2024-07-05 | 2             | 4        | ¥5000  | 5          | Show more details |
    | Car Wash            | Automotive| POINT (37.774929 -90.0)      | 2024-07-06 | 1             | 1        | $30    | 6          | Show more details |
    And I should see a message indicating the total number of requests available

  # Sad Path Scenarios
  Scenario: View user requests on the requests page with no requests available 
    Given I am on the Ring of Reciprocity requests page
    When I scroll down
    Then I should see a message indicating no requests are currently available

  

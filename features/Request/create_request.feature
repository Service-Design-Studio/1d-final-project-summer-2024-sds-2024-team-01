
Feature: Create Requests
  As a user
  So that I can ask for something
  I want to create a request
 
Feature: Creating Requests

  # Happy Case
  Scenario: Create request with valid data
    Given I want to make new requests
    When I fill in the following:
      | BannerPhoto                 |                                              |
      | Title                       | Help with Gardening                          |
      | Date                        | 01/07/2024                                   |
      | Category                    | Manual Labour                                |
      | Number of volunteers needed | 5                                            |
      | Start Time                  | 01:10 pm                                     |
      | End Time                    | 12:30 am                                     |
      | Description                 | Looking for someone to help with my backyard garden |
      | Incentive provided          | Money                                        |
      | Incentive                   | $30                                          |
    And I press "Create"
    Then I should see "Request was successfully created."
    When I follow "Back to requests"
    Then I should see "Help with Gardening"

  # Sad Case
  Scenario: Create request with invalid data
    Given I want to make new requests
    When I fill in the following:
      | BannerPhoto                 |                                |
      | Title                       | Help with Gardening            |
      | Date                        | 01/07/2024                     |
      | Category                    |                                |
      | Number of volunteers needed |                                |
      | Start Time                  |                                |
      | End Time                    |                                |
      | Description                 |                                |
      | Incentive                   |                                |
    And I press "Create"
    Then I should not see any new requests

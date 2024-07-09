
Feature: Create Requests
  As a user
  So that I can ask for something
  I want to create a request
  
#Happy Case
Scenario: Create request
    Given I want to make new requests
    # Then I fill in "title" with "Help with Gardening"
    # And I fill in "description" with "Looking for someone to help with my backyard garden"
    # And I fill in "thumbnail" with "https://example.com/thumbnails/gardening.jpg"
    # And I fill in "category" with "Gardening"
    # And I fill in "location" with "POINT (40.712776 -74.005)"
    # And I fill in "date" with "2024-07-01"
    # And I fill in "number_of_pax" with "2"
    # And I fill in "duration" with "3"
    # And I fill in "reward" with "$50"
    # And I fill in "reward_type" with "Cash"
    When I fill in the following: 
    | field         | value                                              |
    | title         | Help with Gardening                                |
    | description   | Looking for someone to help with my backyard garden|
    | thumbnail     | https://example.com/thumbnails/gardening.jpg       |
    | category      | Gardening                                          |
    | location      | POINT (40.712776 -74.005)                          |
    | date          | 2024-07-01                                         |
    | number_of_pax | 2                                                  |
    | duration      | 3                                                  |
    | reward        | $50                                                |
    | reward_type   | Cash                                               |
    And I press "Create"
    Then I should see "Request was successfully created."
    When I follow "Back to requests"
    Then I should see "Help with Gardening"

  

#Sad Case
Scenario: Create request with invalid data
Given I want to make new requests
When I fill in the following:
    | field         | value                             |
    | title         |                                   |  # Missing title
    | description   | Looking for help                  |  # Valid
    | thumbnail     | not-a-valid-url                   |  # Invalid URL
    | category      |                                   |  # Missing category
    | location      | POINT (invalid)                   |  # Invalid location
    | date          | invalid-date                      |  # Invalid date
    | number_of_pax | -1                                |  # Invalid number
    | duration      | 0                                 |  # Invalid duration
    | reward        | not-a-valid-amount                |  # Invalid reward
    | reward_type   | InvalidType                       |  # Invalid reward type
And I press "Create"
When I follow "Back to requests"
Then I should not see any new requests

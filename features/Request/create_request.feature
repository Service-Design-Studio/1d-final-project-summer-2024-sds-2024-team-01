
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
      | Duration                    | 5                                            |
      | Location                    | Singapore Zoo                                |
      | Description                 | Looking for someone to help with my backyard garden |
      | Incentive provided          | Money                                        |
      | Incentive                   | $30                                          |
    # When I fill in the title field with "Test Request"
    # And I selects the category as "Manual Labour"
    # And I fill in the date field with "01/07/2024"
    # And I fill in the number of volunteers needed field with "5"
    # And I fill in the start time field with "01:10 pm"
    # And I fill in the duration field with "5"
    # And I fill in the location field with "Singapore Zoo"
    # And I fill in the description field with "Looking for someone to help with my backyard garden"
    # And I fill in the incentive provided field with "Money"
    # And I fill in the incentive field with "$30"
  
    
    And I press "Create"
    Then I should see "Request was successfully created."
    When I follow "Back to requests"
    Then I should see "Help with Gardening"

  # Sad Case
  Scenario: Create request with invalid data
    Given I want to make new requests
    When I fill in the following:
      | BannerPhoto                 |                                              |
      | Title                       |                                              |
      | Date                        |                                              |
      | Category                    | Manual Labour                                |
      | Number of volunteers needed | 5                                            |
      | Start Time                  |                                              |
      | Duration                    | 5                                            |
      | Location                    |                                              |
      | Description                 |                                              |
      | Incentive provided          |                                              |
      | Incentive                   | $30                                          |
    And I press "Create"
    Then I should not see any new requests

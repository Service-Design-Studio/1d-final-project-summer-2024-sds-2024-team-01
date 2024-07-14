
Feature: Create Requests
  As a user
  So that I can ask for something
  I want to create a request

Background:
    Given I have an account
    And I login  

  # Happy Case
  Scenario: Create request with valid data
    Given I want to make new requests

    # When I fill in the "Title" with "Test Request"
    # And I click on "Category","Manual Labour"
    # And I fill in the "Date" with "01/07/2024"
    # And I fill in the "Number of volunteers needed" with "5"
    # And I fill in the "Start time" with "01:10 pm"
    # And I fill in the "Duration" with "5"
    # And I fill in the "Location" with "Singapore Zoo"
    # And I fill in the "Description" with "Looking for someone to help with my backyard garden"
    # And I fill in the "Incentive provided" with "Money"
    # And I fill in the "Incentive" with "$30"  
    # And I press "Create"
    # Then I should be able to see the request 
    # Then I should see "Request was successfully created."
    # Then I should see "Help with Gardening"

     Then I fill in the following details:
    | Field                           | Value                                               |
    | Title                           | Test Request                                        |
    | Category                        | Manual Labour                                       |
    | Date                            | 01/07/2024                                          |
    | Number of volunteers needed     | 5                                                   |
    | Start time                      | 01:10 pm                                            |
    | Duration                        | 5                                                   |
    | Location                        | Singapore Zoo                                       |
    | Description                     | Looking for someone to help with my backyard garden |
    | Incentive provided              | Money                                               |
    | Incentive                       | $30                                                 |
    When I press "Create"
    # Then I should be able to see the request
    And I should see "Request was successfully created."
    And I should see "Test Request"

  # Sad Case
  Scenario: Create request with invalid data
    Given I want to make new requests
  # When I fill in the "Title" with " "
  # And I click on "Category","Manual Labour"        
  #   And I fill in the "Date" with " "
  #   And I fill in the "Number of volunteers needed" with " "
  #   And I fill in the "Start time" with " "
  #   And I fill in the "Duration" with " "
  #   And I fill in the "Location" with " "
  #   And I fill in the "Description" with " "
  #   And I fill in the "Incentive provided" with " "
  #   And I fill in the "Incentive" with "$30"
  Then I fill in the following details:
    | Field                           | Value                                               |
    | Title                           |                                                     |
    | Category                        |                                                     |
    | Date                            |                                                     |
    | Number of volunteers needed     | 5                                                   |
    | Start time                      | 01:10 pm                                            |
    | Duration                        | 5                                                   |
    | Location                        | Singapore Zoo                                       |
    | Description                     |                                                     |
    | Incentive provided              | Money                                               |
    | Incentive                       |   $30                                               |
    And I press "Create"
    Then I should be returned back to new requests page
   
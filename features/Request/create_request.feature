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

     And I fill in the following details:
    | Field                           | Value                                               |
    | Title                           | Test Request                                        |
    | Category                        | Teaching                                       |
    | Date                            | 12/12/2024                                          |
    | Number of volunteers needed     | 5                                                   |
    | Start Time                      | 12:25                                            |
    | Duration                        | 5                                                   |
    | Location                        | POINT(1 1)                                       |
    | Description                     | Looking for someone to help with my backyard garden |
    | Incentive provided              | None                                               |
    | Incentive                       | None                                                 |
    When I click on "Create" button
    Then I should see "Request was successfully created."
   

  # Sad Case
  Scenario: Create request with invalid data
    Given I want to make new requests
  And I fill in the following details:
    | Field                           | Value                                               |
    | Title                           |                                                     |
    | Category                        |                                                     |
    | Date                            |             01-07-2024                              |
    | Number of volunteers needed     | 5                                                   |
    | Start time                      | 01:10 pm                                            |
    | Duration                        | 5                                                   |
    | Location                        | Singapore Zoo                                       |
    | Description                     |                                                     |
    | Incentive provided              | Money                                               |
    | Incentive                       |   $30                                               |
    When I click on "Create" button
    Then I should be returned back to new requests page
   

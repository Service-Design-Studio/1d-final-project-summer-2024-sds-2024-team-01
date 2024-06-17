Feature: Login functionality

  Scenario: Successful login with valid credentials
    Given I am on the login page
    When I enter "username" and "password"
    And I click the login button
    Then I should see the dashboard page

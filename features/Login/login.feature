Feature: Login
  As a user
  So that I can request for help
  I want to make an account

    Background:

  # Happy Case
  Scenario: Login with valid credentials
    Given I am on the login page
    When I enter the following credentials:
    | field         | value  |
    | Phone number  | 000    |
    | Password      | 123456 |
    And I click on "Login" button
    Then I should be brought to the request page

  # Sad Case
  Scenario: Login with invalid credentials
    Given I am on the login page
    When I enter the following credentials:
    | field         | value  |
    | Phone number  |        |
    | Password      |        |
    And I click on "Login" button
    Then I should see a message "Invalid Number or password."

    Scenario: Test login
        Given Roles are seeded
        And There should be 5 roles
        And I have an account
        When I login
        Then I should see "Signed in successfully."

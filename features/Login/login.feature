Feature: Login
  As a user
  So that I can request for help
  I want to make an account

  # Happy Case
  Scenario: Login with valid credentials
    Given I have an account
    When I login
    Then I should see "Signed in successfully."

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

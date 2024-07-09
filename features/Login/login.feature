Feature: Login
  As a user
  So that I can request for help
  I want to make an account

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
    When I enter " " for "Phone number "
    And I enter " " for "Password"
    And I click on "Log in" button
    Then I should see "Invalid Phone number or password."

Scenario: Test login
    Given I am logged in
    Then I should see "Signed in successfully."

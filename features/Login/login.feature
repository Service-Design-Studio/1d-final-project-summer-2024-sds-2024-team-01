Feature: Login
  As a user
  So that I can request for help
  I want to make an account

  # Happy Case
  Scenario: Login with valid credentials
    Given I am on the login page
    When I enter "000" for "Phone number"
    And I enter "123456" for "Password"
    And I click on "Log in" button
    Then I should be brought to the request page

  # Sad Case
  Scenario: Login with invalid credentials
    Given I am on the login page
    When I enter " " for "Phone number "
    And I enter " " for "Password"
    And I click on "Log in" button
    Then I should see "Invalid Phone number or password."

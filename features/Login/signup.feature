Feature: User Signup

  As a user
  So that I can have my own account
  I want to signup for the account

  # Happy Case
  Scenario: Signup with valid details 
    Given I am on the signup page
    When I fill in the following: 
      | field            | value            |
      | Full name        | Susan Tam        |
      | Phone number     | 98778888         |
      | Email            | susan@gmail.com  |
    And I click on Continue
    And I fill in the following: 
      | field            | value            |
      | Password         | 1234567890       |
      | Confirm Password | 1234567890       |
    And I click on Continue
    And I click on "Sign up!" button
    Then I should see a message "Welcome! You have signed up successfully."

  # Sad Case
  Scenario: Signup with invalid Full name
    Given I am on the signup page
    When I fill in the following:
      | field            | value            |
      | Full name        |                  |
      | Phone number     | 1234567890       |
      | Email            | susan@gmail.com  |
    And I click on Continue
    And I fill in the following:
      | field            | value            |
      | Password         | 1234567890       |
      | Confirm Password | 1234567890       |
    And I click on Continue
    And I click on "Sign up!" button
    Then I should see a message "Name can't be blank"

  Scenario: Signup with invalid phone number
    Given I am on the signup page
    When I fill in the following:
      | field            | value            |
      | Full name        | Susan Tam        |
      | Phone number     |                  |
      | Email            | susan@gmail.com  |
    And I click on Continue
    And I fill in the following:
      | field            | value            |
      | Password         | 1234567890       |
      | Confirm Password | 1234567890       |
    And I click on Continue
    And I click on "Sign up!" button
    Then I should see a message "Number Phone number can't be blank"

  Scenario: Signup with invalid email address
    Given I am on the signup page
    When I fill in the following:
      | field            | value            |
      | Full name        | Susan Tam        |
      | Phone number     | 1234567890       |
      | Email            |                  |
    And I click on Continue
    And I fill in the following:
      | field            | value            |
      | Password         | 1234567890       |
      | Confirm Password | 1234567890       |
    And I click on Continue
    And I click on "Sign up!" button
    Then I should see a message "Email can't be blank"

  Scenario: Signup with invalid password
    Given I am on the signup page
    When I fill in the following:
      | field            | value            |
      | Full name        | Susan Tam        |
      | Phone number     | 1234567890       |
      | Email            | susan@gmail.com  |
    And I click on Continue
    And I fill in the following:
      | field            | value            |
      | Password         |                  |
      | Confirm Password | 1234567890       |
    And I click on Continue
    And I click on "Sign up!" button
    Then I should see a message "Password can't be blank"

  Scenario: Signup with invalid confirm password
    Given I am on the signup page
    When I fill in the following:
      | field            | value            |
      | Full name        | Susan Tam        |
      | Phone number     | 1234567890       |
      | Email            | susan@gmail.com  |
    And I click on Continue
    And I fill in the following:
      | field            | value            |
      | Password         | 1234567890       |
      | Confirm Password |                  |
    And I click on Continue
    And I click on "Sign up!" button
    Then I should see a message "Password confirmation doesn't match Password"


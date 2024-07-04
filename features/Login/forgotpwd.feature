Feature: Forget Password
  As a user
  So that I can reset my password if I forget it
  I want to be able to request a password reset
 
  #Happy Case
  Scenario: Request password reset with valid email
    Given I am on the forget password page
    When I fill in "Email" with "user@example.com"
    And I click on "Send me reset password instructions"
    Then I should see a message "You will receive an email with instructions on how to reset your password in a few minutes."

  #Sad Case
  Scenario: Request password reset with invalid email
    Given I am on the forget password page
    When I fill in "Email" with "invalid@example.com"
    And I click on "Send me reset password instructions"
    Then I should see a message "Email not found"


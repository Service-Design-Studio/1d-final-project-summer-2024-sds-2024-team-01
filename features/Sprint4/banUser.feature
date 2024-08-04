Feature: Ban User who got reported
    As an admin
    So that I can keep the webapp safe
    I want to be able to ban and unban users that are reported

Background:
    Given I have an account
    And I login as admin

Scenario: Ban User
    Given I am on the "Ban User" page
    And there is User One
    When I click on "Ban" button
    Then I should see a message "User One has been banned."

Scenario: Unban User
    Given I am on the "Unban User" page
    And there is User Two
    When I click on "Unban" button
    Then I should see a message "User Two has been unbanned."

Scenario: Cancel User 
    Given I am on the "Ban User" page
    And there is User One
    When I click on "Cancel" button
    Then I should see a message "No ban placed on User One"
    
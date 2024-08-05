Feature: Ban User who got reported
    As an admin
    So that I can keep the webapp safe
    I want to be able to ban and unban users that are reported

Background:
    Given I have an admin account
    Then I login as an admin

Scenario: Ban User
    Given I am on the "Ban User" page
    And there is "Alice Smith"
    When I click on "Ban" button
    Then I should see a message "Alice Smith has been banned."

Scenario: Unban User
    Given I am on the "Unban User" page
    And there is "Alice Smith"
    When I click on "Unban" button
    Then I should see a message "Alice Smith has been unbanned."

Scenario: Cancel User 
    Given I am on the "Ban User" page
    And there is "Bob Dylan"
    When I click on "Cancel" button
    Then I should see a message "Bob Dylan placed on User One"
    
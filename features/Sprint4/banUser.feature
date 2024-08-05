Feature: Ban User who got reported
    As an admin
    So that I can keep the webapp safe
    I want to be able to ban and unban users that are reported

Background:
    Given I have an admin account
    Then I login as admin

Scenario: Ban User
    Given I am on "Ban User" page
    And there is "Alice Smith"
    When I click on "Ban" button for user "Alice Smith" 
    # Then I should see a message "Ban placed successfully."

Scenario: Unban User
    Given I am on "Unban User" page
    And there is "Alice Smith"
    When I click on "Unban" button for user "Alice Smith"
    # Then I should see a message "Ban placed successfully."

Scenario: Cancel User 
    Given I am on "Ban User" page
    And there is "Bob Dylan"
    When I click on "Cancel" button for user "Bob Dylan"
    # Then I should see a message "No ban placed."
    


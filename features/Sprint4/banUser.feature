Feature: Ban User who got reported
    As an admin
    So that I can keep the webapp safe
    I want to be able to ban and unban users that are reported

Background:
    Given I have an admin account
    Then I login as admin

Scenario: Ban User
    Given I am on "Ban User" page
    And there is "Alice Smith" details
    And I click "Alice Smith" details
    Then there is more details of "Alice Smith"
    Then I am on "Ban User" page
    When I click on "Ban" button for user "Alice Smith" 
    Then I should see the message "Successfully banned"

Scenario: Unban User
    Given I am on "Unban User" page
    And there is "Jane Doe" details
    And I click "Jane Doe" details
    Then there is more details of "Jane Doe"
    Then I am on "Ban User" page
    When I click on "Unban" button for user "Jane Doe"
    Then I should see the message "Successfully unbanned."

Scenario: Cancel User 
    Given I am on "Ban User" page
    And there is "Bob Dylan" details
    And I click "Bob Dylan" details
    Then there is more details of "Bob Dylan"
    Then I am on "Ban User" page
    When I click on "Cancel" button for user "Bob Dylan"
    Then I should see the message "Successfully cancelled"
    


Feature: Approving corporations and charities as an Administrator
    As an administrator
    So that requesters have a higher chance of receiving volunteering help
    I want to be able to approve of companies and charities who have registered

Background:
    Given I have an admin account
    Then I login as admin
    Then there are companies and charities for me to approve

Scenario: Approve charities
    Given I am on "Approve Inactive Charities" page
    And I click on "Tasty Charity" details
    Then I should see more details of "Tasty Charity"
    Then I am on "Approve Inactive Charities" page
    When I click on "Approve" button for charity "Tasty Charity"
    Then I should see "Charity approved successfully and email sent."

Scenario: Disable charities
    Given I am on "Approve Active Charities" page
    And I click on "Delightful Charity" details
    Then I should see more details of "Delightful Charity"
    Then I am on "Approve Active Charities" page
    When I click on "Disable" button for charity "Delightful Charity"
    Then I should see "Charity disabled successfully."

Scenario: Rejected charities
    Given I am on "Approve Inactive Charities" page
    And I click on "Inexpensive Charity" details
    Then I should see more details of "Inexpensive Charity"
    Then I am on "Approve Inactive Charities" page
    When I click on "Reject" button for charity "Inexpensive Charity"
    Then I should see "Charity rejected successfully."

Feature: Approving corporations and charities as an Administrator
    As an administrator
    So that requesters have a higher chance of receiving volunteering help
    I want to be able to approve of companies and charities who have registered

Background:
    Given I login as an admin
    And I login as admin

Scenario: Approve companies
    Given I am on the "Approve Inactive Companies" page
    And I click on "friendlyCompany" 
    Then I should see more details of company
    Then I am on the "Approve Inactive Companies" page
    When I click on "Approve" button
    Then I should see message "Company has been approved and email sent."

Scenario: Disable companies
    Given I am on the "Approve Active Companies" page
    And I click on "friendlyCompany" 
    Then I should see more details of company
    Then I am on the "Approve Inactive Companies" page
    When I click on "Disable" button
    Then I should see message "Company has been disabled."

Scenario: Reject Companies 
    Given I am on the "Approve Rejected Companies" page
    And I click on "friendlyCompany" 
    Then I should see more details of company
    Then I am on the "Approve Inactive Companies" page
    When I click on "Reject" button
    Then I should see message "Company has been rejected."

########################################################################

Scenario: Approve charities
    Given I am on the "Approve Inactive Charities" page
    And I click on "inexpensive charity"
    Then I should see more details of charity
    Then I am on the "Approve Inactive Charities" page
    When I click on "Approve" button
    Then I should see message "Charity approved successfully and email sent."

Scenario: Disable charities
    Given I am on the "Approve Active Charities" page
    And I click on "inexpensive charity"
    Then I should see more details of charity
    Then I am on the "Approve Inactive Charities" page
    When I click on "Disable" button
    Then I should see message "Charity disabled successfully."

Scenario: Rejected charities
    Given I am on the "Approve Rejected Charities" page
    And I click on "inexpensive charity"
    Then I should see more details of charity
    Then I am on the "Approve Inactive Charities" page
    When I click on "Reject" button
    Then I should see message "Charity rejected successfully."

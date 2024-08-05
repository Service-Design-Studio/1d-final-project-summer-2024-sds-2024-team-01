Feature: Approving corporations and charities as an Administrator
    As an administrator
    So that requesters have a higher chance of receiving volunteering help
    I want to be able to approve of companies and charities who have registered

Background:
    Given I have an admin account
    Then I login as an admin
    Then there are companies and charities for me to approve
    

Scenario: Approve companies
    Given I am on "Approve Inactive Companies" page
    And I click on "FriendlyCompany" 
    Then I should see more details of "FriendlyCompany"
    Then I am on "Approve Inactive Companies" page
    When I click on "Approve" button for company "FriendlyCompany"
    Then I should see message "Company has been approved and email sent."
    Then sleep 
Scenario: Disable companies
    Given I am on "Approve Active Companies" page
    And I click on "LoveCompany" 
    Then I should see more details of "LoveCompany"
    Then I am on "Approve Inactive Companies" page
    When I click on "Disable" button for company "LoveCompany"
    Then I should see message "Company has been disabled."

Scenario: Reject Companies 
    Given I am on "Approve Inactive Companies" page
    And I click on "GraceCompany" 
    Then I should see more details of "GraceCompany"
    Then I am on "Approve Inactive Companies" page
    When I click on "Reject" button for company "GraceCompany"
    Then I should see message "Company has been rejected."

########################################################################

Scenario: Approve charities
    Given I am on "Approve Inactive Charities" page
    And I click on "Tasty Charity"
    Then I should see more details of "Tasty Charity"
    Then I am on "Approve Inactive Charities" page
    When I click on "Approve" button for charity "Tasty Charity"
    Then I should see message "Charity approved successfully and email sent."

Scenario: Disable charities
    Given I am on "Approve Active Charities" page
    And I click on "Delightful Charity"
    Then I should see more details of "Delightful Charity"
    Then I am on "Approve Inactive Charities" page
    When I click on "Disable" button for charity "Delightful Charity"
    Then I should see message "Charity disabled successfully."

Scenario: Rejected charities
    Given I am on "Approve Inactive Charities" page
    And I click on "Inexpensive Charity"
    Then I should see more details of "Inexpensive Charity"
    Then I am on "Approve Inactive Charities" page
    When I click on "Reject" button for charity "Inactive Charity"
    Then I should see message "Charity rejected successfully."

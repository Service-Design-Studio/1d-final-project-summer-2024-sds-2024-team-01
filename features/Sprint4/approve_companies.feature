Feature: Approving corporations and charities as an Administrator
    As an administrator
    So that requesters have a higher chance of receiving volunteering help
    I want to be able to approve of companies and charities who have registered

Background:
    Given I have an admin account
    Then I login as admin
    Then there are companies and charities for me to approve
    
Scenario: Approve companies
    Given I am on "Approve Inactive Companies" page
    And I click on "FriendlyCompany" details
    Then I should see more details of "FriendlyCompany"
    Then I am on "Approve Inactive Companies" page
    When I click on "Approve" button for company "FriendlyCompany"
    Then I should see "Company has been approved and email sent."
  
Scenario: Disable companies
    Given I am on "Approve Active Companies" page
    And I click on "LoveCompany" details
    Then I should see more details of "LoveCompany"
    Then I am on "Approve Active Companies" page
    When I click on "Disable" button for company "LoveCompany"
    Then I should see "Company has been disabled."

Scenario: Reject Companies 
    Given I am on "Approve Inactive Companies" page
    And I click on "GraceCompany" details
    Then I should see more details of "GraceCompany"
    Then I am on "Approve Inactive Companies" page
    When I click on "Reject" button for company "GraceCompany"
    Then I should see "Company has been rejected."

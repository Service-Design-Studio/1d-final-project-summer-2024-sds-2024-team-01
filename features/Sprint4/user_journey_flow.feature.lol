# Sign up as a corporation
Feature: Signing up as a charity
    As a charity in need of more volunteers
    So that I can obtain more manpower for my beneficiaries
    I want to be able to create an account to create more volunteering opportunities for my employees

    Scenario: Register as a charity
        Given I am on the 'register' page
        And I click on Charity
        When I enter my charity details 
        And click on "Sign up!"
        Then I should see "Thank you for signing up with Ring of Reciprocity."


Feature: Signing up as a corporation
    As a corporate volunteer manager
    So that I can obtain more opportunities to claim tax relief from IRAS
    I want to be able to create an account to create more volunteering opportunities for my employees

    Scenario: Register as a corporation
        Given I am on the 'register' page
        And I click on Corporate
        When I enter my company details 
        And click on "Sign up!"
        Then I should see "Thank you for signing up with Ring of Reciprocity."

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

Feature: Create request as a charity

Feature: Generating code for employees
    As a corporate volunteer manager
    So that I can allow my employees to register and be associated with my company
    I want to be able to generate a code and provide it to them

    Background:
        Given I am logged in as a cvm

    Scenario: Copy code to clipboard
        Given I am on the cvm dashboard
        When I click on the copy code button
        Then the company code should be copied to my clipboard

    Scenario: Regenerate code
        Given I am on the cvm dashboard
        When I click on the regenerate code button
        Then I should receive a new company code

    Scenario: Regenerate code
        Given I am on the cvm dashboard
        When I click on the regenerate code button
        Then I should receive a new company code



Feature: Signing up as a corporate volunteer
    As a corporate volunteer 
    So that I can obtain more volunteering opportunities for my company to claim tax relief
    I want to be able to register my account under the company

    Scenario:
        Given I am on the 'register' page
        And I click on 'User'
        When I enter the details including the code associated with my company
        And I click on 'Sign Up!'
        Then I should see 'Welcome to Ring of Reciprocity'

Feature: Viewing requests as a corporate volunteer
    As a corporate volunteer 
    So that I can help my company claim tax relief and to volunteer to help someone in need
    I want to be able to see requests from registered IPCs that my company has approved of

    Scenario:
        Given I am logged in as a corporate volunteer
        When I am on the 'home' page
        Then I should not see 'Paid Request' #compensation
        Then I should not see 'Non IPC Request' #only registered charities, not any

Feature: Viewing of corporate volunteer applicants
    As a charity
    So that I can distinguish a corporate volunteer from a normal one
    I want to be able to see an indicator that differentiates the applicants

    Background:
        Given I have an account
        And I login 
        And there is a registered user on the app
        And I have a request
        And there is an application for my request
        And there is an application for my request from a corporate user

    Scenario:
        Given I am on the 'myrequests' page
        When I expand the request
        Then I should see '2' applicants
        And I should see '1' corporate volunteer applicant

# CVM Perspective alr
Feature: Viewing of statistics
    As a corporate volunteer manager
    So that I can keep track on who is volunteering
    I want to be able to see the number of hours that each employee is volunteering for 

    Background:
        Given Willing Hearts is registered with the application
        And Willing Hearts is registered with my company
        And Jason has completed a request
        And Alice has completed a request
        And Bob has completed a request
        
    Scenario:
        Given I have a cvm account
        When I login as a cvm
        Then I should 8 hours volunteered this week

    Scenario: Viewing of employee statistics
        Given I have a cvm account
        When I login as a cvm
        Then I should see '3' under top employees

    Scenario: Viewing of volunteering statistics
        Given I have a cvm account
        When I login as a cvm
        Then I should see 'Jason' before 'Alice' under top employees
        And I should see 'Alice' before 'Bob' under top employees

    Scenario: Viewing of charities registered with my company
        Given I have a cvm account
        When I login as a cvm
        Then I should see 'Willing Hearts'

Feature: Managing employees 

    Background:
        Given I have a cvm account
        And I login as a cvm
        And Jason's account is deactivated

    Scenario: Deactivating an account
        Given I click 'Manage Employees'
        And I deactivate Alice's account
        Then Alice should not be able to log in

    Scenario: Activating an account
        Given I click 'Manage Employees'
        And I activate Jason's account
        Then Jason should be able to log in

Feature: Managing Charities

    Background:
        Given I have a cvm account
        And I login as a cvm
        And Willing Hearts is registered with the application

    Scenario: Adding a charity without pressing save
        Given I click 'Manage Charities'
        And I click on 'Willing Hearts'
        When I am on the cvm dashboard
        Then I should not see 'Willing Hearts'

    Scenario: Adding a charity 
        Given I click 'Manage Charities'
        And I click on 'Willing Hearts'
        When I click on 'Save'
        And I am on the cvm dashboard
        Then I should see 'Willing Hearts'
        
    Scenario: Remove a charity without pressing save
        Given Willing Hearts is registered with my company
        And I click 'Manage Charities'
        When I click on 'Willing Hearts'
        And I am on the cvm dashboard
        Then I should see 'Willing Hearts'

    Scenario: Remove a charity 
        Given Willing Hearts is registered with my company
        And I click 'Manage Charities'
        When I click on 'Willing Hearts'
        And I click on 'Save'
        And I am on the cvm dashboard
        Then I should see 'Willing Hearts'

Feature: Generate Report
    Scenario: Generating a report


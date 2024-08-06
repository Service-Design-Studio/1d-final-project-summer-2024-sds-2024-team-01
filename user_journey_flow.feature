Feature: Signing up as a charity
    As a charity in need of more volunteers
    So that I can obtain more manpower for my beneficiaries
    I want to be able to create an account to create more volunteering opportunities for my employees

    Scenario: Register as a charity
        Given I am on the 'register' page
        And I click on Charity
        When I enter my charity details 
        And I click on "Sign up!"
        Then I should see "Thank you for signing up with Ring of Reciprocity."

    Scenario: Upload non pdf file 
        Given I am on the 'register' page
        And I click on Charity
        When I enter my charity details with a document in the wrong format
        And I click on "Sign up!"
        Then I should see "Failed to register"

Feature: Signing up as a corporation
    As a corporate volunteer manager
    So that I can obtain more opportunities to claim tax relief from IRAS
    I want to be able to create an account to create more volunteering opportunities for my employees

    Scenario: Register as a corporation
        Given I am on the 'register' page
        And I click on Corporate
        When I enter my company details 
        And I click on "Sign up!"
        Then I should see "Thank you for signing up with Ring of Reciprocity."

    Scenario: Upload non pdf file 
        Given I am on the 'register' page
        And I click on Corporate
        When I enter my company details with a document in the wrong format
        And I click on "Sign up!"
        Then I should see "Failed to register"

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
  As a user
  So that I can receive help
  I want to create a request

Background:
    Given I have an account
    And I login  

  Scenario: Create request with valid data
    Given I want to make new requests

     And I fill in the following details:
    | Field                           | Value          |
    | Title                           | Test Request   |
    | Category                        | Youth Services |
    | Date                            | 2024-12-12     |
    | Number of volunteers needed     | 5              |
    | Start time                      | 12:00          |
    | Duration                        | 5              |
    | Location                        | POINT(1 1)     |
    | Description                     | Looking for someone to help with my backyard garden |
    | Incentive provided              | Money          |
    | Incentive                       | $400           |
    When I click on "Create" button
    Then I should see "Request was successfully created."
   

  Scenario: Create request with invalid data
    Given I want to make new requests
  And I fill in the following details:
    | Field                           | Value         |
    | Title                           |               |
    | Category                        |               |
    | Date                            | 2024-01-07    |
    | Number of volunteers needed     | 5             |
    | Start time                      | 01:10 pm      |
    | Duration                        | 5             |
    | Location                        | Singapore Zoo |
    | Description                     |               |
    | Incentive provided              | Money         |
    | Incentive                       |   $30         |
    When I click on "Create" button
    Then I should be returned back to new requests page
   

Feature: Generating code for employees
    As a corporate volunteer manager
    So that I can allow my employees to register and be associated with my company
    I want to be able to generate a code and provide it to them

    Background:
        Given I have a cvm account
        And I login as a cvm

    Scenario: Copy code to clipboard
        Given I am on the cvm dashboard
        When I click on the copy code button
        Then the company code should be copied to my clipboard

    Scenario: Regenerate code
        Given I am on the cvm dashboard
        When I click on the regenerate code button
        Then I should receive a new company code


Feature: Signing up as a corporate volunteer
    As a corporate volunteer 
    So that I can obtain more volunteering opportunities for my company to claim tax relief
    I want to be able to register my account under the company

    Scenario: Sign up with valid company code
        Given I am on the 'register' page
        And I click on User
        When I enter the details including the code associated with my company
        And I click on 'Sign up!'
        Then I should see 'Welcome! You have signed up successfully'
        And I am on the 'profile' page
        And I should see the corporate user icon

    Scenario: Sign up with invalid company code
        Given I am on the 'register' page
        And I click on User
        When I enter the details and an inactive company code
        And I click on 'Sign up!'
        Then I should see 'Company code does not exist'

Feature: Viewing requests as a corporate volunteer
    As a corporate volunteer 
    So that I can help my company claim tax relief and to volunteer to help someone in need
    I want to be able to see requests from registered IPCs that my company has approved of

    Background:
        Given I have a cvm account
        And Willing Hearts is registered with the application
        And Willing Hearts has put out a request
        And there is a request to be applied for

    Scenario: IPC is registered with my company
        Given I am logged in as a corporate volunteer
        And Willing Hearts is registered with my company
        When I am on the 'home' page
        Then I should not see 'Test Request to Apply'
        And I should see 'Willing Hearts request'

    Scenario: IPC is not registered with my company
        Given I am logged in as a corporate volunteer
        When I am on the 'home' page
        Then I should not see 'Test Request to Apply'
        And I should not see 'Willing Hearts request'

Feature: Differentiating of corporate volunteer applicants
    As a charity
    So that I can distinguish a corporate volunteer from a normal one
    I want to be able to see an indicator that differentiates the applicants

    Background:
        Given I have an account
        And I login 
        And there is a registered user on the app
        And there is a corporate user on the app
        And I have a request
        And there is an application for my request
        And there is an application for my request from a corporate user

    Scenario:
        Given I am on the 'myrequests' page
        When I expand the request
        Then I should see 2 applicants
        And I should see 1 corporate volunteer applicant

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
        Given I click on 'Manage Employees'
        And I deactivate Alice's account
        Then Alice should not be able to log in

    Scenario: Activating an account
        Given I click on 'Manage Employees'
        And I activate Jason's account
        Then Jason should be able to log in

Feature: Managing Charities

    Background:
        Given I have a cvm account
        And I login as a cvm
        And Willing Hearts is registered with the application

    Scenario: Adding a charity without pressing save
        Given I click on 'Manage Charities'
        And I click on Willing Hearts
        When I am on the cvm dashboard
        Then I should not see 'Willing Hearts'

    Scenario: Adding a charity 
        Given I click on 'Manage Charities'
        And I click on Willing Hearts
        When I click on 'Save'
        And I am on the cvm dashboard
        Then I should see 'Willing Hearts'
        
    Scenario: Remove a charity without pressing save
        Given Willing Hearts is registered with my company
        And I click on 'Manage Charities'
        When I click on Willing Hearts
        And I am on the cvm dashboard
        Then I should see 'Willing Hearts'

    Scenario: Remove a charity 
        Given Willing Hearts is registered with my company
        And I click on 'Manage Charities'
        When I click on Willing Hearts
        And I click on 'Save'
        And I am on the cvm dashboard
        Then I should not see 'Willing Hearts'

Feature: Generate Report
    As a corporate volunteer manager
    So that I can allow my employees to register and be associated with my company
    I want to be able to generate a code and provide it to them

    Background:
        Given I have a cvm account
        And I login as a cvm

    Scenario: Generate a report
        Given I am on the cvm dashboard
        And I click on the date range picker
        When I select a range of dates
        And I click on 'Download' button
        Then a report should be downloaded

    Scenario: Generate a report without specifying date range
        Given I am on the cvm dashboard
        When I click on 'Download' button
        Then I should see 'Please enter a date range for the report'

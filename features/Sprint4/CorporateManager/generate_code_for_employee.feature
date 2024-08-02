# Sign up as a corporation

Feature: Signing up as a corporation
    As a corporate volunteer manager
    So that I can obtain more opportunities to claim tax relief from IRAS
    I want to be able to create an account to create more volunteering opportunities for my employees

    Scenario: Register as a corporation
        Given I am on the register page
        And I click on Corporate
        When I enter my company details 
        And click on "Sign up!"
        Then I should see "Thank you for signing up with Ring of Reciprocity."

Feature: Approving a corporation as an Administrator
    As an administrator
    So that requesters have a higher chance of receiving volunteering help
    I want to be able to approve of companies who have registered
    Scenario: 
    // Allison ur shit here

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
        Given I am on the register page
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
    As a requester, regardless of if i am a charity or not
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

Feature: Viewing of corporate volunteer applicants
    As a requester, regardless of if i am a charity or not
    So that I can distinguish a corporate volunteer from a normal one
    I want to be able to see an indicator that differentiates the applicants

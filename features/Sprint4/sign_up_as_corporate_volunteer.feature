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

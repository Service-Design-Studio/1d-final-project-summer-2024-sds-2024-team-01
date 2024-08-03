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

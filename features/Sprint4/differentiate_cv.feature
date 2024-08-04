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

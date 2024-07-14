Feature: Create an application
    As a user
    So that I can help someone with their request
    I want to be able to apply for their request

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app

Scenario: Applying for a request
        Given there is a request to be applied for
        And that I am on the "home" page
        When I click on the request
        And I click on Apply
        Then I should see "Successfully applied for the request"

Scenario: Applying for a request that has already been applied for
        Given there is a request to be applied for
        And that I am on the "home" page
        When I click on the request
        And I click on Apply
        And I click on Apply
        Then I should see "You have already applied for this request"


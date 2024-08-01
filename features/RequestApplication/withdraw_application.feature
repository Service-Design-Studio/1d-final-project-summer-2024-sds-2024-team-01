Feature: Withdraw an application
    As a volunter
    So that I can withdraw my application in the case of an emergency
    I want to be able to withdraw my application to allow others the opportunity

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And there is a request to be applied for
    And there is an application for my request
    And I am on the "home" page
    And I click on the request

Scenario:
        Given I am on the 'myapplications' page
        When I expand the request
        And I press "Withdraw"
        Then the application should be "Withdrawn"
        And I should see 'Withdraw Success'

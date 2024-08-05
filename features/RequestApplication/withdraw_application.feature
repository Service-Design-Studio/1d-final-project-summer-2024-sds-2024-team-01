Feature: Withdraw an application
    As a volunter
    So that I can withdraw my application in the case of an emergency
    I want to be able to withdraw my application to allow others the opportunity

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And there is a request to be applied for
    And I am on the "home" page
    And I click on the request
    And I click on 'Apply'
    And my application has been accepted

Scenario:
        Given I am on the 'myapplications' page
        When I expand the request
        And I press "Withdraw"
        And I click on "Withdrawn/Rejected"
        Then the application should be "Withdrawn"
        And I should see 'Withdraw success'

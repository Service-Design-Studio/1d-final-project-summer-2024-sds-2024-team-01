Feature: 
    As a user who has applied for a request
    So that I am aware if my request has been accepted or rejected
    I want to be able to see the status of my request

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And I have a request

Scenario:
        Given there is a request to be applied for
        And I have applied for the request
        And I am on the 'myapplications' page
        Then I should see "Pending" 

Scenario:
        Given I am on the 'myapplications' page
        When my application has been accepted
        Then I should see "Accepted"

Scenario:
        Given I am on the 'myapplications' page
        When my application has been rejected
        Then I should see "Rejected"

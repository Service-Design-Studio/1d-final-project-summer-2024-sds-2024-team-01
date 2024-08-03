Feature: 
    As a user who has applied for a request
    So that I am aware if my request has been accepted or rejected
    I want to be able to see the status of my request

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And I have a request
    And there is a request to be applied for
    And I have applied for the request

Scenario:
        When I am on the 'myapplications' page
        Then I should see "Pending" 

Scenario:
        Given my application has been accepted
        When I am on the 'myapplications' page
        Then I should see "Accepted"

Scenario:
        Given my application has been rejected
        When I am on the 'myapplications' page
        Then I should see "Rejected"

Scenario:
        Given my application has been accepted
        And I have completed the request
        When I am on the 'myapplications' page
        And I click on 'Completed' 
        Then I should see 'Concluded'

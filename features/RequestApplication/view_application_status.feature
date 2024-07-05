Feature: 
    As a user who has applied for a request
    So that I am aware if my request has been accepted or rejected
    I want to be able to see the status of my request

Scenario:
        Given I am on the MyApplications page
        When I apply for a request
        Then I should see "Pending" in the status column of the most recent request

Scenario:
        Given I am on the MyApplications page
        When my application has been accepted
        Then I should see "Accepted" in the status column of the most recent request

Scenario:
        Given I am on the MyApplications page
        When my application has been rejected
        Then I should see "Rejected" in the status column of the most recent request

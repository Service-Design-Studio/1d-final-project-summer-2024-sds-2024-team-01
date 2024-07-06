Feature: Create an application
    As a user
    So that I can help someone with their request
    I want to be able to apply for their request

Scenario: Applying for a request
        Given I am on the Ring of Reciprocity home page
        And there is at least one request
        When I click on the first request
        And I click on Apply
        Then I should see "Successfully applied for the request"

Scenario: Applying for a request that has already been applied for
        Given I am on the Ring of Reciprocity home page
        And there is at least one request
        When I click on the first request
        And I click on Apply
        Then I should see "Request has already been applied for"

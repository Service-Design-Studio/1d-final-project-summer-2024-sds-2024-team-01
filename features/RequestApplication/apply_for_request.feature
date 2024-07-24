Feature: Apply for a request
    As a user
    So that I can help someone with their request
    I want to be able to apply for their request

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And that I am on the "home" page

Scenario: Applying for a request
        Given there is a request to be applied for
        When I click on the request
        And I click on 'Apply'
        Then I should see "Successfully applied for the request"

Scenario: Applying for a request that has already been applied for
        Given there is a request to be applied for
        When I click on the request
        And I click on 'Apply'
        And I click on 'Apply'
        Then I should see "You have already applied for this request"

Scenario: Applying for a request that is full
        Given there is a request to be applied for
        And I click on the request
        When the request becomes full
        And I click on 'Apply'
        Then I should see "This request is unable to accept anymore applicants as it is full"

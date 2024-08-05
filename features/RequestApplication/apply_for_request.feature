Feature: Apply for a request
    As a user
    So that I can help someone with their request
    I want to be able to apply for their request

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And there is a request to be applied for
    And I am on the "home" page
    And I click on the request

Scenario: Applying for a request
        Given I click on 'Apply'
        Then I should see "You have successfully applied for the request"

Scenario: Applying for a request that has already been applied for
        Given I click on 'Apply'
        And I click on 'Apply'
        Then I should see "You have already applied for this request"

Scenario: Applying for a request that is full
        Given the request becomes full
        When I click on 'Apply'
        Then I should see "Sorry, this request is unable to accept anymore applicants"

Scenario: Receiving a notification that someone accepted my application
        Given I click on 'Apply'
        And that someone has 'accepted' my application
        When I am on the 'home' page
        And I click the notification icon
        Then I should see 'Your application for a request has been accepted'

Scenario: Receiving a notification that someone rejected my application
        Given I click on 'Apply'
        And that someone has 'rejected' my application
        When I am on the 'home' page
        And I click the notification icon
        Then I should see 'Your application for a request has been rejected'

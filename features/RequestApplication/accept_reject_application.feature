Feature:
    As a user who posted a request
    So that I can receive help 
    I want to be able to accept an appropriate applicant

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And I have a request
    And there is an application for my request

Scenario:
        Given I am on the 'myrequests' page
        When I expand the request
        And I press "Accept"
        Then the application should be "Accepted"

Scenario:
        Given I am on the 'myrequests' page
        When I expand the request
        And I press "Reject"
        Then the application should be "Rejected"

Scenario: Receiving a notification that someone accepted my application
        Given that someone has 'accepted' my application
        When I am on the 'home' page
        And I click the notification icon
        Then I should see 'Your application for a request has been accepted'

Scenario: Receiving a notification that someone rejected my application
        Given that someone has 'rejected' my application
        When I am on the 'home' page
        And I click the notification icon
        Then I should see 'Your application for a request has been rejected'

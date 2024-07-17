Feature: Viewing requets as a corporate user
    As a corporate user
    I should only be able to see requests that are uncompensated

    Background:
        Given I am logged in as a corporate user

    Scenario: I should only see one request
        Given there is a compensated request
        And there is an uncompensated request
        When I am on the 'home' page
        Then I should only see one request

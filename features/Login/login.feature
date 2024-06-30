
#Feature: Login functionality

Scenario: Successful login with Singpass
    Given I am on the login page
    When I scan the Singpass QR code
    Then I should see the requests page

Scenario: Failed login with Singpass
        Given I am on the login page
        When I scan the Singpass QR code
        And fail the login
        Then I should see "Login failed, please try again"

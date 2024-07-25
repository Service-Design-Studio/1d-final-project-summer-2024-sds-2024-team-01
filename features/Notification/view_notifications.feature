Feature: View notification

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And I have a request
    And there is a notification for me

Scenario: Someone applied for my request
    Given I am on the "home" page
    When I click on the notification icon
    Then I should see "Hello there this is a test notification"


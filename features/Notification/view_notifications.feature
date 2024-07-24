Feature: View notification

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And I have a request
    And someone has applied for my request

Scenario: Someone applied for my request
    Given I am at the "home" page
    When I click on the notification icon
    Then I should see "Someone has applied for your request!"


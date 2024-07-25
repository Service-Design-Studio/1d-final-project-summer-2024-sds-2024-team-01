Feature: Send Chat Message
    As a user
    I want to see my message in the chat
    So that I know my message was sent successfully

Background:
    Given I have an account
    And I login 
    Given there is a registered user on the app
    And there is a request to be applied for

Scenario: User sends a message but it does not show on the screen
    Given I am on the 'home' page
    When I click on the request
    And I choose "Chat"
    And I send a message to another user
    Then the message should appear in the chat
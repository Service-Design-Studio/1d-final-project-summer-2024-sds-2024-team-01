Feature: Send Chat Message
    As a user
    I want to see my message in the chat
    So that I know my message was sent successfully
    
    Scenario: User sends a message but it does not show on the screen
        Given I am on the 'chat' page
        And I send a message to another user
        Then the message should appear in the chat
Feature: View Chats
    As a user
    I want to be able to view my chats with other users
    So that I can communicate with them easily

    Scenario: View chats from the navbar
        Given there is a chat I want to view
        When I click on the "Chats" button in the navbar
        Then I should be redirected to the chats page
        And I should see a list of my chats with other users

    Scenario: View chats from the myrequests page
        Given I am on the 'myrequests' page
        When I click on the "Chat" button on a user's request
        Then I should be redirected to a chat with that user

    Scenario: View chats from the myapplications page
        Given I am on the 'myapplications' page
        When I click on the "Chat" button on a user's application
        Then I should be redirected to a chat with that user


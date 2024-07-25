Feature: View Chats
    As a user
    I want to be able to view my chats with other users
    So that I can communicate with them easily

Background:
    Given I have an account
    And I login 
    Given there is a registered user on the app
    And there is a request to be applied for
    

    Scenario: View chats from the home page
        Given I am on the 'home' page
        When I click on the request
        And I choose "Chat"
        Then I should be redirected to a chat with that user
    
    Scenario: View chats from the myapplications page

        And I am on the 'myapplications' page
        When I click on the "Chat" button on a user's application
        Then I should be redirected to a chat with that user

    Scenario: View chats from the myrequests page
        Given there is a request to be applied for
        Given I am on the ''myrequests'' page
        And I have a request
        When I click on the request
        When I click on "Chat" button
        Then I should be redirected to a chat with that user

    Scenario: View chats from the navbar
        Given there is a chat I want to view
        When I click on "Chat" button
        Then I should be redirected to the chats page
        And I should see a list of my chats with other users





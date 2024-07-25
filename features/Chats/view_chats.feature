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
        Given I have applied for the request
        And I am on the 'myapplications' page
        When I click on 'Pending'
        When I click on 'Test Request to Apply'
        And I choose "Chat"
        Then I should be redirected to a chat with that user

    Scenario: View chats from the myrequests page
        Given I have a request
        And there is an application for my request
        And I am on the 'myrequests' page
        When I expand the request
        And I choose "Chat"
        Then I should be redirected to a chat with that user

    Scenario: View chats from the navbar
        Given I have a chat with another user
        When I click on "Chat" 
        Then I should be redirected to the chats page
        And I should see "Alice Smith"





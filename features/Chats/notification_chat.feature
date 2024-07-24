Feature: Notification Chat
    As a user who has received a message
    I should be able to see a notification on the navbar 

    Scenario: Receive message notification
        Given I am on the 'requests' page
        And another user sends me a message
        Then I should see a notification on the navbar indicating a new message
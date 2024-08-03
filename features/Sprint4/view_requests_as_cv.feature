Feature: Viewing requests as a corporate volunteer
    As a corporate volunteer 
    So that I can help my company claim tax relief and to volunteer to help someone in need
    I want to be able to see requests from registered IPCs that my company has approved of

    Background:
        Given I have a cvm account
        And Willing Hearts is registered with the application
        And Willing Hearts has put out a request
        And there is a request to be applied for

    Scenario: IPC is registered with my company
        Given I am logged in as a corporate volunteer
        And Willing Hearts is registered with my company
        When I am on the 'home' page
        Then I should not see 'Test Request to Apply'
        And I should see 'Willing Hearts request'

    Scenario: IPC is not registered with my company
        Given I am logged in as a corporate volunteer
        When I am on the 'home' page
        Then I should not see 'Test Request to Apply'
        And I should not see 'Willing Hearts request'

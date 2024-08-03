Feature: Viewing requests as a corporate volunteer
    As a corporate volunteer 
    So that I can help my company claim tax relief and to volunteer to help someone in need
    I want to be able to see requests from registered IPCs that my company has approved of

    Scenario:
        Given I am logged in as a corporate volunteer
        When I am on the 'home' page
        Then I should not see 'Paid Request' #compensation
        Then I should not see 'Non IPC Request' #only registered charities, not any

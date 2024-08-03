Feature: Managing Charities

    Background:
        Given I have a cvm account
        And I login as a cvm
        And Willing Hearts is registered with the application

    Scenario: Adding a charity without pressing save
        Given I click on 'Manage Charities'
        And I click on Willing Hearts
        When I am on the cvm dashboard
        Then I should not see 'Willing Hearts'

    Scenario: Adding a charity 
        Given I click on 'Manage Charities'
        And I click on Willing Hearts
        When I click on 'Save'
        And I am on the cvm dashboard
        Then I should see 'Willing Hearts'
        
    Scenario: Remove a charity without pressing save
        Given Willing Hearts is registered with my company
        And I click on 'Manage Charities'
        When I click on Willing Hearts
        And I am on the cvm dashboard
        Then I should see 'Willing Hearts'

    Scenario: Remove a charity 
        Given Willing Hearts is registered with my company
        And I click on 'Manage Charities'
        When I click on Willing Hearts
        And I click on 'Save'
        And I am on the cvm dashboard
        Then I should not see 'Willing Hearts'


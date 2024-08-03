Feature: Viewing of statistics
    As a corporate volunteer manager
    So that I can keep track on who is volunteering
    I want to be able to see the number of hours that each employee is volunteering for 

    Background:
        Given Willing Hearts is registered with the application
        And Willing Hearts is registered with my company
        And Jason has completed a request
        And Alice has completed a request
        And Bob has completed a request
        
    Scenario:
        Given I have a cvm account
        When I login as a cvm
        Then I should 8 hours volunteered this week

    Scenario: Viewing of employee statistics
        Given I have a cvm account
        When I login as a cvm
        Then I should see '3' under top employees

    Scenario: Viewing of volunteering statistics
        Given I have a cvm account
        When I login as a cvm
        Then I should see 'Jason' before 'Alice' under top employees
        And I should see 'Alice' before 'Bob' under top employees

    Scenario: Viewing of charities registered with my company
        Given I have a cvm account
        When I login as a cvm
        Then I should see 'Willing Hearts'

Feature: Viewing of statistics
    As a corporate volunteer manager
    So that I can keep track on who is volunteering
    I want to be able to see the number of hours that each employee is volunteering for 

    Background:
        Given I have a cvm account
        And Willing Hearts is registered with the application
        And Willing Hearts is registered with my company
        And Jason has completed a request
        And Alice has completed a request
        And Bob has completed a request
        And Jane's account is deactivated
        And I login as a cvm
        
    Scenario:
        Given I am on the cvm dashboard
        Then I should see 12 hours volunteered this week

    Scenario: Viewing of employee statistics
        Given I am on the cvm dashboard
        Then I should see 3 employees
        And I should see '1 inactive accounts'

    Scenario: Viewing of volunteering statistics
        Given I am on the cvm dashboard
        Then I should see 3 employees under top employees
        And I should see 'Alice' before 'Bob' under top employees
        And I should see 'Jason' before 'Alice' under top employees
        And I should see 'Jason' before 'Bob' under top employees

    Scenario: Viewing of charities registered with my company
        Given I am on the cvm dashboard
        Then I should see 'Willing Hearts'

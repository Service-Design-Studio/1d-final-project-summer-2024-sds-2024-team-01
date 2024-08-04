Feature: Managing employees 

    Background:
        Given I have a cvm account
        And I login as a cvm
        And Jason's account is deactivated

    Scenario: Deactivating an account
        Given I click on 'Manage Employees'
        And I deactivate Alice's account
        Then Alice should not be able to log in

    Scenario: Activating an account
        Given I click on 'Manage Employees'
        And I activate Jason's account
        Then Jason should be able to log in


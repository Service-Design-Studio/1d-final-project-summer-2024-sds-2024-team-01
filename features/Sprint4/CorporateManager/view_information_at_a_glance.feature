Feature: View information regarding company at a glance
    As a corporate volunteer manager
    I want to be able to view information at a glance on a dashboard
    So that it is easier to manage and view the statistics of employee volunteers associated with my company

    Background: 
        Given I am logged in as a cvm

    Scenario: View charities
        Given I am on the cvm dashboard
        Then I should see all the charities that have been approved for my employees

    Scenario: View number of employees
        Given I am on the cvm dashboard
        Then I should see the number of employees under my company
        And I should see the number of deactivated accounts

    Scenario: View top employees
        Given I am on the cvm dashboard
        Then I should see the top employees
        And the top employees should be sorted based on their weekly volunteered hours

    Scenario: View number of hours volunteered this week
        Given I am on the cvm dashboard
        Then I should see the number of hours volunteered this week
        And I should see how the percentage change

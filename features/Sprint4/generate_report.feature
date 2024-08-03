Feature: Generate Report
    As a corporate volunteer manager
    So that I can allow my employees to register and be associated with my company
    I want to be able to generate a code and provide it to them

    Background:
        Given I have a cvm account
        And I login as a cvm

    Scenario: Generate a report
        Given I am on the cvm dashboard
        And I click on the date range picker
        When I select a range of dates
        And I click on 'Download' button
        Then a report should be downloaded

    Scenario: Generate a report without specifying date range
        Given I am on the cvm dashboard
        When I click on 'Download' button
        Then I should see 'Please enter a date range for the report'

Feature: Generating code for employees
    As a corporate volunteer manager
    So that I can allow my employees to register and be associated with my company
    I want to be able to generate a code and provide it to them

    Background:
        Given I have a cvm account
        And I login as a cvm

    Scenario: Copy code to clipboard
        Given I am on the cvm dashboard
        When I click on the copy code button
        Then the company code should be copied to my clipboard

    Scenario: Regenerate code
        Given I am on the cvm dashboard
        When I click on the regenerate code button
        Then I should receive a new company code

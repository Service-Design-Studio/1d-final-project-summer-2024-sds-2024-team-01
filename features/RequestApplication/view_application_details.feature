Feature: View application details

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And there is a request to be applied for
    And I have applied for the request

Scenario: 
    Given I am on the 'myapplications' page
    When I click on 'Pending'
    When I click on 'Test Request to Apply'
    Then I should see 'Need someone to walk my dog for an hour every afternoon'

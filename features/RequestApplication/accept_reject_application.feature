Feature:
    As a user who posted a request
    So that I can receive help 
    I want to be able to accept an appropriate applicant

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And I have a request
    And there is an application for my request

Scenario:
        Given I am on the 'myrequests' page
        When I "Accept" the first applicant
        Then the application should be "Accepted"
        And I should see "Application accepted"

# Scenario:
#         Given I am on the 'myrequests' page
#         And the first request is fully filled
#         Then I should see "Unable to accept more applicants"

Scenario:
        Given I am on the 'myrequests' page
        When I "Reject" the first applicant
        Then the application should be "Rejected"
        And I should see "Application rejected"


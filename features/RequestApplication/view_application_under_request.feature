Feature:
    As a user who posted a request
    So that I can accept or reject applications
    I want to be able to see applicant details for each request

# Scenario:
#         Given that I am on the 'MyRequests' page
#         Then I should see "Pending" under the status of the first request 

Background:
    Given I am logged in 
    And there is a registered user on the app
    And I have a request
    And there is an application for my request

Scenario:
        Given I am on the 'myrequests' page
        Then I should see the applicants who have applied for each request
        And I should see the name of each applicant

Scenario:
        Given I am on the 'myrequests' page
        When I click on the profile section of the first applicant
        Then I should see the applicants profile

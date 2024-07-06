Feature:
    As a user who was posted a request
    So that I can accept or reject applications
    I want to be able to see applicant details for each request

Scenario:
        Given that I am on the MyRequests page
        When I click the header for the first request
        Then I should see "Pending" under the status column of the first request 

Scenario:
        Given I am on the MyRequests page
        When I click on the header of the first request
        Then I should see the applicants who have applied for the request
        And I should see the rating of each applicant

Scenario:
        Given I am on the MyRequests page
        And I click on the header of the first request
        When I click on the profile section of the first applicant
        Then I should see the applicants profile

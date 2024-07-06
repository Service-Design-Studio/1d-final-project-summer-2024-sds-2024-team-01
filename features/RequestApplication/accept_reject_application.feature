Feature:
    As a user who posted a request
    So that I can receive help 
    I want to be able to accept an appropriate applicant

Scenario:
        Given I am on the MyRequests Page
        And I click on the header of the first request 
        And the first request is not fully filled
        When I accept the first applicant
        Then I should see "Applicant accepted"


Scenario:
        Given I am on the MyRequests Page
        And I click on the header of the first request 
        And the first request is fully filled
        Then I should not be able to accept any applicants 

Scenario:
        Given I am on the MyRequests Page
        And I click on the header of the first request 
        When I reject the first applicant
        Then I should see "Applicant rejected"


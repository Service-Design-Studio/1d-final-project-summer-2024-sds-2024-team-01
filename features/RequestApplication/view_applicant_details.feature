Feature:
    As a user who posted a request
    So that I can accept or reject applications
    I want to be able to see applicant details for each request

Background:
    Given I have an account
    And I login 
    And there is a registered user on the app
    And I have a request
    And there is an application for my request

Scenario:
    Given I am on the 'myrequests' page
    When I expand the request
    Then I should see the applicants who have applied for each request
    And I should see the name of each applicant

Scenario:
    Given I am on the 'myrequests' page
    When I expand the request
    And I click on the profile section of the first applicant
    Then I should see the applicants profile

Feature: Leave a review as a requester
  As a requester
  So that others can evaluate my volunteer
  I want to leave a review for my volunteer

Background:
  Given I have an account
  And I login 
  And I have a completed request with accepted applicants
  And I am on the "myrequests" page
  And I click on 'Completed'

Scenario: Leave a review for a volunteer
  Given I expand the request
  And I click on 'Leave a review'
  When I enter review details
  And I press 'Submit'
  Then I should see 'Review submitted'

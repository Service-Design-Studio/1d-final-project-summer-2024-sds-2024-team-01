Feature: Leave a review as a volunteer
  As a volunteer
  So that others can evaluate my requester
  I want to leave a review for my requester

Background:
  Given I have an account
  And I login 
  And I have completed a request
  And I am on the 'myapplications' page
  And I click on 'Completed'

Scenario: Leave a review for a requester
  Given I expand the request
  And I click on Leave a review
  When I enter review details
  And I click on 'Submit'
  Then I should see 'Review was successfully created'

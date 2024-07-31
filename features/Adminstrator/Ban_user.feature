Feature: Ban user
 As an admin
 So that I can ban user 
 I want to ban user from the system

Background:
Given I login as an admin
And I login

Scenario: Given that users report and admin has to check and see whether to ban or not
Given I go to the "Ban User" page
Then I should see a list of users who have been reported
Then I should see the reasons of why they report the ban
Then I press "Ban"
Then I should see a pop up "Joe Doe has been banned"

Scenario: Given that I want to unban users
Given I go to the "Ban User" page
Then I should see a list of banned users
Then I press "Unban"
Then I should see a pop up "Joe Doe has been unbanned"

Scenario: Unreasonable report
Given I go to the "Ban User" page
Then I should see a list of users who have been reported
Then I should see the reasons of why they report the ban
Then I press "Cancel"
Then I should see a pop up "No ban placed on Joe Doe."
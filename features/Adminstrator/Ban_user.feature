Feature: Ban user
 As an admin
 So that I can ban user 
 I want to ban user from the system

Background:
Given I have an admin account
And I am logged in as an admin
And there is a user named "Reported User 1"

# Scenario: Ban valid account
# Given I want to ban "Joe Doe"
# When I go to the user profile page
# And I click on "Ban User"
# Then I should see a pop up "Are you sure you want to ban Joe Doe? Why?" input 
# Then I fill in the reason "Joe Doe is a scammer"
# Then I click on "Yes"
# Then I should see a pop up "Joe Doe has been banned"
# And the user "John Doe" should be marked as banned

Scenario: Given that users report and admin has to check and see whether to ban or not
Given I go to "Ban User" page
Then I should see a list of users who have been reported
Then I should see the reasons of why they are reported
Then I find the reason for the ban of "Reported User 1" reasonable
Then I click on the "More"
Then I should see the user profile page
Then I return to "Ban User" page
Then I click on "Ban User" button
Then I click on "UnBan" tab
Then I should see "Reported User 1"

# Scenario: Ban invalid account
# Given I want to ban "John Doe"
# When I go to user profile page
# Then I should see invalid profile 
# And a pop up "No such user exist"

Scenario: Unreasonable report
Given I go to "Ban User" page
Then I should see a list of users who have been reported
Then I should see the reasons of why they report the ban
Then I find the reason for the ban of "Reported User 1" unreasonable
Then I click on the "More"
Then I should see the user profile page
Then I return to "Ban User" page
Then I click on "Cancel" button

Scenario: No report 
Given I go to "Ban User" page
Then I should see "No banned users"



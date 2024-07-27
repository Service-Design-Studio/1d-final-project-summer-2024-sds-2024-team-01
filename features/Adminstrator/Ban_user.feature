# Feature: Ban user
#  As an admin
#  So that I can ban user 
#  I want to ban user from the system
#
# Background:
# Given I have an admin account
# And I am logged in as an admin
# And there is a user named "Joe Doe"
#
# Scenario: Given that users report and admin has to check and see whether to ban or not
# Given I go to the report list page
# Then I should see a list of users who have been reported
# Then I should see the reasons of why they report the ban
# Then I find the reason for the ban of "Joe Doe" reasonable
# Then I press "Ban"
# Then I should see a pop up "Joe Doe has been banned"
#
# Scenario: Unreasonable report
# Given I go to the report list page
# Then I should see a list of users who have been reported
# Then I should see the reasons of why they report the ban
# Then I find the reason for the ban of "Joe Doe" unreasonable
# Then I press "Cancel"
# Then I should see a pop up "No ban placed on Joe Doe."

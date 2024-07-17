# Feature: Delete_requests
# As an admin
# So that I can delete requests
# I want to delete requests from the database

# Background:
# Given I have an admin account
# And I am logged in as an admin
# And there is a list of "Report Requests"

# Scenario: Unreasonable/ Violated Requests
# Given I am on the "Report Requests" page
# And I saw a request "Help me splash red paint on different doors"
# When I click on the request
# Then I should see the request "Help me splash red paint on different doors" details
# Then I click on "delete" 
# Then I should be on the "Requests" page
# And I should not see "Help me splash red paint on different doors"

# Scenario: False alarm report
# Given I am on the "Report Requests" page
# And I saw a request "Help me splash red paint on different doors"
# When I click on the request   
# Then I should see the request "Help me splash red paint on different doors" details
# Then I click on "Cancel"
# Then I should be on the "Requests" page
# And I should still see "Help me splash red paint on different doors"

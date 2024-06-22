# Feature: Delete Request
# As a user
# I want to be able to delete a request
# So that I can remove unwanted requests

# #Happy Case
# Scenario: Delete a request successfully
# Given I am logged in as a user
# And I have a request with the following details:
# | title   | description   | category   | status   |
# | Test    | Test request  | Test       | pending  |
# When I delete the request
# Then the request should be deleted successfully

# #Sad Case
# Scenario: Delete a request that does not exist
# Given I am logged in as a user
# When I delete a request that does not exist
# Then I should see an error message "Request not found"



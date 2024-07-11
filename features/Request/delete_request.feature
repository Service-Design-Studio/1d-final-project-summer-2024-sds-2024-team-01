# Feature: Delete Request
#   As a user
#   I want to be able to delete a request
#   So that I can remove unwanted requests

# Background:
#     Given I have an account
#     And I login 
#     And there is a registered user on the app
#     And I have a request
    
#   Scenario: Delete a request successfully
#     Given I am on the "myrequests" page
#     When I follow "Test Request"
#     And I click on "Destroy this request" button
#     Then I should see a message "Request was successfully destroyed."
#     And I should not see "Test Request"


# ### feel like we dont need the below scenarios ###

# #   Scenario: Delete a request with invalid permissions
# #     Given I am logged in as a different user
# #     And I have a request with the following details:
# #       | title   | description   | category   | status   |
# #       | Test    | Test request  | Test       | pending  |
# #     When I follow "Test" request link
# #     And I click on "Delete" button
# #     Then I should see an error message "You do not have permission to delete this request"

# #   Scenario: Attempt to delete a request when not logged in
# #     Given I am not logged in
# #     When I attempt to delete a request
# #     Then I should be redirected to the login page

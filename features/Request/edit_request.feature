# Scenario: Edit request
#     Given I have a request titled "Help with Gardening"
#     When I follow "Show more details"
#     Then I follow "Edit this request" for "Help with Gardening"
#     And I fill in "Title" with "Gardening Help"
#     And I press "Update Request"
#     Then I should see "Request was successfully updated."
#     And I follow "Back to requests"
#     Then I should see "Gardening Help" in the table of requests
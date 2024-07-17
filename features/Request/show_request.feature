# Feature: Show More Details
#   As a user
#   I want to see more details about a request
#   So that I an have all the necessary information

# # Background: Request have been added to database
# # Given the following requests exist:
# # | Title               | Category    | Location                     | Date       | Number of Pax | Duration | Reward | Created by | Details           |
# # | Help with Gardening |Gardening    |	POINT (40.712776 -74.005974) |2024-07-01  | 2             | 3        | $50    | 1          | Show more details |

          
# #Happy Case
#   Scenario: View details of a specific request
#     Given I have a request titled "Help with Gardening"
#     When I follow "Show more details" of the same row of "Help with Gardening"
#     Then I should see a list of details:
# #     | field         | value                                              |
# #     | title         | Help with Gardening                                |
# #     | description   | Looking for someone to help with my backyard garden|
# #     | category      | Gardening                                          |
# #     | location      | POINT (40.712776 -74.005)                          |
# #     | date          | 2024-07-01                                         |
# #     | number_of_pax | 2                                                  |
# #     | duration      | 3                                                  |
# #     | reward        | $50                                                |
# #     | reward_type   | Cash                                               |

# #Sad Case
# Scenario: No additional details 
# Given I have a request titled "Help with Gardening"
# When I follow "Show more details" of the same row of "Help with Gardening"
# Then I should see an error message "No additional details found"
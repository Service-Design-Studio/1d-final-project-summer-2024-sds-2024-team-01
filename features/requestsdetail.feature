Feature: Show more details on the request

As a volunteer 
So that I can fully understand the detail of the request
I want to be able to view the full description of the details made by the requester

Background:
  Given the following requests exist:
    | Title               | Category  | Location                     | Date       | Number of Pax | Duration | Reward | Created by | Status |
    | Help with Gardening | Gardening | POINT (40.712776 -74.005974) | 2022-01-01 | 2             | 3        | $50    | 1          | Open   |

Scenario: Show more details for request 
  When I click on "show more details" for "Help with Gardening"
  Then I should be brought to another page that shows more details of the request 
  And I should see the following details of the request:
    | Field          | Value                            |
    | Title          | Help with Gardening              |
    | Description    | I need help with gardening...    |
    | Category       | Gardening                        |
    | Location       | POINT (40.712776 -74.005974)     |
    | Date           | 2022-01-01                       |
    | Number of pax  | 2                                |
    | Duration       | 3                                |
    | Reward         | $50                              |
    | Created by     | 1                                |
    | Status         | Open                             |

    


Scenario: Show more details for request but there are no details
  Given no more details are available for the request "Help with Gardening"
  When I click on "show more details" for "Help with Gardening"
  Then I should see a message indicating that the request details are not available

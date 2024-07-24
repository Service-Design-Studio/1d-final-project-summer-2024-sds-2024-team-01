Feature: Calling the Requests API
  As an applicant
  So that I can see 'Requests' in json format
  I want to make calls and get requests from the 'Requests' API

Background:
  Given I have an account

# /GET
Scenario: send a GET request to the API
  When I send a 'GET' request
  Then I should see a 200 response
  And I should see the requests in json format

# /POST
Scenario: send a POST request to the API
  When I fill in the following details in json format:
    # | Field                           | Value                                               |
    | phone_number                    | 96789012                                            |
    | password                        | asdfasdf                                            |
    | title                           | Test Request                                        |
    | category                        | Manual Labour                                       |
    | date                            | 30-07-2024                                          |
    | number_of_pax                   | 5                                                   |
    | start_time                      | 13:10                                            |
    | duration                        | 5                                                   |
    | location                        | POINT(34.052235 -118.243683)                                       |
    | description                     | Looking for someone to help with my backyard garden |
    | reward_type                     | Money                                               |
    | reward                          | $30                                                 |  
  And I send a 'POST' request
  Then I should see a 201 response
  And I should see a message 'Request was successfully created.'

# /POST FAIL
Scenario: fail to send a POST request to the API
  When I fill in the following details in json format:
    # | Field                           | Value                                               |
    | phone_number                    | 96789012                                            |
    | password                        | asdfasdf                                            |
    | title                           | Test Request                                        |
    | category                        | Manual Labour                                       |
    | date                            | 30-07-2024                                          |
    | number_of_pax                   | 5                                                   |
    | start_time                      |                                             |
    | duration                        | 5                                                   |
    | location                        |                                        |
    | description                     | Looking for someone to help with my backyard garden |
    | reward_type                     | Money                                               |
    | reward                          |                                                  |  
  And I send a 'POST' request
  Then I should see a 422 response
  And I should see a message 'Failed to create request.'

# /PATCH
Scenario: send a PATCH request to the API
  Given the request "Test Request" exists
  When I fill in the following details in json format:
  # | Field                           | Value                                                   |
    | phone_number                    | 96789012                                            |
    | password                        | asdfasdf                                            |
    | title                           | Test Request, updated                               |       
    | location                        | POINT(1.4022 103.7881)                                            |
    | description                     | Can someone help to trim my hedges and water my plants? |
  And I send a 'PATCH' request
  Then I should see a 200 response
  And I should see a message 'Request was successfully updated.'

# /PATCH FAIL
Scenario: fail to send a PATCH request to the API
  Given the request "Test Request" exists
  And I fill in the following details in json format:
  # | Field                           | Value                                                   |
    | phone_number                    | 96789012                                            |
    | password                        | asdfasdf                                            |
    | title                           | Test Request, updated                               |       
    | location                        |                                             |
    | description                     | Can someone help to trim my hedges and water my plants? |
  When I send a 'PATCH' request
  Then I should see a 422 response
  # And I should see a message 'Failed to update request.'

# /DELETE
Scenario: send a DELETE request to the API
  Given the request "Test Request" exists
  When I send a 'DELETE' request
  Then I should see a 200 response
  And I should see a message 'Request was successfully deleted.'

# /DELETE FAIL
Scenario: fail to send a DELETE request to the API
  Given the request "Test Request" does not exist
  When I send a 'DELETE' request
  Then I should see a 404 response
  # And I should see a message 'Request not found.'


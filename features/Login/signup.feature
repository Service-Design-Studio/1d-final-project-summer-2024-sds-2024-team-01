Feature: Signup
As a user
So that I can have my own account
I want to signup for the account

#Happy Case
Scenario: Signup with valid phone number 
Given I am on the signup page
When I fill in the follwing: 
| Full name            | Susan Tam     |
| Nric                 | 1234567890    |
| Phone number         | 1234567890    |
| Email                |susan@gmail.com|
|password              | 1234567890    |
|password confirmation | 1234567890    |
And click on "sign up"
Then I should see a message "Your account has been created successfully. You are now signed in."
And I will be at request page 



#Sad Case
Scenario: Signup with invalid details 
Given I am on the signup page
When I fill in the follwing:
| Full name            | Susan Tam     |
| Nric                 | 1234567890    |
| Phone number         |               |
| Email                |susan@gmail.com|
|password              | 1234567890    |
|password confirmation | 1234567890    |
And click on "sign up"
Then I should see a message "Your account has been created successfully. You are now signed in."
And I will be at request page 

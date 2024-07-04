Feature: Signup
As a user
So that I can have my own account
I want to signup for the account

#Happy Case
Scenario: Signup with valid details 
Given I am on the signup page
When I fill in the follwing: 
| Full name            | Susan Tam     |
| Nric                 | 1234567890    |
| Phone number         | 1234567890    |
| Email                |susan@gmail.com|
|password              | 1234567890    |
|password confirmation | 1234567890    |
And I click on "Sign up!" button
Then I will be at request page 
And I should see a message "Welcome! You have signed up successfully."

#Sad Case
Scenario: Signup with invalid Full name
Given I am on the signup page
When I fill in the follwing:
| Full name            |               |
| Nric                 | a23456789b    |
| Phone number         | 1234567890    |
| Email                |susan@gmail.com|
|password              | 1234567890    |
|password confirmation | 1234567890    |
And I click on "Sign up!" button
Then I should see a message " "

Scenario: Signup with invalid Nric
Given I am on the signup page
When I fill in the follwing:
| Full name            | Susan Tam     |
| Nric                 |               |
| Phone number         | 1234567890    |
| Email                |susan@gmail.com|
|password              | 1234567890    |
|password confirmation | 1234567890    |
And I click on "Sign up!" button
Then I should see a message " "

Scenario: Signup with invalid phone number
Given I am on the signup page
When I fill in the follwing:
| Full name            | Susan Tam     |
| Nric                 | a23456789b    |
| Phone number         |               |
| Email                |susan@gmail.com|
|password              | 1234567890    |
|password confirmation | 1234567890    |
And I click on "Sign up!" button
Then I should see a message " "

Scenario: Signup with invalid email address
Given I am on the signup page
When I fill in the follwing:
| Full name            | Susan Tam     |
| Nric                 | a23456789b    |
| Phone number         | 1234567890    |
| Email                |               |
|password              | 1234567890    |
|password confirmation | 1234567890    |
And I click on "Sign up!" button
Then I should see a message "Email can't be blank"

Scenario: Signup with invalid password
Given I am on the signup page
When I fill in the follwing:
| Full name            | Susan Tam     |
| Nric                 | a23456789b    |
| Phone number         | 1234567890    |
| Email                |susan@gmail.com|
|password              |               |
|password confirmation | 1234567890    |
And I click on "Sign up!" button
Then I should see a message "Password can't be blank"

Scenario: Signup with invalid confirm password
Given I am on the signup page
When I fill in the follwing:
| Full name            | Susan Tam     |
| Nric                 | a23456789b    |
| Phone number         | 1234567890    |
| Email                |susan@gmail.com|
|password              | 1234567890    |
|password confirmation |               |
And I click on "Sign up!" button
Then I should see a message "Password confirmation doesn't match Password"
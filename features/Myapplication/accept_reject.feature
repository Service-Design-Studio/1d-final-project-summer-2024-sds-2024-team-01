# Feature: Accept and reject my application
# As a user
# So that I can volunteer at my free will
# I want to accept or reject my application

# Background:
# Given I have an account
# And I login
# And I have already applied for a request recently
# And the request is "Successful"

# #Happy Case
# Scenario: Accept my application
# Given I am on "My Applications" page
# Then I should see My Application details
# And I should see status "Successful" 
# When I click on one application
# Then I should see the application details page
# And I should see the application status as "Successful"

# Scenario: Wants to withdraw but in the end accepted
# Given I am on "My Applications" page
# Then I should see My Application details
# And I should see status "Successful"
# When I click on one application
# And I click on "Withdraw" button
# Then I should see the application details page
# And I should see the application status as "Successful"
# And I click on "Withdraw" button
# Then I should be able to see a pop up "Are you sure you want to withdraw your application?"
# And I click on "Back" button
# Then I should see the application status as "succesful"

# #Sad Case
# Scenario: Reject my application
# Given I am on "My Applications" page
# Then I should see all my applications
# And I should see status "Successful"
# When I click on one application
# Then I should see the application details page
# And I should see the application status as "Successful"
# And I click on "Withdraw" button
# Then I should be able to see a pop up "Are you sure you want to withdraw your application?"
# And I click on "Withdraw"
# Then I should see the application status as "Withdrawn"

# Scenario: Pending status and reject MyApplicaition
# Given I am on "My Applications" page
# Then I should see My Application details
# And I should see status "Pending"
# When I click on one application
# Then I should see the application details page
# And I should see the application status as "Pending"
# And I click on "Withdraw" button
# Then I should be able to see a pop up "Are you sure you want to withdraw your application?"
# And I click on "Withdraw"
# Then I should see the application status as "Withdrawn"

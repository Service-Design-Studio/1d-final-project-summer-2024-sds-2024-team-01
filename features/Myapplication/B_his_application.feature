# Feature: View MyApplication
# As a user
# So that I can see my application details
# I want to view my application

# Background
# Given I have an account
# And I login


# #Happy Case
# Scenario: Pending Status
# Given I am on "My Applications" page
# Then I should see My Application details
# When I click on one application
# Then I should see the application details page
# And I should see the application status as "Pending"

# Scenario: Successful Status
# Given I am on "My Applications" page
# Then I should see My Application details
# When I click on one application
# Then I should see the application details page
# And I should see the application status as "Successful"


# #Sad Case
# Scenario: View MyApplicaition but nth applied
# Given I am on "My Applications" page
# Then I should see the application status as "No Application"

# Scenario: Unsuccessful application
# Given I am on "My Applications" page
# Then I should see My Application details
# When I click on one application
# Then I should see the application details page
# And I should see the application status as "Unsuccessful"

# Scenario: Successful but wants to withdraw
# Given I am on "My Applications" page
# Then I should see My Application details
# When I click on one succesful application
# And I click on "Withdraw" button
# And I click on "Withdraw" again on the pop up 
# Then I should see the application details page
# And I should see the application status as "Withdrawn"

# Scenario: Successful wants to withdraw but changed his mind
# Given I am on "My Applications" page
# Then I should see My Application details
# When I click on one succesful application
# And I click on "Withdraw" button
# And I click on "Back" button on the pop up
# Then I should see the application details page
# And I should see the application status as "Successful"

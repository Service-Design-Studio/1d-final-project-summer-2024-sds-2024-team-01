# Feature: Approve/ Deny companies
# As an admin
# So that I can manage the companies that are registered on the platform
# I want to approve/deny companies
#
# Background:
# Given I have an admin account
# And I am logged in as an admin
#
# Scenario: Approve the Company
# Given I am on the list of pending companies page
# Then I click on "OCBC"
# Then I should see " OCBC" fill in form and the comapany details
# When I click on the "Approve" button
# Then I should see the "Approved" message
# Then I should click on "Send"
# Then I should see the "Email sent" message
# When I am on list of companies page
# Then I should see "OCBC" in the list of companies
# And status is "Approved"
#
# Scenario: Deny the Company
# Given I am on the list of pending companies page
# Then I click on "OCBC"
# Then I should see " OCBC" fill in form and the comapany details
# When I click on the "Deny" button
# Then I should see the "Denied" message
# Then I should click on "Send"
# Then I should see the "Email sent" message
# When I am on list of companies page
# Then I should not see "OCBC" in the list of companies

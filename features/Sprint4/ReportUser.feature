Feature: Report User 
    As a User 
    So that I can report my harrass
    I want to be able to make a report

Background: 
    Given I have an account
    Then I login 

Scenario: Report User
    Given I am on the "All Requests" page
    Then I click on "Help with saluting alarm" 
    Then I click on "Millard Robel"
    Then I click on "Report" button
    Then I fill in "Reason for Reporting" with "Inappropriate harrassing"
    Then I click on "Next" button
    Then I click on "Confirm Report" button
    Then I should see a message "User has been reported successfully."

Scenario: Don't want to report user
    Given I am on the "All Requests" page
    Then I click on "Help with saluting alarm" 
    Then I click on "Millard Robel"
    Then I click on "Report" button
    Then I click on "Back" 
    Then I am on the "Millard Robel Profile" page

Scenario: Decided not to report on second thought
    Given I am on the "Help with saluting alarm" page
    Then I click on "Millard Robel"
    Then I click on "Report" button 
    Then I fill in "Reason for Reporting" with "Inappropriate harrassing"
    Then I click on "Next" button
    Then I click on "Cancel" button
    Then I am on the "Millard Robel Profile" page
   


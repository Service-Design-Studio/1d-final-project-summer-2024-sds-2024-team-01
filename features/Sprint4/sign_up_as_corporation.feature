Feature: Signing up as a corporation
    As a corporate volunteer manager
    So that I can obtain more opportunities to claim tax relief from IRAS
    I want to be able to create an account to create more volunteering opportunities for my employees

    Scenario: Register as a corporation
        Given I am on the 'register' page
        And I click on Corporate
        When I enter my company details 
        And I click on "Sign up!"
        Then I should see "Thank you for signing up with Ring of Reciprocity."

    Scenario: Upload non pdf file 
        Given I am on the 'register' page
        And I click on Corporate
        When I enter my company details with a document in the wrong format
        And I click on "Sign up!"
        Then I should see "Failed to register"

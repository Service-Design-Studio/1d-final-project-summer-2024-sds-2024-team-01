Feature: Signing up as a charity
    As a charity in need of more volunteers
    So that I can obtain more manpower for my beneficiaries
    I want to be able to create an account to create more volunteering opportunities for my employees

    Scenario: Register as a charity
        Given I am on the 'register' page
        And I click on Charity
        When I enter my charity details 
        And I click on "Sign up!"
        Then I should see "Thank you for signing up with Ring of Reciprocity."

    Scenario: Upload non pdf file 
        Given I am on the 'register' page
        And I click on Charity
        When I enter my charity details with a document in the wrong format
        And I click on "Sign up!"
        Then I should see "Failed to register"

Given("I am on the login page") do
          visit '/login'
        end
        
        When("I enter {string} and {string}") do |username, password|
          fill_in 'Username', with: username
          fill_in 'Password', with: password
        end
        
        When("I click the login button") do
          click_button 'Login'
        end
        
        Then("I should see the dashboard page") do
          expect(page).to have_content('Dashboard')
        end
        
# features/step_definitions/view_requests_steps.rb

Given("I am on Ring of Reciprocity requests page") do
          visit '/requests'  # Replace with the actual URL or path to your requests page
          # You may need additional setup here, like logging in or preparing test data
        end
        
        When("I scroll") do
          # No specific action needed in this case, but you can simulate scrolling behavior if required
        end
        
        Then("I should be able to see 2 full view and 2 partial view of user requests") do
          expect(page).to have_selector('.request-card.full-view', count: 2)
          expect(page).to have_selector('.request-card.partial-view', count: 2)
          # Adjust selectors and counts based on your actual application's HTML structure
        end
        
        When("I click on 1 of the requests card") do
          first('.request-card').click  # Clicks the first request card found
          # You may want to add assertions or further actions after clicking the card
        end
        
        Then("I should be brought to another page that shows me a full description of the requests posted by the user") do
          expect(page).to have_content('Full Description')  # Replace with content you expect on the details page
          # Add more specific assertions if needed to verify the details page
        end
        
        When("I scroll down, but there are no requests available") do
          # Simulate no requests being available
          # This could involve mocking the server response or manipulating the DOM in tests
        end
        
        Then("I should see a message indicating no requests are currently available") do
          expect(page).to have_content('No requests available at the moment')
          # Adjust the message to match what your application would display
        end
        
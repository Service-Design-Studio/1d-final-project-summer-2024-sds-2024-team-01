Given("I want to generate a report") do
          visit '/generate_report'
        end
        
        When('I fill in {string} with {string}') do |field, value|
        fill_in field, with: value
        puts "Filled in #{field} with #{value}"
        end
        
        When('I press {string}') do |button_text|
        click_button(button_text)
        puts "Pressed #{button_text}"
        end

        Then("I should see a PDF of the report") do
          expect(page).to have_content('Report')
        end       
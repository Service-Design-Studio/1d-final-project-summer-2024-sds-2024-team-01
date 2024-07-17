Given("I am logged in as a corporate user") do
  @corporate_user = FactoryBot.create(:user, role_id: 4)
  visit '/login' 
  fill_in "user_number", with: @corporate_user.number
  fill_in "user_password", with: @corporate_user.password
  click_button "Login"
end

Given("there is a compensated request") do
  @compensated_request = FactoryBot.create(:request, reward_type: 'Cash', reward: '$20')
end

Given("there is an uncompensated request") do
  @uncompensated_request = FactoryBot.create(:request)
end

Then("I should only see one request") do
  expect(page).to have_selector('.request-card_requests_index', count: 1)
end


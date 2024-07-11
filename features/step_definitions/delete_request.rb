# Given('I am logged in as a user') do
#     steps %{
#       Given I am logged in
#     }
#   end
  
# #   Given('I have a request with the following details:') do |table|
# #     data = table.hashes.first
# #     @request = Request.create!(
# #       title: data['title'], 
# #       description: data['description'], 
# #       category: data['manual labour'], 
# #       status: data['status'], 
# #       user: User.find_by(number: '56789012'),
# #       location: 'Test Location',  # Add required fields
# #       date: '01/01/2222',           # Assuming date is today for simplicity
# #       number_of_pax: 5,           # Arbitrary number for test
# #       duration: '2 hours',        # Arbitrary duration for test
# #       reward_type: 'Gift',        # Arbitrary reward type for test
# #       created_by: 'Test Creator'  # Arbitrary created by for test
# #     )
# #     visit requests_path # Visit the requests page to see the created request
# #   end
  
#   Given('I have a request:') do 
#     visit '/requests/new'
    
#   end

#   When('I delete the request') do
#     steps %{
#       When I follow "Delete" for the request with title "#{@request.title}"
#     }
#   end
  
#   Then('the request should be deleted successfully') do
#     expect(Request.exists?(@request.id)).to be_falsey
#     steps %{
#       Then I should see "Request deleted successfully"
#     }
#   end
  
#   When('I delete a request that does not exist') do
#     visit request_path(id: 'non-existent-id')
#     click_button 'Delete'
#   end
  
#   Then('I should see an error message {string}') do |message|
#     steps %{
#       Then I should see "#{message}"
#     }
#   end
  
#   Then('the request with title {string} should not exist') do |title|
#     expect(Request.find_by(title: title)).to be_nil
#   end
  
#   Given('I am logged in as a different user') do
#     # Similar to 'I am logged in' step but create and log in a different user
#   end
  
#   Given('I am not logged in') do
#     visit destroy_user_session_path
#   end
  
#   When('I attempt to delete a request') do
#     # Attempt to delete without logging in
#     visit request_path(id: @request.id)
#     click_button 'Delete'
#   end
  
#   Then('I should be redirected to the login page') do
#     expect(page).to have_current_path(new_user_session_path)
#   end
  
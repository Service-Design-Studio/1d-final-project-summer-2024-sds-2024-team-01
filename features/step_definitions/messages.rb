And("I send a message to another user") do
    fill_in "message[message_text]", with: "Hello, this is a test message."
    click_button "Send"
    sleep 15
end

Then("the message should appear in the chat") do
    expect(page).to have_content("Hello, this is a test message.")
end





Given("I am in a chat with another user") do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:random_user)
    @chat = FactoryBot.create(:chat, applicant: @user, requester: @other_user)
    login_as(@user, scope: :user)
    visit chat_path(@chat)
  end
  
  When("I send a message to the user") do
    fill_in "message[message_text]", with: "Hello, this is a test message."
    find('.send-btn-square').click
  end
  
  Then("the message should appear in the chat") do
    expect(page).to have_content("Hello, this is a test message.")
  end
  
  Given("another user sends me a message") do
    @other_user = FactoryBot.create(:random_user)
    @chat = FactoryBot.create(:chat, applicant: @other_user, requester: @user)
    @message = FactoryBot.create(:message, chat: @chat, sender: @other_user, receiver: @user, message_text: "Hello, this is a test message.")
    login_as(@user, scope: :user)
    visit chat_path(@chat)
  end
  
  Then("I should see a notification on the navbar indicating a new message") do
    # Implementation of notification check
    expect(page).to have_selector('#notification', text: '1')
  end
  
When('I click on the chat button') do
  find('.custom-btn-chat_my').click
end

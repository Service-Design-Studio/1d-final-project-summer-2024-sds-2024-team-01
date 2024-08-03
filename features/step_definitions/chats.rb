# /c:/Users/Asus/Documents/1d-final-project-summer-2024-sds-2024-team-01/features/step_definitions/chats.rb

#view_chats.feature

#myrequests page
Then("I should be redirected to a chat with that user") do
    expect(page).to have_content('Alice Smith')
end

And("I choose {string}") do |button_text|
    find('a.btn.custom-btn-chat_my', text: button_text).click
end

#navbar
Given("I have a chat with another user") do
    Chat.create(
        applicant_id: User.where(name: 'Harrison Ford').take.id,
        requester_id: User.where(name: "Alice Smith").take.id,
        request_id: Request.where(title: 'Test Request to Apply').take.id
    )
    Message.create(
        message_text: 'Hello, this is a test message.',
        chat_id: Chat.where(applicant_id: User.where(name: 'Harrison Ford').take.id).take.id,
        sender_id: User.where(name: 'Harrison Ford').take.id,
        receiver_id: User.where(name: 'Alice Smith').take.id,
        read: false
    )
end

Then('I should be redirected to the chats page') do
    expect(page).to have_current_path(chats_path)
end

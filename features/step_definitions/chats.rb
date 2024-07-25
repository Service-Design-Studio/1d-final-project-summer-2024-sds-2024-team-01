# /c:/Users/Asus/Documents/1d-final-project-summer-2024-sds-2024-team-01/features/step_definitions/chats.rb

#view_chats.feature

#myrequests page
Then("I should be redirected to a chat with that user") do
    expect(page).to have_content('Alice Smith')
end

And("I choose {string}") do |button_text|
    find('a.btn.custom-btn-chat_my', text: button_text).click
  end

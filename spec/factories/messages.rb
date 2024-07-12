FactoryBot.define do
  factory :random_message, class: 'Message' do
    message_text { Faker::Quote.fortune_cookie }
    read { false }
    created_at { DateTime.now }
    updated_at { DateTime.now }

    association :chat, factory: :random_chat
    association :sender, factory: :random_user
    association :receiver, factory: :random_user
  end
end

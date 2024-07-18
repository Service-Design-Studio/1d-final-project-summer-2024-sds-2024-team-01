FactoryBot.define do
  factory :random_chat, class: 'Chat' do
    association :applicant, factory: :random_user
    association :requester, factory: :random_user
    association :request, factory: :request
  end
end

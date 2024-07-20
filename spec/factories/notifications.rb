FactoryBot.define do
  factory :test_notification, class: 'Notification' do

    header { "Test Notification" }
    message { "This is a test notification" }
    url { '/myrequests' }
    read { false }
    association :notification_for, factory: :random_user
  end
end

FactoryBot.define do
  factory :random_role, class: 'Role' do
    sequence(:id) {|n| n + Role.maximum(:id) + 1 }
    role_name { Faker::Kpop.girl_groups }
  end
end

namespace :db do
  desc 'Drop, create, migrate, seed and populate sample data'
  task prepare: [:drop, :create, 'schema:load', :seed, :create_dummy_data] do
    puts 'Ready to go!'
  end

  desc 'Populates the database with sample data'
  task create_dummy_data: :environment do
    include FactoryBot::Syntax::Methods

    ActiveRecord::Base.logger.silence do
      first = create(:dummy_user)
      second = create(:dummy_user_two)
      third = create(:dummy_user_three)
      6.times do
        rq = build(:request, created_by: first.id, date: Faker::Date.backward(days: 365), status: 'Completed')
        rq.save(validate: false)
      end
      4.times do
        create(:request,
               created_by: first.id,
               reward: "$#{Faker::Number.between(from: 10, to: 200)}",
               reward_type: 'Cash')
      end
      4.times { create(:request, created_by: second.id) }
      4.times { create(:request, created_by: third.id) }
      10.times { create(:request) }
      2.times { create(:reviewrequester, review_by: first) }
      2.times { create(:reviewrequester, review_for: first) }
      3.times { create(:reviewapplicant, review_for: first) }
      3.times { create(:reviewapplicant, review_by: first) }
      2.times { create(:reviewapplicant, review_for: first, review_by: second) }
      4.times { create(:reviewrequester, review_by: second) }
      4.times { create(:reviewapplicant, review_by: third) }
      4.times { create(:reviewapplicant, review_for: third) }

      user_ids = [first.id, second.id, third.id]
      non_completed_requests = Request.where(created_by: user_ids).where.not(status: 'Completed').pluck(:id)

      # Create 30 applications for random non-completed requests
      30.times do
        request_id = non_completed_requests.sample
        applicant_id = create(:random_user).id

        create(:application, request_id:, applicant_id:)
      end
    end
  end
end

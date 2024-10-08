namespace :db do
  desc 'Drop, create, migrate, seed and populate sample data'
  task prepare: [:drop, :create, 'schema:load', :seed, :create_dummy_data] do
    puts 'Complete!'
  end

  desc 'Populates the database with sample data'
  task create_dummy_data: :environment do
    include FactoryBot::Syntax::Methods

    ActiveRecord::Base.logger.silence do
      print 'Creating dummy data...'
      first = create(:dummy_user)
      second = create(:dummy_user_two)
      third = create(:dummy_user_three)
      admin = create(:admin_user)

      # Create user reports
      UserReport.create!(reported_user: first, reported_by: admin, report_reason: "Suspicious activity", status: "under_review")
      UserReport.create!(reported_user: second, reported_by: admin, report_reason: "Violation of terms", status: "ban")
      UserReport.create!(reported_user: third, reported_by: admin, report_reason: "Harassment", status: "under_review")

      # Create specific user and request
      millard_robel = create(:millard_robel)
      create(:specific_request, user: millard_robel)
      
      6.times do
        rq = build(:requestwiththumbnail, created_by: first.id, date: Faker::Date.backward(days: 365),
                                          status: 'Completed')
        rq.save(validate: false)
      end
      4.times do
        create(:requestwiththumbnail,
               created_by: first.id,
               reward: "$#{Faker::Number.between(from: 10, to: 200)}",
               reward_type: 'Cash')
      end
      print "\r10% Complete                      "
      4.times { create(:requestwiththumbnail, created_by: second.id) }
      4.times { create(:requestwiththumbnail, created_by: third.id) }
      print "\r20% Complete                      "
      10.times { create(:requestwiththumbnail) }
      2.times { create(:reviewrequester, review_by: first) }
      2.times { create(:reviewrequester, review_for: first) }
      print "\r30% Complete                      "
      3.times { create(:reviewapplicant, review_for: first) }
      3.times { create(:reviewapplicant, review_by: first) }
      print "\r40% Complete                      "
      2.times { create(:reviewapplicant, review_for: first, review_by: second) }
      4.times { create(:reviewrequester, review_by: second) }
      4.times { create(:reviewapplicant, review_by: third) }
      print "\r50% Complete                      "
      4.times { create(:reviewapplicant, review_for: third) }

      6.times { create(:application, applicant_id: first.id, request_id: create(:requestwiththumbnail).id) }
      print "\r60% Complete                      "
      3.times { create(:application, applicant_id: second.id, request_id: create(:requestwiththumbnail).id) }
      5.times { create(:application, applicant_id: third.id, request_id: create(:requestwiththumbnail).id) }

      user_ids = [first.id, second.id, third.id]
      non_completed_requests = Request.where(created_by: user_ids).where.not(status: 'Completed').pluck(:id)
      first_requests = Request.where(created_by: first.id).where.not(status: 'Completed')

      print "\r70% Complete                      "
      5.times { create(:random_chat, request: first_requests.sample) }
      5.times { create(:random_chat, applicant: first) }
      print "\r80% Complete                      "
      5.times { create(:random_chat, applicant: second) }
      5.times { create(:random_chat, applicant: third) }

      20.times { create(:random_charity) }

      Chat.all.each do |chat|
        rand(1..3).times do
          rand(1..4).times do
            create(:random_message, chat:, sender: chat.requester, receiver: chat.applicant)
          end
          rand(1..4).times do
            create(:random_message, chat:, sender: chat.applicant, receiver: chat.requester)
          end
        end
      end
      print "\r90% Complete                      "
      # Create 30 applications for random non-completed requests
      30.times do
        request_id = non_completed_requests.sample
        applicant_id = create(:random_user).id

        create(:application, request_id:, applicant_id:)
      end
      5.times do
        create(:test_notification, notification_for: first)
      end

      # Mock data for corporate users
      4.times do
        test_company = create(:random_company, status: 'Inactive')
        create(:user, status: 'Inactive', company_id: test_company.id, role_id: 3, number: nil)
      end

      abc_company = create(:random_company, status: 'Active')
      create(:user, status: 'Active', company_id: abc_company.id, role_id: 3, number: nil, email: 'cvm1@test.com')
      create(:random_company_code, company: abc_company)

      create(:user, email: 'cv@test.com', status: 'Active', company_id: abc_company.id, role_id: 4, number: nil)
      10.times do
        create(:user, status: 'Active', company_id: abc_company.id, role_id: 4, number: nil)
        create(:random_charity)
      end
      create(:user, email: 'charity@test.com', status: 'Active', charity_id: Charity.first.id, role_id: 5, number: nil)

      create(:user, status: 'Active', company_id: create(:random_company, status: 'Active').id, role_id: 3, number: nil, email: 'cvm2@test.com')
      create(:user, status: 'Active', company_id: create(:random_company, status: 'Active').id, role_id: 3, number: nil, email: 'cvm3@test.com')

      # Create dummy data for charities
      char1 = create(:inexpensive_charity)
      char2 = create(:tasty_charity)
      char3 = create(:delightful_charity)

      # Spe = cific companies
      char4 = create(:friendly_company)
      char5 = create(:grace_company)
      char6 = create(:love_company)

      create(:user, email: 'charity1@test.com', status: 'Active', charity_id: char1.id, role_id: 5, number: nil)
      create(:user, email: 'charity2@test.com', status: 'Active', charity_id: char2.id, role_id: 5, number: nil)
      create(:user, email: 'charity3@test.com', status: 'Active', charity_id: char3.id, role_id: 5, number: nil)
      create(:user, email: 'charity4@test.com', status: 'Active', charity_id: char4.id, role_id: 5, number: nil)
      create(:user, email: 'charity5@test.com', status: 'Active', charity_id: char5.id, role_id: 5, number: nil)
      create(:user, email: 'charity6@test.com', status: 'Active', charity_id: char6.id, role_id: 5, number: nil)


      print "\r100% Complete                      "
    end
  end
end

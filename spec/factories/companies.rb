FactoryBot.define do
          factory :company do
            company_name { "Sample Company" }
            company_code { "COMP123" }
            status { "active" }
          end
        end
        
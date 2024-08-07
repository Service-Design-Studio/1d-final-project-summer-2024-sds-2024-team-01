# include simplecov reports for RSpec
require 'simplecov'
SimpleCov.start 'rails' do
    add_filter 'app/mailers'
    add_filter 'app/jobs'
    add_filter 'app/channels'
    add_filter 'app/controllers/my_devise'
    add_filter 'app/controllers/api'
    add_filter 'app/controllers/application_controller.rb'
    add_filter 'app/helpers/media_helper.rb'
    add_filter 'app/helpers/pdf_display_helper.rb'
    add_filter 'app/gemini/gemini_api.rb'
end

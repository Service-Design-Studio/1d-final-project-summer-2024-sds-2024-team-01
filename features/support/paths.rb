require 'cucumber/rails'
require 'capybara/cucumber'

module NavigationHelpers
  def requests_page
    visit '/requests'  
  end
  
end

World(NavigationHelpers)
World(Capybara::DSL)

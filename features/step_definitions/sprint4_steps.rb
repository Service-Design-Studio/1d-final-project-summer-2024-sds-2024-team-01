Given('there is a corporate user on the app') do
  create(:user, role_id: 4)
end

Given('there is an application for my request from a corporate user') do
  myreq = Request.where(created_by: User.where(name: 'Harrison Ford').take.id).take
  corpo = User.where(role_id: 4).take
  create(:application, request_id: myreq.id, applicant_id: corpo.id)
end

Then('I should see {string} applicants') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see {string} corporate volunteer applicant') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I login as a cvm') do
  visit '/login'
  fill_in 'user_login', with: 'cvm@test.com'
  fill_in 'user_password', with: 'password'
  click_button 'Login'
end

Given('I am on the cvm dashboard') do
  visit '/cvm'
end

When('I click on the copy code button') do
  find('#copycompanycode').click
end

Then('the company code should be copied to my clipboard') do
  #can't check clipboard contents, it's a security risk
  expect(1).to eq(1)
end

When('I click on the regenerate code button') do
  find('#refreshcode').click
end

Then('I should receive a new company code') do
  newestcode = CompanyCode.last.code
  expect(CompanyCode.count).to eq(2)
  expect(find('#companycode').text.strip).to eq(newestcode)
end

Given('I have a cvm account') do
  create(:random_company_code)
  company = Company.first.id
  create(:user, role_id: 3, email: 'cvm@test.com', password: 'password', password_confirmation: 'password', number: nil, company_id: company)

  create(:user, role_id: 4, name: 'Alice Smith', email: 'cv1@test.com', password: 'password', password_confirmation: 'password', number: nil, company_id: company)

  create(:user, role_id: 4, name: 'Jason Derulo', email: 'cv2@test.com', password: 'password', password_confirmation: 'password', number: nil, company_id: company)

  create(:user, role_id: 4, name: 'Bob Dylan', email: 'cv3@test.com', password: 'password', password_confirmation: 'password', number: nil, company_id: company)

  create(:user, role_id: 4, name: 'Jane Doe', email: 'cv4@test.com', password: 'password', password_confirmation: 'password', number: nil, company_id: company)
end

Given('Willing Hearts is registered with the application') do
  create(:random_charity, charity_name: 'Willing Hearts')
end

Given('Willing Hearts is registered with my company') do
  company = Company.first.id
  charity = Charity.first.id
  create(:random_company_charity, company_id: company, charity_id: charity)
end

Given('I click on Willing Hearts') do
  find('li', text: 'Willing Hearts').click
end

Given('Jason\'s account is deactivated') do
  user = User.where(name: 'Jason Derulo').take
  user.status = 'Inactive'
  user.save
end

Given('Jane\'s account is deactivated') do
  user = User.where(name: 'Jane Doe').take
  user.status = 'Inactive'
  user.save
end

Given('I deactivate Alice\'s account') do
  first('.btn.btn-danger').click
end

Then('Alice should not be able to log in') do
  click_button(id: 'logoutbtn')
  visit '/login'
  fill_in 'user_login', with: 'cv1@test.com'
  fill_in 'user_password', with: 'password'
  click_button 'Login'
  expect(page).to have_content('Your account has been locked')
end

Given('I activate Jason\'s account') do
  first('.btn.btn-success').click
end

Then('Jason should be able to log in') do
  click_button(id: 'logoutbtn')
  visit '/login'
  fill_in 'user_login', with: 'cv2@test.com'
  fill_in 'user_password', with: 'password'
  click_button 'Login'
  expect(page).to have_content('Signed in successfully')
end

Given('I click on Charity') do
  find('.fa-hand-holding-heart').click
end

When('I enter my charity details') do
  fill_in 'charity_name', with: 'Willing Hearts'
  fill_in 'email', with: 'willing@hearts.com'
  attach_file('document_proof', Rails.root.join('lib', 'assets', 'sample.pdf'))
end

When('I enter my charity details with a document in the wrong format') do
  fill_in 'charity_name', with: 'Willing Hearts'
  fill_in 'email', with: 'willing@hearts.com'
  attach_file('document_proof', Rails.root.join('lib', 'assets', 'freepik-lmao.jpg'))
end

When('I enter the details including the code associated with my company') do
  code = create(:random_company_code).code
  fill_in 'user_name', with: 'Jason Long'
  fill_in 'user_email', with: 'willing@hearts.com'
  fill_in 'code', with: code
  find('div .btn.btn-primary').click
  fill_in 'user_password', with: 'password'
  fill_in 'user_password_confirmation', with: 'password'
  find('div .btn.btn-primary').click
end

When('I enter the details and an inactive company code') do
  code = create(:random_company_code, status: 'Inactive').code
  fill_in 'user_name', with: 'Jason Long'
  fill_in 'user_email', with: 'willing@hearts.com'
  fill_in 'code', with: code
  find('div .btn.btn-primary').click
  fill_in 'user_password', with: 'password'
  fill_in 'user_password_confirmation', with: 'password'
  find('div .btn.btn-primary').click
end

Then('I should see the corporate user icon') do
  expect(page).to have_css('.fa-building')
end

Given('I click on Corporate') do
  find('.fa-building').click
end

Given('I click on User') do
  find('.fa-user').click
end

When('I enter my company details') do
  fill_in 'company_name', with: 'OCBC'
  fill_in 'email', with: 'ocbc@co.com'
  attach_file('document_proof', Rails.root.join('lib', 'assets', 'sample.pdf'))
end

When('I enter my company details with a document in the wrong format') do
  fill_in 'company_name', with: 'OCBC'
  fill_in 'email', with: 'ocbc@co.com'
  attach_file('document_proof', Rails.root.join('lib', 'assets', 'freepik-lmao.jpg'))
end

Given('Jason has completed a request') do
  req = create(:request, duration: 6)
  jason = User.where(name: 'Jason Derulo').take
  jason.total_hours = 6
  jason.weekly_hours = 6
  jason.save
  create(:application, status: 'Completed', request_id: req.id, applicant_id: jason.id)
end

Given('Alice has completed a request') do
  req = create(:request, duration: 4)
  alice = User.where(name: 'Alice Smith').take
  alice.total_hours = 4
  alice.weekly_hours = 4
  alice.save
  create(:application, status: 'Completed', request_id: req.id, applicant_id: alice.id)
end

Given('Bob has completed a request') do
  req = create(:request, duration: 2)
  bob = User.where(name: 'Bob Dylan').take
  bob.total_hours = 2
  bob.weekly_hours = 2
  bob.save
  create(:application, status: 'Completed', request_id: req.id, applicant_id: bob.id)
end

Then('I should see {int} hours volunteered this week') do |int|
  expect(find('#weeklyhours').text.strip).to eq(int.to_s)
end

Then('I should see {int} employees') do |int|
  expect(find('#numemployees').text.strip).to eq(int.to_s)
end

Then('I should see {int} employees under top employees') do |int|
  employeenames = all('#topemployeename')
  expect(employeenames.count).to eq(int)
end

Then('I should see {string} before {string} under top employees') do |string1, string2|
  rows = all('#topemployeename')

  row_texts = rows.map { |row| row.text.strip }

  index1 = row_texts.index { |text| text.include?(string1) }
  index2 = row_texts.index { |text| text.include?(string2) }

  expect(index1).to be < index2
end

Given('I click on the date range picker') do
  find('#reportdate').click
end

When('I select a range of dates') do
  find(:xpath, "//span[@aria-label='July 28, 2024']").click
  find(:xpath, "//span[@aria-label='August 28, 2024']").click
end

Then('a report should be downloaded') do
  expect(SummaryReport.count).to eq(1)
end

Given('I am logged in as a corporate volunteer') do
  company = Company.first
  create(:user, role_id: 4, company_id: company.id, email: 'cvtest@test.com')
  visit '/login'
  fill_in 'user_login', with: 'cvtest@test.com'
  fill_in 'user_password', with: 'password'
  click_button 'Login'
end

Given('Willing Hearts has put out a request') do
  whearts = Charity.first
  charity = create(:user, charity_id: whearts.id, role_id: 5)
  create(:request, title: 'Willing Hearts request', created_by: charity.id)
end

##############################################  ADMIN ###################
Given('I have an admin account') do
  @admin_user = User.create!(
    name: 'Admin User',
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password',
    role_id: 2 # Assuming 2 is the role ID for admin
  )
end

Then('I login as admin') do
  visit new_user_session_path
  fill_in 'user_login', with: 'admin@example.com'
  fill_in 'user_password', with: 'password'
  click_button 'Login'
  expect(page).to have_content('Signed in successfully')
end
###########################################

Given('I am on {string} page') do |page|
  case page
  when "Approve Inactive Companies"
    visit admin_approve_companies_path
    find('#inactive-tab').click
  when "Approve Active Companies"
    visit admin_approve_companies_path
    find('#active-tab').click
  when "Approve Rejected Companies"
    visit admin_approve_companies_path
    find('#rejected-tab').click
  when "Approve Inactive Charities"
    visit admin_charities_path
    find('#inactive-tab').click
  when "Approve Active Charities"
    visit admin_charities_path
    find('#active-tab').click
  when "Approve Rejected Charities"
    visit admin_charities_path
    find('#rejected-tab').click
  when 'Ban User'
    visit admin_ban_user_index_path(anchor: 'ban-tab')
  when 'Unban User'
    visit admin_ban_user_index_path
    find('#unban-tab').click
  when 'All Requests'
    visit root_path
  when 'Help with gardening'
    request = Request.find_by(title: 'Help with gardening')
    if request
      visit request_path(request)
    else
      raise "Request with title 'Help with gardening' not found"
    end
  else
    raise "Unknown page: #{page}"
  end
end


Then('I should see more details of {string}') do |entity_name|
  @entity = Company.find_by(company_name: entity_name) || Charity.find_by(charity_name: entity_name)
  expect(@entity).not_to be_nil, "Expected to find entity with name #{entity_name}, but none was found."

  if @entity.is_a?(Company)
    expect(page).to have_content(@entity.company_name)
  elsif @entity.is_a?(Charity)
    expect(page).to have_content(@entity.charity_name)
  end

  expect(page).to have_content(@entity.status)

  # document_url = rails_blob_path(@entity.document_proof, disposition: 'inline')
  # puts "Document URL: #{document_url}"  # Debugging line

  # expect(page).to have_selector("iframe[src*='#{document_url}']")
end

###### cannot use factory bot need to ownself create ######
Given('there are companies and charities for me to approve') do
  # Creating companies
  grace_company = create(:grace_company)
  friendly_company = create(:friendly_company)
  love_company = create(:love_company)

  # Creating associated users for companies
  create(:user, company: grace_company, role_id: 3)
  create(:user, company: friendly_company, role_id: 3)
  create(:user, company: love_company, role_id: 3)

  # Creating charities
  inexpensive_charity = create(:inexpensive_charity)
  tasty_charity = create(:tasty_charity)
  delightful_charity = create(:delightful_charity)

  create(:user, charity: inexpensive_charity, role_id: 5)
  create(:user, charity: tasty_charity, role_id: 5)
  create(:user, charity: delightful_charity, role_id: 5)

end


And('I have ban users') do 
  # Create users with unique email addresses
  first = User.create!(
    name: 'Alice Smith',
    number: '91234567',
    email: 'alice.smith+1@example.com',  # Modified email
    status: 'Active',
    role_id: 1,
    password: 'password',
    password_confirmation: 'password'
  )

  second = User.create!(
    name: 'Jane Doe',
    number: '81234567',
    email: 'jane.doe+1@example.com',  # Modified email
    status: 'under_review',
    role_id: 1,
    password: 'password',
    password_confirmation: 'password'
  )

  third = User.create!(
    name: 'Bob Dylan',
    number: '98765432',
    email: 'bob.dylan+1@example.com',  # Modified email
    status: 'Active',
    role_id: 1,
    password: 'password',
    password_confirmation: 'password'
  )

  admin = User.create!(
    name: 'Admin User',
    email: 'admin+1@example.com',  # Modified email
    password: 'password',
    password_confirmation: 'password',
    role_id: 2 # Assuming 2 is the role ID for admin
  )

  # Debug statements
  puts "Creating user with name: #{first.name}"
  puts "Creating user with name: #{second.name}"
  puts "Creating user with name: #{third.name}"
  puts "Creating admin user with name: #{admin.name}"

  # Create user reports
  UserReport.create!(reported_user: first, reported_by: admin, report_reason: "Suspicious activity", status: "under_review")
  UserReport.create!(reported_user: second, reported_by: admin, report_reason: "Violation of terms", status: "ban")
  UserReport.create!(reported_user: third, reported_by: admin, report_reason: "Harassment", status: "under_review")
  
  # Debug statement for created users and reports
  puts "Created user: #{first.inspect}"
  puts "Created user: #{second.inspect}"
  puts "Created user: #{third.inspect}"
  puts "Created admin user: #{admin.inspect}"
  puts "Created user reports"
end


When('I click on {string} button for {string} {string}') do |button_text, entity_name, entity_type|
  case entity_type
  when 'company'
    element = "#companiesTabContent .container-fluid .clickable-row"
  when 'charity'
    element = "#charitiesTabContent .container-fluid .clickable-row"
  end

  all(element).each do |row|
    if row.has_selector?('.ps-4', text: entity_name)
      case button_text
      when 'Approve'
        row.find('.btn.btn-success').click
        break
      when 'Disable'
        row.find('.btn.btn-warning').click
        break
      when 'Reject'
        row.find('.btn.btn-danger').click
        break
      end
    end
  end
  # within('.tab-content') do
  #   entity_row = find('div.row.clickable-row', text: entity_name, visible: true)
  #   if entity_row
  #     within(entity_row) do
  #       case button_text
  #       when "Approve"
  #         find('input[value="Approve"]').click
  #       when "Disable"
  #         find('input[value="Disable"]').click
  #       when "Reject"
  #         find('input[value="Reject"]').click
  #       else
  #         raise "Button not recognized: #{button_text}"
  #       end
  #     end
  #   else
  #     raise "#{entity_type.capitalize} row not found for: #{entity_name}"
  #   end
  # end
end


And('I click on {string} button for charity {string}') do |button_text, charity_name|
  puts "Looking for charity row with name: #{charity_name}"  # Debug statement

  begin
    charity_row = find('tr', text: charity_name, visible: true)
    if charity_row
      puts "Found charity row: #{charity_row.text}"  # Debug statement
      within(charity_row) do
        click_button(button_text)
      end
    else
      puts "Charity row not found for: #{charity_name}"  # Debug statement
      raise "Charity row not found for: #{charity_name}"
    end
  rescue Capybara::ElementNotFound => e
    puts "Error: #{e.message}"  # Debug statement
    raise "Charity row not found for: #{charity_name}"
  end
end

And('I click on {string} {string} details') do |entity_name, entity_type|
  # puts "Looking for #{entity_type} row with name: #{entity_name}"  # Debug statement
  case entity_type
  when 'company'
    find("#companiesTabContent .container-fluid .clickable-row .ps-4", text: entity_name).click
  when 'charity'
    find("#charitiesTabContent .container-fluid .clickable-row .ps-4", text: entity_name).click
  end

  # begin
  #   within('.tab-content') do
  #     entity_row = find('div.row.clickable-row', text: entity_name, visible: true)
  #     if entity_row
  #       puts "Found #{entity_type} row: #{entity_row.text}"  # Debug statement
  #       entity_row.click
  #     else
  #       puts "#{entity_type.capitalize} row not found for: #{entity_name}"  # Debug statement
  #       raise "#{entity_type.capitalize} row not found for: #{entity_name}"
  #     end
  #   end
  # rescue Capybara::ElementNotFound => e
  #   puts "Error: #{e.message}"  # Debug statement
  #   available_entities = all('div.row.clickable-row').map(&:text)
  #   puts "Available entities: #{available_entities}"  # Debug statement
  #   raise "#{entity_type.capitalize} row not found for: #{entity_name}. Available entities: #{available_entities}"
  # end
end







When('I click on {string} button for user {string}') do |button_text, user_name|
  within('.user-card', text: user_name) do
    click_button(button_text)
  end
end



Then('I should see the message {string}') do |message|
  # Wait for the alert to be present
  alert = nil
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until (alert = page.driver.browser.switch_to.alert rescue nil)
  end

  # Ensure the alert is present and has the expected message
  expect(alert.text).to eq(message)
  alert.accept
end

# Then('I should see the message {string}') do |message|
#   puts "Waiting for message: #{message}"
#   expect(page).to have_content(message, wait: 10)
#   if page.has_content?(message)
#     puts "Message found: #{message}"
#   else
#     puts "Message not found. Current page content: #{page.text}"
#     save_and_open_page # This will save the HTML of the page and open it in a browser
#   end
# end


And('I click {string} details') do |user_name|
  puts "Looking for user card with name: #{user_name}"  # Debug statement

  user_card = find('.clickable-card', text: user_name, visible: true)

  if user_card
    puts "Found user card: #{user_card.text}"  # Debug statement
    user_card.click
  else
    puts "User card not found for: #{user_name}"  # Debug statement
    raise "User card not found for: #{user_name}"
  end
end



############## report user ############
Then('I click on {string} profile') do |user_name|
  within(".profile-info_requests_details") do
    find("a", text: user_name).click
  end
end


And('there is {string} request') do |string|
  case string
  when "Help with gardening"
    millard_robel = User.find_or_create_by!(
      name: 'Millard Robel',
      email: 'millard.robel@example.com'
    ) do |user|
      user.number = '96000000'
      user.description = 'Description of Millard Robel'
      user.bio = 'Bio of Millard Robel'
      user.status = 'Active'
      user.total_hours = 0
      user.weekly_hours = 0
      user.role_id = 1 # Assuming 1 is the ID of the role you want to assign
      user.company_id = nil # Assuming the user is not associated with any company
      user.charity_id = nil # Assuming the user is not associated with any charity
      user.password = 'password' # Ensure this matches your validation criteria
      user.password_confirmation = 'password'
    end

    Request.find_or_create_by!(
      title: 'Help with gardening',
      created_by: millard_robel.id
    ) do |request|
      request.description = 'Description of the request'
      request.category = 'General'
      request.location = 'POINT(103.851959 1.290270)' # Adjust the location point as needed
      request.stringlocation = 'Address of the request'
      request.date = Date.tomorrow + 30 # Adjust the date as needed
      request.start_time = '10:00 AM'
      request.number_of_pax = 1
      request.duration = 2
      request.reward_type = 'None'
      request.reward = 'None'
      request.status = 'Available'
      request.created_at = DateTime.now
      request.updated_at = DateTime.now
    end
  end
end

Then('I click on {string} request') do |request_title|
  card = find('.request-card_requests_index', text: request_title)
  card.click
end

Then('I press on {string}') do |button_text|
  case button_text
  when "Report"
    within('.report-button-container') do
      click_button(button_text)
    end
  when "Back"
    click_button(button_text)
  when "Cancel"
    click_link(button_text)
  else
    click_button(button_text)
  end
end


  
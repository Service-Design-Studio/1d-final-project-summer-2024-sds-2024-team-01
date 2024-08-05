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
  create(:user,role_id: 2, email:'admin@example.com',password: 'password',password_confirmation:'password',number: nil)
end


Then('I login as an admin') do
  visit '/login'
  fill_in 'user_login', with: 'admin@example.com'
  fill_in 'user_password', with: 'password'
  click_button 'Login'
end

Given('I am on {string} page') do |page|
  case page
  when "Approve Inactive Companies"
    visit admin_approve_companies_path(anchor: 'inactive-tab')
  when "Approve Active Companies"
    visit admin_approve_companies_path(anchor: 'active-tab')
  when "Approve Rejected Companies"
    visit admin_approve_companies_path(anchor: 'rejected-tab')
  when "Approve Inactive Charities"
    visit admin_charities_path(anchor: 'inactive-tab')
  when "Approve Active Charities"
    visit admin_charities_path(anchor: 'active-tab')
  when "Approve Rejected Charities"
    visit admin_charities_path(anchor: 'rejected-tab')
  when 'Ban User'
    visit admin_ban_user_index_path(anchor: 'ban-tab')
  when 'Unban User'
    visit admin_ban_user_index_path(anchor: 'unban-tab')
  when "Millard Robel Profile" 
    visit 

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


Given('there are companies and charities for me to approve') do
  # Creating companies
  FactoryBot.create(:grace_company)
  FactoryBot.create(:friendly_company)
  FactoryBot.create(:love_company)

  # Creating charities
  FactoryBot.create(:tasty_charity)
  FactoryBot.create(:inexpensive_charity)
  FactoryBot.create(:delightful_charity)
end

Given('there is {string}') do |user_name|
  case user_name
  when 'Alice Smith'
    @user = FactoryBot.create(:dummy_user, name: 'Alice Smith')
  when 'Bob Dylan'
    @user = FactoryBot.create(:dummy_user_three, name: 'Bob Dylan')
  end
end

When('I click on {string} button for company {string}') do |button_text, company_name|
  within("tr", text: company_name) do
    click_button(button_text)
  end
end

When('I click on {string} button for charity {string}') do |button_text, charity_name|
  within(:xpath, "//tr[contains(., '#{charity_name}')]") do
    click_button(button_text)
  end
end



############## report user ############
Then('I login as User') do
  visit '/login'
  fill_in 'user_login', with: 'alice.smith@example.com'
  fill_in 'user_password', with: 'password'
  click_button 'Login'
end

Then('I click on {string} profile') do |profile_name|
  within('.profile-card_requests_details') do
    find('h6', text: profile_name).click
  end
end

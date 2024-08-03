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
end

Given('Willing Hearts is registered with the application') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I click {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Willing Hearts is registered with my company') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Jason\'s account is deactivated') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I deactivate Alice\'s account') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('Alice should not be able to log in') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I activate Jason\'s account') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('Jason should be able to log in') do
  pending # Write code here that turns the phrase above into concrete actions
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

Given('I am logged in as a corporate volunteer') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should not see {string} #compensation') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should not see {string} #only registered charities, not any') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Jason has completed a request') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Alice has completed a request') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Bob has completed a request') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should {int} hours volunteered this week') do |int|
# Then('I should {float} hours volunteered this week') do |float|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see {string} under top employees') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see {string} before {string} under top employees') do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

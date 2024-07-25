Given('I have a completed request with accepted applicants') do
  req = create(:request, created_by: User.where(name: 'Harrison Ford').take.id, status: 'Completed')
  create(:random_application, request: req, status: 'Accepted')
  create(:random_application, request: req, status: 'Accepted')
end

When('I enter review details') do
  find('.fa-star', match: :first).click
  find('#review_review_content').set('hehehoho')
end

Given('I have completed a request') do
  create(:random_application, request: create(:request, status: 'Completed'), applicant: User.where(name: 'Harrison Ford').take, status: 'Accepted')
end

When('I click on Leave a review') do
  find('.leave-review-btn_mark_completed', match: :first).click
end

# spec/views/requests/edit.html.erb_spec.rb
require 'rails_helper'

RSpec.describe "requests/edit", type: :view do
  before(:each) do
    @request = assign(:request, Request.create!(
      user: create(:user),
      title: "Test Title",
      category: "Teaching",
      location: "Test Location",
      date: Date.today,
      number_of_pax: 3,
      duration: 4,
      reward_type: "Yes",
      status: "Pending",
      created_by: "User ID or Name",
      start_time: "10:00",
      end_time: "14:00",
      description: "Test description",
      reward: "Yes",
      reward_description: "Free lunch"
    ))
  end

  it "renders the edit request form" do
    render

    assert_select "form[action=?][method=?]", request_path(@request), "post" do
      assert_select "input[name=?]", "request[title]"
      assert_select "input[name=?]", "request[date]"
      assert_select "select[name=?]", "request[category]"
      assert_select "input[name=?]", "request[location]"
      assert_select "input[name=?]", "request[start_time]"
      assert_select "input[name=?]", "request[end_time]"
      assert_select "textarea[name=?]", "request[description]"
      assert_select "input[name=?]", "request[reward]"
      assert_select "input[name=?]", "request[reward_description]"
    end
  end
end

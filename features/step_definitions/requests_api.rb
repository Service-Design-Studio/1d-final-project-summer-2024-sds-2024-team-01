require 'httparty'
require 'json'

#General steps for API
uri = "http://localhost:3000/api/v3/requests"

When ('I send a {string} request') do |method|
  headers = {'Content-Type' => 'application/json'}
  case method
  when 'GET'
    @response = HTTParty.send(method.downcase, uri)
  when 'POST'
    # puts "Sending POST request with body: #{@request_data.to_json}"
    @response = HTTParty.post(uri, body: @request_body.to_json, headers: headers)
  when 'PATCH'
    patch_uri = "#{uri}/#{@existing_request.id}"
    @response = HTTParty.patch(patch_uri, body: @request_body.to_json, headers: headers)
  when 'DELETE'
    if @existing_request
      delete_uri = "#{uri}/#{@existing_request.id}"
    else
      delete_uri = "#{uri}/#{@non_existent_request}"
    end
    @response = HTTParty.delete(delete_uri)
  end
end

Then ('I should see a {int} response') do |status|
  expect(@response.code).to eq(status)
end

And ('I fill in the following details in json format:') do |table|
  @request_data = table.rows_hash
  phone_number = @request_data.delete('phone_number')
  password = @request_data.delete('password')
  @request_body = {phone_number: phone_number, password: password, request: @request_data}
end

#Specific steps for API

And ('I should see the requests in json format') do
  expect { JSON.parse(@response.body) }.not_to raise_error
end

Given ('the request {string} exists') do |request_title|
  @existing_request = Request.find_by(title: request_title)
  unless @existing_request
    user = User.find_by(number: '96789012') || User.first
    raise "User not found" unless user
    @existing_request = Request.create!(
      title: request_title,
      description: 'Looking for someone to help with my backyard garden',
      category: 'Manual Labour',
      location: 'POINT(34.052235 -118.243683)',
      date: '2024-07-30',
      start_time: '13:10',
      number_of_pax: 5,
      duration: 5,
      reward_type: 'Money',
      reward: '$30',
      status: 'Available',
      created_by: user.id,
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
  end
  p @existing_request
end

Given ('the request {string} does not exist') do |request_title|
  @non_existent_request = Request.find_by(title: request_title)
  if !@non_existent_request
    @non_existent_request = 999999
  end
  p @non_existent_request
end
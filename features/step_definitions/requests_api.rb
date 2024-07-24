require 'httparty'
require 'json'

#General steps for API
uri = "http://localhost:3000/api/v3/requests"

When ('I send a {string} request') do |method|
  headers = {'Content-Type' => 'application/json'}
  case method
  when 'GET'
    if @existing_request
      get_uri = "#{uri}/#{@existing_request.id}"
    else
      get_uri = uri
    end
    @response = HTTParty.get(get_uri, body: @request_body.to_json, headers: headers)
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

Given ('{int} requests exist') do |request_count|
  request_count.times {FactoryBot.create(:request)}
end

And ('I should see {string} in json format') do |request_title|
  begin
    json_response = JSON.parse(@response.body)

    case request_title.downcase
    when 'all the requests'
      expect(json_response).to be_an(Array), "Expected an array of requests, but got: #{json_response.class}"
      expect(json_response).not_to be_empty, "Expected non-empty array of requests"
    else
      # Assume request_type is a specific request title
      if json_response.is_a?(Array)
        matching_request = json_response.find { |request| request['title'] == request_title }
        expect(matching_request).to be_present, "Could not find request with title '#{request_title}' in the response"
      elsif json_response.is_a?(Hash)
        expect(json_response['title']).to eq(request_title), "Expected request title '#{request_title}', but got '#{json_response['title']}'"
      else
        fail "Unexpected JSON structure. Response: #{json_response}"
      end
    end

  rescue JSON::ParserError => e
    fail "Failed to parse JSON response: #{e.message}. Raw response body: #{@response.body}"
  end
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
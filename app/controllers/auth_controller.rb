# require "uri"
# require "net/http"

class AuthController < ApplicationController
  def login
    # Singpass Login API (Discontinued)
    # params = {
    #   'scope' => 'openid',
    #   'response_type' => 'code'
    # }
    #
    # uri = URI('http://api.weatherapi.com/v1/current.json')
    # uri.query = URI.encode_www_form(params)
    #
    # x = Net::HTTP.get(uri)
    # puts "getted"
    # puts x
    #
  end

  def register
  end
end

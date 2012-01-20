#encoding: utf-8
require 'rest_client'
require 'json'

class TheKeyStone
  attr_accessor :last_error, :last_error_code
  
  GATEKEEPER_API_VERSION = 1
  GATEKEEPER_API_URL     = "http://thegatekeeper.wixelhq.com"

  def initialize(api_key)
    @api_key = api_key
    @last_error = ""
    @last_error_code = ""    
  end
  
  def set_api_key(api_key)
    @api_key = api_key
  end
  
  # Fetch a user profile from the API
  #
  def get_user(id)
    begin
      user = JSON.parse(RestClient.get construct_url("user/#{id}"))
    rescue RestClient::ResourceNotFound => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Perform the user signup
  #
  def signup(params={})
    begin
      JSON.parse(RestClient.put construct_url("user"), params)
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Perform the user sign in & return the UID
  #
  def signin(params={})
    begin
      JSON.parse(RestClient.post construct_url("user/signin"), params)
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Verify a user account
  #
  def verify_user(uid)
    begin
      RestClient.get construct_url("user/verify/#{uid}")
      true
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Update a user profile
  #
  def update_user(uid, params={})
    begin
      RestClient.post construct_url("user/#{uid}"), params
      true
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Generate & return the one-time login hash
  #
  def generate_onetime_login_hash(uid)
    begin
      JSON.parse(RestClient.get construct_url("user/generate_one_time_hash/#{uid}"))
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Signin with the one-time login hash
  #
  def signin_with_hash(hash)
    begin
      JSON.parse(RestClient.get construct_url("user/signin_with_hash/#{hash}"))
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Delete a user account
  #
  def delete_user(uid)
    begin
      RestClient.delete construct_url("user/#{uid}")
      true
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end    
  end
  
  # Fetch profile data for a user, one column at a time
  #
  def profile_data(uid, field)
    begin
      JSON.parse(RestClient.get construct_url("user/#{uid}/#{field}"))
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end    
  end
  
  private
  
  def reset_errors
    @last_error = ""
    @last_error_code = 0
  end
  
  def construct_url(path)
    reset_errors
    "#{GATEKEEPER_API_URL}/v#{GATEKEEPER_API_VERSION}/#{path}?api_key=#{@api_key}"
  end
  
end

#encoding: utf-8
require 'rest_client'
require 'json'

class TheKeyStone
  attr_accessor :last_error, :last_error_code
  
  GATEKEEPER_API_VERSION = 1
  #GATEKEEPER_API_URL     = "http://thegatekeeper.wixelhq.com"
  GATEKEEPER_API_URL     = "http://127.0.0.1:9292"

  # Initialize the class and set the API key for this instance.
  #
  # @param [String] a valid API key
  def initialize(api_key)
    @api_key = api_key
    @last_error = ""
    @last_error_code = ""    
  end
  
  # Set/Change the API key for this instance.
  #
  # @param [String] a valid API key
  def set_api_key(api_key)
    @api_key = api_key
  end
  
  # Fetch a complete user profile from the service.
  #
  # @param [String] the user ID
  # @return [Hash] a user profile
  def get_user(id)
    begin
      user = JSON.parse(RestClient.get construct_url("user/#{id}"))
    rescue RestClient::ResourceNotFound => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Create a new user account and return the ID
  #
  # @param [Hash] the signup parameters: email, password, (any other profile fields)
  # @return [Hash] the new user ID hash
  def signup(params={})
    begin
      JSON.parse(RestClient.put construct_url("user"), params)
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Authenticate a user
  # 
  # @param [Hash] the signin parameters: email, password
  # @return [Hash] the user ID hash
  def signin(params={})
    begin
      JSON.parse(RestClient.post construct_url("user/signin"), params)
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Verify a created user account (optional step depending on your app flow)
  #
  # @param [String] the user ID
  # @return [Boolean] 
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
  # @param [String] the user ID
  # @param [Hash] the updated profile fields and values
  # @return [Boolean]
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
  # @param [String] the registered users email address
  # @return [Hash] the generated one-time log in hash
  def generate_onetime_login_hash(email)
    begin
      JSON.parse(RestClient.get construct_url("user/generate_one_time_hash/#{email}"))
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Signin with the one-time login hash
  #
  # @param [String] the generated one-time login hashs
  # @return [Hash] the user ID
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
  # @param [String] a valid user ID
  # @return [Boolean]
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
  
  # Fetch individual profile fields
  #
  # @param [String] the user ID
  # @param [String] the field to return
  # @return [Hash] the requested data
  def profile_data(uid, field)
    begin
      JSON.parse(RestClient.get construct_url("user/#{uid}/#{field}"))
    rescue RestClient::BadRequest => e
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end    
  end
  
  # Search for a user account by email
  # 
  # @param [String] the email address to search for
  # @return [Hash] the user account hash
  def search_by_email(email)
    begin
      JSON.parse(RestClient.get construct_url("user/search/by_email/#{email}"))
    rescue RestClient::BadRequest => e      
      puts e.http_body
      @last_error = e.http_body
      @last_error_code = e.http_code
      false
    end
  end
  
  # Reset a user account password
  #
  # @param [String] the user ID
  # @param [String] the new password to be saved
  # @return [Boolean]
  def reset_password(uid, new_password)
    begin
      RestClient.post construct_url("user/#{uid}/reset_password"), {:password => new_password}
      true
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

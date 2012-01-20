require 'test/unit'
require 'thekeystone'
require 'pp'

class TheKeyStoneTest < Test::Unit::TestCase
  def create_instance
    @api = TheKeyStone.new('<your api key>');     
  end
  
  def test_account_flow()
    puts "Testing account flow..."
    
    create_instance
    
    # Test Invalid Email Signup
    invalid_email = @api.signup(:email => "invalid email", :password => "my_password")
    assert_equal "Validation failed - Email is invalid.", @api.last_error
    assert_equal false, invalid_email
        
    # Create the new account
    user = @api.signup(:email => "testaccount_0@test.com", :password => "my_password")
    assert_equal Hash, user.class
    
    # Verify this account
    verified = @api.verify_user(user["uid"])
    assert_equal true, verified
    
    # Fetch the user profile hash
    profile = @api.get_user(user["uid"])
    assert_equal Hash, profile.class
    
    # Delete the new account
    deleted = @api.delete_user(user["uid"])
    assert_equal true, deleted
  end
  
  def test_one_time_login
    puts "Testing one-time login..."    
    
    create_instance  
    
    # Create the new account
    user = @api.signup(:email => "testaccount_0@test.com", :password => "my_password")
    assert_equal Hash, user.class
    
    # Generate the hash
    hash = @api.generate_onetime_login_hash("testaccount_0@test.com") 
    assert_equal Hash, hash.class
    
    # Signin with the hash
    login = @api.signin_with_hash(hash['login_hash'])
    assert_equal Hash, login.class
    
    # Delete the new account
    deleted = @api.delete_user(user["uid"])
    assert_equal true, deleted
  end
  
  def test_update_user_profile
    puts "Testing profile update..."    
    
    create_instance
    
    # Create the new account
    user = @api.signup(:email => "testaccount_0@test.com", :password => "my_password")
    assert_equal Hash, user.class   
    
    # Update the account
    update = @api.update_user(user["uid"], :twitter => "@SeanNieuwoudt", :github => "http://github.com/organizations/Wixel")    
    assert_equal true, update
    
    # Delete the new account
    deleted = @api.delete_user(user["uid"])
    assert_equal true, deleted
  end
  
  def test_profile_field
    puts "Testing profile fields..."        
    
    create_instance    
    
    # Create the new account
    user = @api.signup(:email => "testaccount_0@test.com", :password => "my_password")
    assert_equal Hash, user.class   
    
    # Update the account
    data = @api.profile_data(user["uid"], :email)
    assert_equal Hash, data.class       
    
    # Delete the new account
    deleted = @api.delete_user(user["uid"])
    assert_equal true, deleted
  end
  
  def test_password_reset
    puts "Testing password reset..."        
    
    create_instance    
    
    # Create the new account
    user = @api.signup(:email => "testaccount_0@test.com", :password => "my_password")
    assert_equal Hash, user.class   
    
    # Reset the password
    reset = @api.reset_password(user["uid"],'my_password2')
    assert_equal true, reset
    
    # Re-log in
    user = @api.signin(:email => "testaccount_0@test.com", :password => "my_password2")
    assert_equal Hash, user.class   
    
    # Delete the new account
    deleted = @api.delete_user(user["uid"])
    assert_equal true, deleted
  end
  
  def test_email_search
    puts "Testing email search..."        
    
    create_instance    
    
    # Create the new account
    user = @api.signup(:email => "testaccount_0@test.com", :password => "my_password")
    assert_equal Hash, user.class   
    
    # Search by email
    search = @api.search_by_email("testaccount_0@test.com")
    assert_equal Hash, search.class   
    
    # Delete the new account
    deleted = @api.delete_user(user["uid"])
    assert_equal true, deleted
  end

end
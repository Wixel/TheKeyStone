

#get "/v1/user/:id" do # get profile
#put "/v1/user" do  # sign up user
#post "/v1/user/signin" do # sign in use
#get '/v1/user/verify/:id' do # verify a user account
#post '/v1/user/:id' do # update a user account
#get '/v1/user/generate_one_time_hash/:id' do # genrate a one time hash
#get '/v1/user/signin_with_hash/:hash' do # sign in with a hash
#delete '/v1/user/:id' do # delete account


#get '/v1/user/:id/:field' do # fetch a specific profile field

require './lib/thekeystone'
require 'pp'

api = TheKeyStone.new('e23da4dd60a0779a9f781a1650d13b4a');

user = api.signup(:email => "sean@wasdasdasdadasdixel.net", :password => "deldialer")

pp api.get_user(user["uid"])

#puts user.class

#puts api.last_error
# LOGIN USER
#user = api.signin(:email => 'seasn@isean.co.za', :password => 'deldialer')
#if !user
#  puts api.last_error
#else
#  pp user
#end
#pp api.signin(:email => 'seasn@isean.co.za', :password => 'deldialer')
# => {"uid"=>"4f19494e601cae0001000001"}





# GET USER PROFILE
#pp api.get_user('4f194c79601cae0001000002')
#puts api.last_error

# SIGNUP USER
#new_user = api.signup(:email => "sean@wixel.net", :password => "deldialer")

# VERIFY USER
#puts api.verify_user('4f194c79601cae0001000002') => true/false



# Update user account
#puts api.update_user("4f194c79601cae0001000002", :twitter => "SeanNieuwoudt", :facebook => "SeanNieuwoudt")
#pp api.get_user('4f194c79601cae0001000002')


# Generate Login Hash
#puts api.generate_onetime_login_hash('4f194c79601cae0001000002')

# LOGIN WITH HASH
#puts api.signin_with_hash('1966b4c7dcc7f671720703a3e259f2b3')

# DELETE A USER
#puts api.delete_user('4f194c79601cae0001000002')
#pp api.get_user('4f194c79601cae0001000002')

# FETCH PROFILE FIELD
#pp api.profile_data('4f195b4811983e0001000001', 'email')



# sean@wixel = 4f194c79601cae0001000002

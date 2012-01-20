

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

#user = api.signup(:email => "sean@wasdasdasdadasdixel.net", :password => "deldialer")

#pp api.get_user(user["uid"])



#hash = api.generate_onetime_login_hash("sean@wasdasdasdadasdixel.net")
#3user = api.signin_with_hash(hash["login_hash"])
#pp user

# DELETE A USER
#puts api.delete_user('4f194c79601cae0001000002')
#pp api.get_user('4f194c79601cae0001000002')

# FETCH PROFILE FIELD
pp api.profile_data('4f197491912c0c000100003f', 'email')



# sean@wixel = 4f194c79601cae0001000002

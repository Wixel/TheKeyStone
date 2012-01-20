# Getting Started

*TheKeyStone is an API wrapper around Wixels hosted user authentication and management service.*

1. Go to http://thegatekeeper.wixelhq.com and request access to the service
2. Once you receive your API key, please keep it a secret

``` ruby
gem install thekeystone
```

#  Available Methods

<table>
  <tr>
    <th>Method</th><th>Description</th><th>Return Type</th>
  </tr>
  <tr>
    <td>set_api_key(api_key)</td><td>Set the API key</td><td>None</td>
  </tr>
  <tr>
    <td>get_user(id)</td><td>Fetch a use profile</td><td>Hash on success, false on failure</td>
  </tr>
  <tr>
    <td>signup(params={})</td><td>Perform the user sign up and return new user ID</td><td>Hash on success, false on failure</td>
  </tr>
  <tr>
    <td>signin(params={})</td><td>Signin a user and return the user ID</td><td>Hash on success, false on failure</td>
  </tr>
  <tr>
    <td>verify_user(uid)</td><td>Verify a user account (optional)</td><td>true on success, false on failure</td>
  </tr>
  <tr>
    <td>update_user(uid, params={})</td><td>Update a user profile</td><td>true on success, false on failure</td>
  </tr>
  <tr>
    <td>generate_onetime_login_hash(email)</td><td>Generate a onetime login hash</td><td>Hash on success, false on failure</td>
  </tr>
  <tr>
    <td>signin_with_hash(hash)</td><td>Sign in using a one-time login hash</td><td>Hash on success, false on failure</td>
  </tr>
  <tr>
    <td>delete_user(uid)</td><td>Delete a user account</td><td>true on success, false on failure</td>
  </tr>
  <tr>
    <td>profile_data(uid, field)</td><td>Retrieve a profile field from a user account</td><td>Hash on success, false on failure</td>
  </tr>
</table>

#  Usage Examples

Creating a new user account
---------------------------

``` ruby
require "thekeystone"

api = TheKeyStone.new('[your API key]');

new_user = api.signup(:email => "me@me.com", :password => "mypassword") 
# new_user = {"uid"=>"4f19494e601cae0001000001"}

if !new_user
	puts api.last_error
else
	pp api.get_user(new_user["uid"]) 
end
```

Authenticate a user
-------------------

``` ruby
user = api.signin(:email => "me@me.com", :password => "mypassword")

if !user
	puts api.last_error
else
	pp api.get_user(user["uid"]) # you should store user["uid"] in your session at this point
end
```

Verify a user account
---------------------

``` ruby
api.verify_user('[a user id]') # => true/false
```

Fetch a user profile
--------------------

``` ruby
profile = api.get_user('[a user id]')

# Response:

{
 "email"=>"test@me.com",
 "username"=>nil,
 "full_name"=>"",
 "timezone"=>"London",
 "twitter"=>"",
 "facebook"=>"",
 "github"=>"",
 "linkedin"=>"",
 "about"=>"",
 "latlng"=>"",
 "gender"=>"",
 "phone"=>"",
 "address"=>"",
 "user_api_key"=>"7801cba92f3fe4b5a00070316ed66aac",
 "converted"=>false,
 "conversion_date"=>nil,
 "last_login"=>"2012-01-20T14:05:05+00:00"
}
```

Update a users profile
----------------------
You are able to update multiple fields in a single request.

``` ruby
api.update_user(
	"[a user ID]", :twitter => "@SeanNieuwoudt", :github => "http://github.com/organizations/Wixel"
)
```

Using the one-time log in hash
------------------------------
A one-time log in hash is used when a user has forgotten their password. Your user enters their email 
address on your site and you pass it along to the API. A log in hash will be generated and returned.

You will need to email this to the user and allow them to log in by clicking on a link that 
re-connects to the API and authenticates the user using the hash.

This hash can only be used once and is destroyed after usage.

``` ruby
hash = api.generate_onetime_login_hash('test@me.com') 
# hash = {"login_hash"=>"a9ce493328c52dfdebbc4d1776881dc7"}
	
user = api.signin_with_hash(hash["login_hash"])
# user = {"uid"=>"4f197491912c0c000100003f"}
```

Fetching profile information
----------------------------
If you need to fetch the entire user profile in a single request, please use the api.get_user method instead. 

``` ruby
data = api.profile_data('[a user ID]', 'email')
# data = {"email"=>"sean@wasdasdasdadasdixel.net"}
```







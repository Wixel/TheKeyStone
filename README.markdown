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
    <td>generate_onetime_login_hash(uid)</td><td>Generate a onetime login hash</td><td>Hash on success, false on failure</td>
  </tr>

</table>

#  Usage Examples

Creating a new user account
---------------------------

``` ruby
require "thekeystone"

api = TheKeyStone.new('[your API key]');

new_user = api.signup(:email => "sean@wixel.net", :password => "mypassword")

if !new_user
	puts api.last_error
else
	pp api.get_user(new_user["uid"])
end

```

Creating a new user account
---------------------------



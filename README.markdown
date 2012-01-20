# Getting Started

*TheKeyStone is an API wrapper around Wixels hosted user authentication and management service.*

1. Go to http://thegatekeeper.wixelhq.com and request access to the service
2. Once you receive your API key, please keep it a secret

``` ruby
gem install thekeystone
```

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



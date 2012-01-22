Gem::Specification.new do |s|
  s.name         = 'thekeystone'
  s.version      = '0.5.3'
  s.date         = '2012-01-20'
  s.platform     = Gem::Platform::RUBY
  s.summary      = "TheGateKeeper authentication client"
  s.description  = "TheKeyStone is used to access TheGateKeeper - a hosted user authentication & management service"
  s.authors      = ["Sean Nieuwoudt"]
  s.email        = 'sean@wixel.net'
  s.files        = ["lib/thekeystone.rb"]
  s.homepage     = 'http://github.com/Wixel/TheKeyStone'
  s.require_path = "lib"  
  # Rubyforge
  s.rubyforge_project = s.name
  
  # Dependencies
  s.add_runtime_dependency "rest_client", "~> 1.6.7"  
end
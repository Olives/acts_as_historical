$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "history/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "history"
  s.version     = History::VERSION
  s.authors     = ["Kyle d'Oliveira"]
  s.email       = ["kdoliveira@bravenet.com"]
  s.homepage    = ""
  s.summary     = "Engine that stores and displays history for models"
  s.description = "TODO: Description of History."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "mysql2"
end

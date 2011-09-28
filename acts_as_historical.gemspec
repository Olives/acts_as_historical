$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_historical/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_historical"
  s.version     = ActsAsHistorical::VERSION
  s.authors     = ["Kyle d'Oliveira"]
  s.email       = ["kdoliveira@bravenet.com"]
  s.homepage    = "https://github.com/Olives/acts_as_historical"
  s.summary     = "An engine to record save history for models"
  s.description = "Added methods to record history on models and views to display it"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "jquery-rails"
  s.add_dependency "sass-rails"

  s.add_development_dependency "mysql2"
end

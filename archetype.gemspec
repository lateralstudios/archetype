$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "archetype/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "archetype"
  s.version     = Archetype::VERSION
  s.authors     = ["Tom Beynon"]
  s.email       = ["tombeynon@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Archetype."
  s.description = "TODO: Description of Archetype."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_dependency "sqlite3"
  s.add_dependency "rspec-rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "sass-rails"
end

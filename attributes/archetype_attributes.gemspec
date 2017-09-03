$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../core/lib/archetype/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "archetype_attributes"
  s.version     = Archetype::VERSION
  s.authors     = ["Tom Beynon"]
  s.email       = ["tombeynon@gmail.com"]
  s.homepage    = "http://github.com/lateralstudios/archetype"
  s.summary     = "Management framework for rails"
  s.description = "Management framework for rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'archetype_core', s.version
  s.add_dependency "country_select"
  s.add_dependency "simple_form"
  s.add_dependency "nested_form"
  s.add_dependency "wysiwyg-rails", "<= 2.3.5"
end


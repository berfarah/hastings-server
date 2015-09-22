$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hastings/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hastings"
  s.version     = Hastings::VERSION
  s.authors     = ["Bernardo Farah"]
  s.email       = ["bfarah@walmart.com"]
  s.homepage    = "https://gecgithub01.walmart.com/workshop/hastings-engine"
  s.summary     = "Task runner extraordinaire"
  s.description = "Runs tasks"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.1"
  s.add_dependency "delayed_job"
  s.add_dependency "daemons"
  s.add_dependency "delayed_job_active_record"
  s.add_dependency "delayed_job_recurring"
  s.add_dependency "slim"
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "jquery-rails"
  s.add_dependency "turbolinks"
  s.add_dependency "jquery-turbolinks"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end

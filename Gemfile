source "https://rubygems.org"

# Declare your gem's dependencies in hastings.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gem "rails", "~> 4.2.1"

gem "bootstrap-sass"
gem "data-confirm-modal", github: "ifad/data-confirm-modal"
gem "slim"
# gem "sass-rails", "~> 5.0"
# Sass-C should compile faster
gem "sassc-rails"
gem "uglifier", ">= 1.3.0"
gem "jquery-rails"
gem "redis"

# ?
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc

gem "carrierwave"
gem "delayed_job"
gem "delayed_job_active_record"
gem "delayed_job_recurring"

gem "turbolinks"
gem "jquery-turbolinks"

gem "kaminari"

gem "elasticsearch-model"
gem "elasticsearch-rails"

group :production do
  gem "pg"
end

# Development & Testing
group :development do
  gem "puma"
  gem "spring"
  gem "better_errors" # Much more useful errors page
  gem "meta_request"  # Use with https://github.com/dejan/rails_panel
  gem "quiet_assets"  # Turns off asset generation in log
  gem "bullet"
end



group :development, :test do
  gem "sqlite3"
  gem "byebug" # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "database_cleaner" # Strategies for cleaning/maintaining clean database
  gem "factory_girl_rails" # A library for setting up Ruby objects as test data
  gem "faker" # Fake names, dates, addresses, phone numbers
  gem "pry-nav" # Simple debugging
  gem "pry-rails"
  gem "pry-stack_explorer" # Walk the stack w/ Pry
end

group :test do
  gem "rspec-rails"
  gem "spring-commands-rspec"
  gem "rubocop" # Linting according to ruby style guide
  gem "shoulda-matchers" # Easy testing for common rails functionality
  gem "stackprof"
  gem "simplecov", require: false
  gem "database_cleaner"
end

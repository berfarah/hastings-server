source "https://rubygems.org"

# Declare your gem's dependencies in hastings.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem "bootstrap-sass"
gem "data-confirm-modal", github: "ifad/data-confirm-modal"
gem "slim"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "jquery-rails"

# ?
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc

gem "carrierwave"
gem "sidekiq"
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
  gem "spring"
  gem "better_errors" # Much more useful errors page
  gem "meta_request"  # Use with https://github.com/dejan/rails_panel
  gem "quiet_assets"  # Turns off asset generation in log
end

group :development, :test do
  gem "byebug" # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "capybara" # Testing framework
  gem "capybara-screenshot" # Automatically take fail screens
  gem "database_cleaner" # Strategies for cleaning/maintaining clean database
  gem "factory_girl_rails" # A library for setting up Ruby objects as test data
  gem "faker" # Fake names, dates, addresses, phone numbers
  gem "poltergeist" # Allows running capybara tests on a headless webkit browser
  gem "pry-nav" # Simple debugging
  gem "pry-rails"
  gem "pry-stack_explorer" # Walk the stack w/ Pry
  gem "pry-theme" # Customize Pry's colors
  gem "rspec-rails"
  gem "rubocop" # Linting according to ruby style guide
  gem "shoulda-matchers" # Easy testing for common rails functionality
  gem "spring-commands-rspec"
  gem "web-console" # Access an IRB console on exception pages or by using <%= console %> in views
end

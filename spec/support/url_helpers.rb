Rspec.configure do |config|
  config.before :each, type: :helper do
    helper.class.include Hastings::Engine.routes.url_helpers
  end
end

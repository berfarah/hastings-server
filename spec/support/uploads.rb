RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf(Dir[Rails.root.join("spec", "support", "uploads")])
  end
end

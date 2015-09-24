require "delayed_job_recurring"

module Hastings
  class Engine < ::Rails::Engine
    isolate_namespace Hastings

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
    config.active_job.queue_adapter = :delayed_job
    config.assets.paths << File.expand_path("../../assets/stylesheets", __FILE__)
    config.assets.paths << File.expand_path("../../assets/javascripts", __FILE__)
    config.assets.precompile += %w(hastings/app.css hastings/app.js)
  end
end

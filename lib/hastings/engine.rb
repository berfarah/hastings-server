require "delayed_job_recurring"

module Hastings
  class Engine < ::Rails::Engine
    isolate_namespace Hastings

    config.generators { |g| g.test_framework :rspec }
    config.active_job.queue_adapter = :delayed_job
    config.assets.paths << File.expand_path("../../assets/stylesheets", __FILE__)
    config.assets.paths << File.expand_path("../../assets/javascripts", __FILE__)
    config.assets.precompile += %w(hastings/app.css hastings/app.js)
  end
end

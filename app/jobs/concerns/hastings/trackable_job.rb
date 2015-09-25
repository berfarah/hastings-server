module Hastings
  module TrackableJob
    def initialize(options = {})
      @task = options.delete(:task).id
      super()
    end

    def before(job)
      @instance = Hastings::Task.find(@task).instances.create(job_id: job.id)
    end

    def error(job, exception)
      @instance.logs.create(severity: :fatal, message: [exception.message, exception.backtrace].flatten.join("\n"))
      @instance.failed = true
    end

    def after(job)
      @instance.finished_at = Time.now
      @instance.job_id = nil
      @instance.save!
    end

    private

      # Log function that is provided to any class that inherits from this
      def log(severity, message)
        return if message.nil? || message.empty?
        @instance.logs.create(severity: severity, message: message)
      end
  end
end

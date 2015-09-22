module Hastings
  module Recurring
    # Default
    class Tracked < Base
      def initialize(options = {})
        @task = options.delete(:task).id
      end

      def before(_job)
        @instance = Hastings::Task.find(@task).instances.create
      end

      def perform
        fail NotImplementedError
      end

      def success; end

      def error(job, exception)
        @instance.logs.create(severity: "fatal", message: exception.to_s)
        @instance.failed = true
      end

      def after(_job)
        @instance.finished_at = Time.now
        @instance.save!
      end

      def failure(_job); end

      private

        # Log to our database with corresponding severity
        def log(severity, message)
          return if message.nil? || message.empty?
          Rails.logger.send(severity.to_sym, message)
          @instance.logs.create(severity: severity, message: message)
        end
    end
  end
end

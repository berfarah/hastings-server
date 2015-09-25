module Hastings
  module RecurringJob
    def self.included(base)
      base.include ::Delayed::RecurringJob
      base.run_at(Time.now + 5)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def schedule(options = {})
        @options = options
        super
      end

      def unschedule(options = {})
        @options = options
        super()
      end

      def pause(options = {})
        @options = options
        job.locked_at = Time.zone.now
        job.locked_by = :web_server
        job.save!
      end

      def unpause(options = {})
        @options = options
        return unless job.locked_at || job.locked_by
        job.locked_at = nil
        job.lockedb_by = nil
        job.save!
      end

      # Just overwriting this so that we pass in our options
      # https://github.com/amitree/delayed_job_recurring/blob/master/lib/delayed/recurring_job.rb#L175
      def schedule!(options = {})
        return unless ::Delayed::Worker.delay_jobs
        unschedule(options)
        new(options).schedule!(options)
      end

      private

        def job
          jobs.first
        end

        def jobs
          super().where(queue: @options[:queue])
        end
    end
  end
end

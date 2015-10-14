module RecurringJobConcern
  def self.included(base)
    base.include ::Delayed::RecurringJob
    base.run_at(Time.zone.now + 5)
    base.extend(ClassMethods)
  end

  # We need initialize to take options
  def initialize(_options = {}); end

  module ClassMethods
    # Relies on jobs, which relies on @options
    def schedule(options = {})
      @options = options
      super
    end

    # Relies on jobs, which relies on @options
    def unschedule(options = {})
      @options = options
      super()
    end

    def pause(options = {})
      @options = options
      job || return
      job.update_attributes!(locked_at: Time.zone.now, locked_by: :web_server)
    end

    def unpause(options = {})
      @options = options
      job || return
      job.update_attributes!(locked_at: nil, locked_by: nil)
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

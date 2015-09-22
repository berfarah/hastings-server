module Hastings
  module Recurring
    class Base
      include ::Delayed::RecurringJob
      run_at(Time.now + 5)

      # Overwriting defaults
      class << self
        def schedule(options = {})
          @options = options
          super
        end

        def schedule!(options = {})
          return unless ::Delayed::Worker.delay_jobs
          unschedule(options)
          new(options).schedule!(options)
        end

        def unschedule(options = {})
          @options = options
          super()
        end

        private

          def jobs
            super.where(queue: @options[:queue])
          end
      end
    end
  end
end

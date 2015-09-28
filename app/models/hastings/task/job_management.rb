module Hastings
  class Task
    module JobManagement
      extend ActiveSupport::Concern

      included do
        # Reference: https://github.com/carrierwaveuploader/carrierwave#skipping-activerecord-callbacks
        #
        # We can only update the schedule once the file has been stored (after_save)
        # On that note, we want to unschedule before the record is destroyed so the
        # script can't run when we're deleting it.
        after_commit :update_scheduled
        before_destroy :unschedule
      end

      def running?
        !!instances.last.try(:job_id)
      end

      def failed?
        !!instances.last.try(:failed?)
      end

      def queue
        "#{name.parameterize}_#{id}"
      end

      def run_now
        pause
        Hastings::TaskJob.run(schedule_opts)
      end

      def run_now_done
        unpause
      end

      private

        def update_scheduled
          return unschedule unless enabled
          Hastings::RecurringTaskJob.schedule(schedule_opts)
        end

        def unschedule
          Hastings::RecurringTaskJob.unschedule(schedule_opts)
        end

        def pause
          Hastings::RecurringTaskJob.pause(schedule_opts)
        end

        def unpause
          Hastings::RecurringTaskJob.unpause(schedule_opts)
        end

        def schedule_opts
          { task: self, run_at: Time.parse(run_at), run_every: run_every,
            script: script.path, queue: queue }
        end
    end
  end
end

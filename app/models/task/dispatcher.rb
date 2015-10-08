class Task
  module Dispatcher
    extend ActiveSupport::Concern

    included do
      # Reference: https://github.com/carrierwaveuploader/carrierwave#skipping-activerecord-callbacks
      #
      # We can only update the schedule once the file has been stored aka
      # after_commit. We want to unschedule before the record is destroyed so
      # the script can't run while we're deleting it.
      after_commit :update_schedule
      before_destroy :unschedule
    end

    def update_schedule
      TaskDispatcher.new(self).update_schedule
    end

    def unschedule
      TaskDispatcher.new(self).unschedule
    end
  end
end

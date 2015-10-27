class Task < ActiveRecord::Base
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
      delegate :failed?, :running?,
               :update_schedule, :unschedule,
               to: :dispatcher
    end

    def dispatcher
      @dispatcher ||= TaskDispatcher.new(self)
    end
  end
end

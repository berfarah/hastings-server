require "hastings/ext/parse_time"

module Hastings
  class Instance < ActiveRecord::Base
    include Loggable
    belongs_to :task, dependent: :destroy
    belongs_to :job

    validate :not_negative_duration

    def duration
      return unless [created_at, finished_at].all?(&:present?)
      @duration ||= (finished_at - created_at).ceil
    end

    # Can't alias this because this method is created dynamically
    def started_at
      created_at
    end

    private

      def not_negative_duration
        errors.add(:finished_at, 'is before started_at') if duration &&
                                                            duration < 0
      end
  end
end

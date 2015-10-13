require "ext/parse_time"

class Instance < ActiveRecord::Base
  include Searchable
  include Loggable

  # I really want to do this to solve the N*2 problem with logs#index, but if
  # I do I can't seem to unscope it when called from TasksController
  # default_scope { includes(:task) }

  belongs_to :task, touch: true, counter_cache: true
  belongs_to :job

  validate :not_negative_duration

  def duration
    return unless [created_at, finished_at].all?(&:present?)
    @duration ||= (finished_at - created_at).ceil
  end

  def name
    @name ||= task.name
  end

  alias_method :to_s, :name

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

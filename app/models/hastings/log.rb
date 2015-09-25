module Hastings
  class Log < ActiveRecord::Base
    include Searchable
    belongs_to :loggable, polymorphic: true
    belongs_to :instance, foreign_key: "loggable_id", foreign_type: "Instance"
    belongs_to :app, foreign_key: "loggable_id", foreign_type: "App"

    SEVERITY = %w(info warn error fatal).freeze

    validates :severity, :message, presence: true
    validates_inclusion_of :severity, in: SEVERITY

    scope :errors, -> { where(severity: :error) }
    scope :date, -> (date) {
      where(created_at: date.beginning_of_day..date.end_of_day)
    }
    scope :range, -> (from, to) {
      where(created_at: from.beginning_of_day..to.end_of_day)
    }
  end
end

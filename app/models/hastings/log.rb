module Hastings
  class Log < ActiveRecord::Base
    include Searchable

    SEVERITY = %w(info warn error fatal).freeze

    belongs_to :instance, dependent: :destroy
    validates :severity, :message, presence: true
    validates_inclusion_of :severity, in: SEVERITY

    scope :errors, -> { where(severity: "error".freeze) }
    scope :date, (lambda do |date|
      where(created_at: date.beginning_of_day..date.end_of_day)
    end)
  end
end

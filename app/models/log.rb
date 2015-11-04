class Log < ActiveRecord::Base
  update_index 'logs#log', :self

  belongs_to :loggable, polymorphic: true, touch: true
  belongs_to :instance, foreign_key: "loggable_id", foreign_type: "Instance"
  belongs_to :app, foreign_key: "loggable_id", foreign_type: "App"

  SEVERITY = %w(info warn error fatal).freeze

  validates :severity, :message, presence: true
  validates_inclusion_of :severity, in: SEVERITY

  delegate :name, to: :loggable
  def at
    created_at
  end
end

class Log < ActiveRecord::Base
  update_index 'logs#log', :self

  belongs_to :loggable, polymorphic: true, touch: true
  belongs_to :instance, foreign_key: "loggable_id", foreign_type: "Instance"
  belongs_to :app, foreign_key: "loggable_id", foreign_type: "App"

  SEVERITY = %w(info warn error fatal).freeze

  validates :severity, :message, presence: true
  validates_inclusion_of :severity, in: SEVERITY


  scope :by_task, -> (task_id) {
    order(created_at: :desc).includes(:instance)
      .where(instances: { task_id: task_id })
  }
  scope :date, -> (date) {
    where(created_at: date.beginning_of_day..date.end_of_day)
  }
  scope :range, -> (from, to) {
    where(created_at: from.beginning_of_day..to.end_of_day)
  }

  delegate :name, to: :loggable
  def at
    created_at
  end
end

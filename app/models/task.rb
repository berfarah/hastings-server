require "ext/standard_deviation"

class Task < ActiveRecord::Base
  include Searchable
  include ScriptUpload
  include Dispatcher

  # after_touch :publish_to_redis
  # after_save :publish_to_redis

  SCALAR = %w(days hours minutes seconds).freeze

  # !group Relationships
  has_many :instances, dependent: :destroy
  has_many :last_instance, -> { reverse_order.limit(1) },
                              class_name: "Instance"
  # !endgroup

  # !group Validations
  validates :name, presence: true
  validates :interval, numericality: true, presence: true
  validates :scalar, inclusion: { in: SCALAR }, presence: true
  validate :run_at_validation

  # @return [Fixnum] seconds
  def run_every
    interval.to_i.send(scalar.to_sym)
  end

  delegate :url, to: :script, prefix: true

  def runtime
    @runtime ||= Runtime.new(self)
  end

  def failed?
    instances.last.try(:failed)
  end

  def running?
    instances.last.try(:job_id)
  end

  def stats
    @stats ||= Statistics.new(self)
  end

  def last_run
    @last_run ||= instances.last.try(:started_at)
  end

  def to_param
    @to_param ||= "#{id} #{name}".parameterize.freeze
  end

  # def as_indexed_json(_options = {})
  #   as_json methods: [:name, :last_run, :run_every, :script]
  # end

  # def as_json(_options = {})
  #   {
  #     id: id,
  #     name: name,
  #     script: { url: script.url },
  #     interval: interval,
  #     scalar: scalar,
  #     enabled: enabled,
  #     running: running?,
  #     failed: failed?
  #   }
  # end

  protected

    # def publish_to_redis
    #   Redis.new.publish("tasks.touch", to_json)
    # end

  private

    def run_at_validation
      return if run_at.nil? || run_at.empty?
      Time.zone.parse(run_at)
    rescue ArgumentError
      errors.add(:run_at, "is not a valid time")
    end
end

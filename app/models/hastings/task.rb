require "hastings/ext/standard_deviation"

module Hastings
  class Task < ActiveRecord::Base
    include Searchable
    # !group Callbacks
    # Reference: https://github.com/carrierwaveuploader/carrierwave#skipping-activerecord-callbacks
    #
    # We can only update the schedule once the file has been stored (after_save)
    # On that note, we want to unschedule before the record is destroyed so the
    # script can't run when we're deleting it.
    after_save :update_scheduled
    before_destroy :unschedule
    # !endgroup

    # !group Relationships
    has_many :instances
    mount_uploader :script, ScriptUploader
    # !endgroup

    # !group Validations
    validates :name, presence: true
    validates :external, inclusion: { in: [true, false] }

    # Internal scripts need a file and an interval/scalar
    with_options if: :internal do
      validate :script_validation
      validates :scalar, presence: true
      validates :scalar, inclusion: { in: %w(days hours minutes seconds) }
      validates_format_of :interval, with: /\d+/
      validate :run_at_validation
    end

    # External scripts need an IP
    with_options(if: :external) do
      validates :ip, presence: true, format: /\b(?:\d{1,3}\.){3}\d{1,3}\b/
    end
    # !endgroup

    # !group Attributes
    # Whether a script is internal or external
    #
    # @return [Boolean]
    def internal
      !external
    end

    # @return [Fixnum] seconds
    def run_every
      interval.to_i.send(scalar.to_sym)
    end

    # Average and Standard Deviation runtimes
    #
    # @return [Array<Fixnum, Fixnum>] Mean, Standard Deviation
    def runtime
      last_10 = instances.last(10).map(&:duration).compact
      return last_10 if last_10.empty?
      [last_10.mean.ceil.human_time, last_10.standard_deviation.human_time]
    end

    # For external logging, uses last instance or creates a new one to log to
    #
    # @param [Hash] params Hash containing `severity` and `message` for log
    # @return [Hastings::Log]
    def external_log(params)
      (instances.last || instances.create).logs.new(params)
    end
    # !endgroup

    private

      def update_scheduled
        return unless internal && changed?
        return unschedule unless enabled
        Hastings::Recurring::Script.schedule(schedule_opts)
      end

      def unschedule
        Hastings::Recurring::Script.unschedule(schedule_opts)
      end

      def schedule_opts
        { task: self, run_at: Time.parse(run_at), run_every: run_every,
          script: script.path, queue: "#{name.parameterize}_#{id}" }
      end

      def script_validation
        return if !script_changed? || command_line_validation(script)
        errors.add(:script, 'does not pass validation')
      end

      def run_at_validation
        return if run_at.nil? || run_at.empty?
        Time.parse(run_at)
      rescue ArgumentError
        errors.add(:run_at, 'is not a valid time')
      end

      def command_line_validation(script)
        case script.filename
        when /\.rb$/ then system("ruby -wc #{script.path}")
        when /\.sh$/ then system("bash -n #{script.path}")
        else false
        end
      end
  end
end

require "hastings/ext/standard_deviation"

module Hastings
  class Task < ActiveRecord::Base
    include Searchable
    include JobManagement

    SCALAR = %w(days hours minutes seconds).freeze

    # !group Relationships
    has_many :instances
    mount_uploader :script, ScriptUploader
    # !endgroup

    # !group Validations
    validates_presence_of :name, :scalar
    validates_numericality_of :interval
    validates :scalar, inclusion: { in: SCALAR }
    validate :run_at_validation
    validate :script_validation

    # @return [Fixnum] seconds
    def run_every
      interval.to_i.send(scalar.to_sym)
    end

    # Average and Standard Deviation runtimes
    #
    # @return [Array<Fixnum, Fixnum>] Mean, Standard Deviation
    def runtime
      last_20 = instances.last(20).map(&:duration).compact
      return [nil, nil] if last_20.empty?
      [last_20.mean.ceil, last_20.standard_deviation]
    end

    def last_run
      instances.last.try(:started_at) || "N/A"
    end

    def to_param
      "#{id} #{name}".parameterize
    end

    private

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

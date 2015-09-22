module Hastings
  # Tasker's scheduled emailer tied to the model
  class ScheduledMailer < ApplicationMailer
    default from: ENV['EMAIL_FROM']

    def fatal(recipients, error, subject = 'Fatal Error from Tasker')
      return false unless error.is_a? StandardError
      @error = error
      mail to: recipients, subject: subject
    end

    def errors(recipients, subject = 'Daily Error Log from Tasker')
      @errors = Logs.where(created_at: 1.day.ago..Time.now, severity: 'error')
      return false if @errors.empty?
      mail to: recipients, subject: subject << " (#{@errors.length})"
    end

    def failed(recipients, subject = 'Hourly Failed report from Tasker')
      @failed = Instance.where(created_at: 1.hour.ago..Time.now, failed: true)
      return false if @failed.empty?
      mail to: recipients, subject: subject << " (#{@failed.length})"
    end
  end
end

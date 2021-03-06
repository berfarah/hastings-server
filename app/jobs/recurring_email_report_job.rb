# Recurring Emails
class RecurringEmailReportJob
  include RecurringJobConcern

  def initialize(options = {})
    @recipients = options.delete(:recipients)
    @report     = options.delete(:report)
    @subject    = options.delete(:subject)
  end

  def perform
    ScheduledMailer.send(@report.to_sym, @recipients, @subject).deliver_now
  end
end

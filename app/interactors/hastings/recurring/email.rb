module Hastings
  module Recurring
    # Recurring Emails
    class Email < Base
      def initialize(options = {})
        @recipients = options.delete(:recipients)
        @report     = options.delete(:report)
        @subject    = options.delete(:subject)
      end

      def perform
        ScheduledMailer.send(@report.to_sym, @recipients, @subject).deliver_now
      end
    end
  end
end
